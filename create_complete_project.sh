#!/bin/bash

echo "🚀 Creating Complete Personal Manager App Structure..."

# Create .gitignore
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
.pnp
.pnp.js

# Testing
coverage/

# Production
build/
dist/

# Environment variables
.env
.env.local
.env.*.local

# Logs
*.log
npm-debug.log*

# Editor directories and files
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# TypeScript
*.tsbuildinfo
EOF

# ============= SERVER FILES =============

# Server TypeScript Config
cat > server/tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "moduleResolution": "node",
    "types": ["node"]
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
EOF

# Server .env.example
cat > server/.env.example << 'EOF'
PORT=3000
NODE_ENV=development

# Database
DATABASE_URL=mongodb://localhost:27017/personal-manager

# JWT
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
JWT_EXPIRES_IN=7d

# CORS
CORS_ORIGIN=http://localhost:5173
EOF

# Server main file
cat > server/src/server.ts << 'EOF'
import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { connectDatabase } from './config/database';
import routes from './routes';
import { errorHandler } from './middleware/errorHandler';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors({
  origin: process.env.CORS_ORIGIN || 'http://localhost:5173',
  credentials: true,
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.use('/api', routes);

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', message: 'Server is running' });
});

// Error handling
app.use(errorHandler);

// Start server
const startServer = async () => {
  try {
    await connectDatabase();
    app.listen(PORT, () => {
      console.log(`🚀 Server running on http://localhost:${PORT}`);
      console.log(`📝 Environment: ${process.env.NODE_ENV}`);
    });
  } catch (error) {
    console.error('❌ Failed to start server:', error);
    process.exit(1);
  }
};

startServer();
EOF

# Database config
cat > server/src/config/database.ts << 'EOF'
import mongoose from 'mongoose';

export const connectDatabase = async (): Promise<void> => {
  try {
    const dbUrl = process.env.DATABASE_URL || 'mongodb://localhost:27017/personal-manager';
    
    await mongoose.connect(dbUrl);
    
    console.log('✅ Database connected successfully');
  } catch (error) {
    console.error('❌ Database connection failed:', error);
    throw error;
  }
};

mongoose.connection.on('disconnected', () => {
  console.log('⚠️  Database disconnected');
});

mongoose.connection.on('error', (error) => {
  console.error('❌ Database error:', error);
});
EOF

# Error Handler Middleware
cat > server/src/middleware/errorHandler.ts << 'EOF'
import { Request, Response, NextFunction } from 'express';

export interface ApiError extends Error {
  statusCode?: number;
  isOperational?: boolean;
}

export const errorHandler = (
  err: ApiError,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const statusCode = err.statusCode || 500;
  const message = err.message || 'Internal Server Error';

  console.error(`[ERROR] ${statusCode}: ${message}`);
  console.error(err.stack);

  res.status(statusCode).json({
    success: false,
    error: message,
    ...(process.env.NODE_ENV === 'development' && { stack: err.stack }),
  });
};

export class AppError extends Error implements ApiError {
  statusCode: number;
  isOperational: boolean;

  constructor(message: string, statusCode: number = 500) {
    super(message);
    this.statusCode = statusCode;
    this.isOperational = true;
    Error.captureStackTrace(this, this.constructor);
  }
}
EOF

# Auth Middleware
cat > server/src/middleware/auth.ts << 'EOF'
import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { AppError } from './errorHandler';

export interface AuthRequest extends Request {
  user?: {
    id: string;
    userId: string;
  };
}

export const authMiddleware = (
  req: AuthRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    const token = req.headers.authorization?.replace('Bearer ', '');

    if (!token) {
      throw new AppError('No token provided', 401);
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET!) as any;
    req.user = decoded;
    next();
  } catch (error) {
    next(new AppError('Invalid token', 401));
  }
};
EOF

# User Model
cat > server/src/models/User.ts << 'EOF'
import mongoose, { Document, Schema } from 'mongoose';

export interface IUser extends Document {
  userId: string;
  pin: string;
  displayName: string;
  createdAt: Date;
  updatedAt: Date;
}

const UserSchema = new Schema<IUser>(
  {
    userId: {
      type: String,
      required: true,
      unique: true,
      trim: true,
    },
    pin: {
      type: String,
      required: true,
    },
    displayName: {
      type: String,
      required: true,
    },
  },
  {
    timestamps: true,
  }
);

export default mongoose.model<IUser>('User', UserSchema);
EOF

# Note Model
cat > server/src/models/Note.ts << 'EOF'
import mongoose, { Document, Schema } from 'mongoose';

export interface INote extends Document {
  userId: string;
  title: string;
  content: string;
  category: 'Personal' | 'Official' | 'Work' | 'Ideas';
  icon: string;
  createdAt: Date;
  updatedAt: Date;
}

const NoteSchema = new Schema<INote>(
  {
    userId: {
      type: String,
      required: true,
      index: true,
    },
    title: {
      type: String,
      required: true,
    },
    content: {
      type: String,
      required: true,
    },
    category: {
      type: String,
      enum: ['Personal', 'Official', 'Work', 'Ideas'],
      required: true,
    },
    icon: {
      type: String,
      default: '📝',
    },
  },
  {
    timestamps: true,
  }
);

export default mongoose.model<INote>('Note', NoteSchema);
EOF

# Routes index
cat > server/src/routes/index.ts << 'EOF'
import { Router } from 'express';

const router = Router();

// Health check
router.get('/health', (req, res) => {
  res.json({ 
    success: true, 
    message: 'API is running',
    timestamp: new Date().toISOString()
  });
});

// Placeholder for feature routes
// Import and use routes here as you build them:
// import authRoutes from './authRoutes';
// import notesRoutes from './notesRoutes';
// router.use('/auth', authRoutes);
// router.use('/notes', notesRoutes);

export default router;
EOF

echo "✅ Server structure created!"

# ============= CLIENT COMPLETION =============

# Main CSS file
cat > client/src/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  * {
    @apply border-border;
  }
  
  body {
    @apply bg-white dark:bg-slate-900 text-gray-900 dark:text-white;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
      'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
      sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
  }
}

@layer utilities {
  .glass-card {
    @apply backdrop-blur-xl bg-white/80 dark:bg-slate-800/80 border border-gray-200/50 dark:border-slate-700/50;
  }
  
  .glass-bottom-nav {
    @apply backdrop-blur-xl bg-white/90 dark:bg-slate-800/90 border-t border-gray-200/50 dark:border-slate-700/50;
  }
}
EOF

# Main entry point
cat > client/src/main.tsx << 'EOF'
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOF

# Simplified App component
cat > client/src/App.tsx << 'EOF'
import React, { useState } from 'react';
import { useTheme } from '@hooks';

function App() {
  const { theme, toggleTheme } = useTheme();
  const [message, setMessage] = useState('Welcome to Personal Manager App!');

  return (
    <div className="min-h-screen flex items-center justify-center p-4">
      <div className="max-w-2xl w-full space-y-6">
        <div className="glass-card p-8 rounded-3xl">
          <h1 className="text-4xl font-bold mb-4">🚀 Personal Manager</h1>
          <p className="text-lg text-gray-600 dark:text-gray-300 mb-6">
            {message}
          </p>
          
          <div className="flex gap-4">
            <button
              onClick={toggleTheme}
              className="px-6 py-3 bg-blue-600 text-white rounded-xl font-semibold hover:bg-blue-700 transition"
            >
              Toggle Theme ({theme})
            </button>
            
            <button
              onClick={() => setMessage('App is working! Start building features.')}
              className="px-6 py-3 bg-purple-600 text-white rounded-xl font-semibold hover:bg-purple-700 transition"
            >
              Test Button
            </button>
          </div>

          <div className="mt-8 p-4 bg-blue-50 dark:bg-blue-900/20 rounded-xl">
            <h2 className="font-semibold mb-2">📁 Project Structure Created!</h2>
            <ul className="text-sm space-y-1 text-gray-700 dark:text-gray-300">
              <li>✅ TypeScript configuration</li>
              <li>✅ Tailwind CSS setup</li>
              <li>✅ Custom hooks</li>
              <li>✅ API services</li>
              <li>✅ Type definitions</li>
              <li>✅ Server API structure</li>
            </ul>
          </div>
        </div>

        <div className="text-center text-sm text-gray-500 dark:text-gray-400">
          <p>Check README.md and DEPLOYMENT_GUIDE.md for next steps</p>
        </div>
      </div>
    </div>
  );
}

export default App;
EOF

# Vite svg
mkdir -p client/public
cat > client/public/vite.svg << 'EOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 128">
  <defs>
    <linearGradient id="a" x1="6" y1="106" x2="122" y2="106" gradientUnits="userSpaceOnUse">
      <stop offset="0" style="stop-color:#41d1ff"/>
      <stop offset="1" style="stop-color:#bd34fe"/>
    </linearGradient>
  </defs>
  <path fill="url(#a)" d="M89.4 9.4L50.7 14 36.5 97.6l26.4 20.3L94.6 99 108.2 21.4z"/>
  <path fill="#ffba00" d="M57.9 14.2L22 18.8 14.7 79.1l29.9 23.5L68.8 92.2 75.7 36.8z"/>
</svg>
EOF

echo "✅ Client structure completed!"

# Create QUICK_START guide
cat > QUICK_START.md << 'EOF'
# 🚀 Quick Start Guide

## Immediate Next Steps

### 1. Install Dependencies

**Frontend:**
```bash
cd client
npm install
```

**Backend:**
```bash
cd server
npm install
```

### 2. Set Up Environment Variables

**Client:**
```bash
cd client
cp .env.example .env
```

**Server:**
```bash
cd server
cp .env.example .env
```
Edit `server/.env` with your database credentials.

### 3. Start Development

**Terminal 1 - Backend:**
```bash
cd server
npm run dev
```

**Terminal 2 - Frontend:**
```bash
cd client
npm run dev
```

### 4. Open Browser
Navigate to: http://localhost:5173

## What's Included?

✅ Complete project structure
✅ TypeScript configuration  
✅ Tailwind CSS setup
✅ Custom React hooks
✅ API service layer
✅ Type definitions
✅ Server structure
✅ Authentication middleware
✅ Database models

## Next Steps

1. **Add Your Original Component**: 
   - Copy your original `personal_manager_app.tsx` logic
   - Split it into feature modules in `client/src/features/`

2. **Build API Endpoints**:
   - Add controllers in `server/src/controllers/`
   - Add routes in `server/src/routes/`

3. **Connect to Database**:
   - Set up MongoDB or PostgreSQL
   - Update DATABASE_URL in server/.env

4. **Deploy**:
   - See DEPLOYMENT_GUIDE.md for full instructions

## Need Help?

- 📖 Check `README.md` for detailed docs
- 📚 Read `DEPLOYMENT_GUIDE.md` for deployment
- 🐛 Issues? Check the troubleshooting section

Happy Coding! 🎉
EOF

echo "📝 Documentation created!"
echo ""
echo "✨ Project structure is complete!"
echo ""
echo "📁 Next steps:"
echo "1. cd client && npm install"
echo "2. cd server && npm install"
echo "3. Read QUICK_START.md"
echo ""

