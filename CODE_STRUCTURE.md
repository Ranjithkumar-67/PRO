# 📁 Complete Code Structure Documentation

## Table of Contents
1. [Overview](#overview)
2. [Directory Structure](#directory-structure)
3. [File-by-File Explanation](#file-by-file-explanation)
4. [How Data Flows](#how-data-flows)
5. [Adding New Features](#adding-new-features)

---

## Overview

This project follows a **professional full-stack architecture** with:
- **Frontend**: React + TypeScript + Tailwind CSS (Feature-based)
- **Backend**: Node.js + Express + TypeScript (Layered architecture)
- **State Management**: Zustand (lightweight, simple)
- **API Communication**: Axios with interceptors
- **Authentication**: JWT tokens
- **Database**: MongoDB with Mongoose (easily swappable)

---

## Directory Structure

```
personal-manager-app/
├── client/                          # Frontend React Application
│   ├── public/                      # Static assets
│   │   └── vite.svg                # Favicon
│   ├── src/
│   │   ├── components/             # Reusable UI components
│   │   │   ├── common/             # Shared components (Button, Card, Modal)
│   │   │   ├── layout/             # Layout components (Header, Footer, Nav)
│   │   │   └── ui/                 # Base UI primitives
│   │   ├── features/               # Feature modules (MOST IMPORTANT)
│   │   │   ├── auth/               # Authentication feature
│   │   │   ├── notes/              # Notes management
│   │   │   ├── tasks/              # Tasks management
│   │   │   ├── goals/              # Goals tracking
│   │   │   ├── expenses/           # Expense tracking
│   │   │   └── habits/             # Habit tracking
│   │   ├── hooks/                  # Custom React hooks
│   │   │   ├── useLocalStorage.ts  # localStorage management
│   │   │   ├── useTheme.ts         # Theme management
│   │   │   ├── useNotification.ts  # Browser notifications
│   │   │   ├── useDebounce.ts      # Debounce hook
│   │   │   └── index.ts            # Export all hooks
│   │   ├── services/               # API communication layer
│   │   │   ├── api.ts              # Axios client configuration
│   │   │   ├── endpoints/          # API endpoint functions
│   │   │   │   ├── auth.service.ts
│   │   │   │   ├── notes.service.ts
│   │   │   │   ├── tasks.service.ts
│   │   │   │   ├── goals.service.ts
│   │   │   │   ├── expenses.service.ts
│   │   │   │   └── habits.service.ts
│   │   │   └── index.ts
│   │   ├── store/                  # Global state management (Zustand)
│   │   │   ├── authStore.ts
│   │   │   ├── notesStore.ts
│   │   │   └── settingsStore.ts
│   │   ├── types/                  # TypeScript type definitions
│   │   │   ├── auth.types.ts
│   │   │   ├── notes.types.ts
│   │   │   ├── tasks.types.ts
│   │   │   ├── goals.types.ts
│   │   │   ├── expenses.types.ts
│   │   │   ├── habits.types.ts
│   │   │   └── index.ts            # Re-export all types
│   │   ├── utils/                  # Utility functions
│   │   │   ├── constants.ts        # App constants
│   │   │   ├── formatters.ts       # Formatting functions
│   │   │   ├── validators.ts       # Validation functions
│   │   │   └── helpers.ts          # Helper functions
│   │   ├── App.tsx                 # Root component
│   │   ├── main.tsx                # Entry point
│   │   └── index.css               # Global styles
│   ├── .env.example                # Environment variables template
│   ├── index.html                  # HTML entry point
│   ├── package.json                # Dependencies and scripts
│   ├── postcss.config.js           # PostCSS configuration
│   ├── tailwind.config.js          # Tailwind CSS configuration
│   ├── tsconfig.json               # TypeScript configuration
│   ├── tsconfig.node.json          # TypeScript Node configuration
│   └── vite.config.ts              # Vite build configuration
│
├── server/                         # Backend Node.js Application
│   ├── src/
│   │   ├── config/                 # Configuration files
│   │   │   └── database.ts         # Database connection
│   │   ├── controllers/            # Request handlers
│   │   │   ├── authController.ts
│   │   │   ├── notesController.ts
│   │   │   └── tasksController.ts
│   │   ├── middleware/             # Express middleware
│   │   │   ├── auth.ts             # JWT verification
│   │   │   └── errorHandler.ts     # Error handling
│   │   ├── models/                 # Database models (Mongoose)
│   │   │   ├── User.ts
│   │   │   ├── Note.ts
│   │   │   └── Task.ts
│   │   ├── routes/                 # API route definitions
│   │   │   ├── authRoutes.ts
│   │   │   ├── notesRoutes.ts
│   │   │   └── index.ts            # Main router
│   │   ├── services/               # Business logic layer
│   │   │   ├── authService.ts
│   │   │   └── notesService.ts
│   │   ├── utils/                  # Utility functions
│   │   └── server.ts               # Server entry point
│   ├── .env.example                # Environment variables template
│   ├── package.json                # Dependencies and scripts
│   └── tsconfig.json               # TypeScript configuration
│
├── .gitignore                      # Git ignore patterns
├── README.md                       # Main documentation
├── DEPLOYMENT_GUIDE.md             # Deployment instructions
├── QUICK_START.md                  # Quick start guide
└── CODE_STRUCTURE.md               # This file
```

---

## File-by-File Explanation

### 🎨 CLIENT FILES

#### Configuration Files

**`client/package.json`**
- Lists all frontend dependencies (React, TypeScript, Vite, etc.)
- Defines npm scripts: `dev`, `build`, `preview`, `lint`
- **Purpose**: Package manager configuration

**`client/vite.config.ts`**
- Configures Vite build tool
- Sets up path aliases (`@components`, `@hooks`, etc.)
- Configures proxy for API calls
- **Purpose**: Build and development server configuration

**`client/tsconfig.json`**
- TypeScript compiler options
- Path mappings for imports
- **Purpose**: Type checking and compilation rules

**`client/tailwind.config.js`**
- Tailwind CSS configuration
- Custom colors, animations, utilities
- **Purpose**: Styling framework setup

**`client/postcss.config.js`**
- PostCSS plugins (Tailwind, Autoprefixer)
- **Purpose**: CSS processing

#### Entry Points

**`client/index.html`**
- HTML template
- Loads the React app via `<script src="/src/main.tsx">`
- **Purpose**: Entry HTML file

**`client/src/main.tsx`**
```typescript
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
```
- **Purpose**: Mounts React app to DOM

**`client/src/App.tsx`**
- Root component
- Sets up routing, theme, global state
- **Purpose**: Main application component

**`client/src/index.css`**
- Tailwind directives (@tailwind base, components, utilities)
- Custom global styles
- **Purpose**: Global CSS

#### Type Definitions (`client/src/types/`)

**Why separate types?**
- Type safety across the application
- Single source of truth for data structures
- Easy to update and maintain

**`auth.types.ts`**
```typescript
export interface User {
  id: string;
  userId: string;
  displayName: string;
  createdAt: string;
}

export interface LoginCredentials {
  userId: string;
  pin: string;
}
// ... more auth-related types
```
- **Purpose**: Authentication data structures

**`notes.types.ts`**, **`tasks.types.ts`**, etc.
- Each feature has its own type definitions
- Includes interfaces for entities, create/update inputs, state
- **Purpose**: Type safety for specific features

**`index.ts`**
- Re-exports all types from one place
- **Purpose**: Centralized type exports

#### Utilities (`client/src/utils/`)

**`constants.ts`**
```typescript
export const API_BASE_URL = import.meta.env.VITE_API_URL;
export const STORAGE_KEYS = {
  AUTH_TOKEN: 'pm_auth_token',
  USER_DATA: 'pm_user_data',
  // ...
};
export const DAILY_QUOTES = [/* ... */];
```
- **Purpose**: Application-wide constants

**`formatters.ts`**
```typescript
export const formatCurrency = (amount: number): string => {
  return new Intl.NumberFormat('en-IN', {
    style: 'currency',
    currency: 'INR',
  }).format(amount);
};
// ... more formatters
```
- **Purpose**: Data formatting functions

**`validators.ts`**
```typescript
export const validateUserId = (userId: string) => {
  if (userId.length < 2) {
    return { valid: false, error: 'Too short' };
  }
  return { valid: true };
};
// ... more validators
```
- **Purpose**: Input validation logic

**`helpers.ts`**
- Utility functions: `debounce`, `throttle`, `deepClone`, etc.
- **Purpose**: General helper functions

#### Custom Hooks (`client/src/hooks/`)

**Why custom hooks?**
- Reusable logic across components
- Separation of concerns
- Cleaner components

**`useLocalStorage.ts`**
```typescript
export function useLocalStorage<T>(key: string, initialValue: T) {
  const [storedValue, setStoredValue] = useState<T>(() => {
    const item = window.localStorage.getItem(key);
    return item ? JSON.parse(item) : initialValue;
  });
  // ... logic to sync with localStorage
  return [storedValue, setStoredValue];
}
```
- **Purpose**: Persist state to localStorage

**`useTheme.ts`**
- Manages dark/light theme
- Syncs with localStorage and DOM
- **Purpose**: Theme management

**`useNotification.ts`**
- Handles browser notifications
- Requests permission, shows notifications
- **Purpose**: Notification system

**`useDebounce.ts`**
- Delays updates until user stops typing
- **Purpose**: Performance optimization

#### Services (`client/src/services/`)

**Why service layer?**
- Centralized API calls
- Easy to mock for testing
- Consistent error handling

**`api.ts`**
```typescript
import axios from 'axios';

const apiClient = axios.create({
  baseURL: API_BASE_URL,
  timeout: 10000,
});

// Add auth token to requests
apiClient.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) config.headers.Authorization = `Bearer ${token}`;
  return config;
});

// Handle 401 errors
apiClient.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      // Redirect to login
    }
    return Promise.reject(error);
  }
);

export { apiClient };
```
- **Purpose**: Configured HTTP client

**`endpoints/notes.service.ts`**
```typescript
export const notesService = {
  getAll: () => apiClient.get('/notes'),
  getById: (id) => apiClient.get(`/notes/${id}`),
  create: (note) => apiClient.post('/notes', note),
  update: (id, note) => apiClient.put(`/notes/${id}`, note),
  delete: (id) => apiClient.delete(`/notes/${id}`),
};
```
- **Purpose**: Notes API endpoints

Similar for `auth.service.ts`, `tasks.service.ts`, etc.

#### State Management (`client/src/store/`)

**Why Zustand?**
- Simpler than Redux
- No boilerplate
- Great TypeScript support

**`authStore.ts`**
```typescript
import create from 'zustand';

interface AuthState {
  user: User | null;
  token: string | null;
  login: (credentials) => Promise<void>;
  logout: () => void;
}

export const useAuthStore = create<AuthState>((set) => ({
  user: null,
  token: null,
  login: async (credentials) => {
    const response = await authService.login(credentials);
    set({ user: response.user, token: response.token });
  },
  logout: () => set({ user: null, token: null }),
}));
```
- **Purpose**: Global authentication state

#### Features (`client/src/features/`)

**Why feature-based structure?**
- Each feature is self-contained
- Easy to find related code
- Scalable architecture

**Example: `features/notes/`**
```
notes/
├── components/
│   ├── NoteCard.tsx        # Display a note
│   ├── NoteList.tsx        # List of notes
│   ├── AddNoteModal.tsx    # Form to add note
│   └── NoteFilters.tsx     # Filter controls
├── hooks/
│   └── useNotes.ts         # Notes logic
└── index.ts                # Export public API
```

**`notes/hooks/useNotes.ts`**
```typescript
export function useNotes() {
  const [notes, setNotes] = useState<Note[]>([]);
  const [loading, setLoading] = useState(false);

  const loadNotes = async () => {
    setLoading(true);
    const data = await notesService.getAll();
    setNotes(data);
    setLoading(false);
  };

  const createNote = async (note: CreateNoteInput) => {
    const newNote = await notesService.create(note);
    setNotes([...notes, newNote]);
  };

  useEffect(() => { loadNotes(); }, []);

  return { notes, loading, createNote, /* ... */ };
}
```
- **Purpose**: Encapsulates notes logic

**`notes/components/NoteCard.tsx`**
```typescript
interface Props {
  note: Note;
  onDelete: (id: number) => void;
}

export function NoteCard({ note, onDelete }: Props) {
  return (
    <div className="glass-card p-4 rounded-xl">
      <h3>{note.title}</h3>
      <p>{note.content}</p>
      <button onClick={() => onDelete(note.id)}>Delete</button>
    </div>
  );
}
```
- **Purpose**: Reusable note display component

---

### 🖥️ SERVER FILES

#### Configuration

**`server/package.json`**
- Backend dependencies (Express, MongoDB, JWT, etc.)
- Scripts: `dev`, `build`, `start`
- **Purpose**: Package management

**`server/tsconfig.json`**
- TypeScript compiler for Node.js
- **Purpose**: Server-side type checking

**`server/.env.example`**
```
PORT=3000
DATABASE_URL=mongodb://localhost:27017/personal-manager
JWT_SECRET=super-secret-key
```
- **Purpose**: Environment variable template

#### Entry Point

**`server/src/server.ts`**
```typescript
import express from 'express';
import cors from 'cors';
import routes from './routes';
import { errorHandler } from './middleware/errorHandler';
import { connectDatabase } from './config/database';

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api', routes);

// Error handling
app.use(errorHandler);

// Start
const start = async () => {
  await connectDatabase();
  app.listen(3000, () => console.log('Server running'));
};

start();
```
- **Purpose**: Express server setup

#### Configuration (`server/src/config/`)

**`database.ts`**
```typescript
import mongoose from 'mongoose';

export const connectDatabase = async () => {
  try {
    await mongoose.connect(process.env.DATABASE_URL!);
    console.log('✅ Database connected');
  } catch (error) {
    console.error('❌ DB connection failed');
    throw error;
  }
};
```
- **Purpose**: Database connection logic

#### Middleware (`server/src/middleware/`)

**Why middleware?**
- Runs before route handlers
- Used for auth, logging, error handling

**`auth.ts`**
```typescript
import jwt from 'jsonwebtoken';

export const authMiddleware = (req, res, next) => {
  const token = req.headers.authorization?.replace('Bearer ', '');
  
  if (!token) {
    return res.status(401).json({ error: 'No token' });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET!);
    req.user = decoded;
    next();
  } catch (error) {
    res.status(401).json({ error: 'Invalid token' });
  }
};
```
- **Purpose**: Verify JWT tokens

**`errorHandler.ts`**
```typescript
export const errorHandler = (err, req, res, next) => {
  const statusCode = err.statusCode || 500;
  res.status(statusCode).json({
    success: false,
    error: err.message,
    ...(process.env.NODE_ENV === 'development' && { stack: err.stack }),
  });
};
```
- **Purpose**: Centralized error handling

#### Models (`server/src/models/`)

**Why models?**
- Define data structure
- Handle database operations
- Validate data

**`User.ts`**
```typescript
import mongoose from 'mongoose';

const UserSchema = new mongoose.Schema({
  userId: { type: String, required: true, unique: true },
  pin: { type: String, required: true },
  displayName: { type: String, required: true },
}, { timestamps: true });

export default mongoose.model('User', UserSchema);
```
- **Purpose**: User data structure

**`Note.ts`**, **`Task.ts`**, etc.
- Each entity has its own model
- Defines schema, validation, indexes
- **Purpose**: Data layer

#### Controllers (`server/src/controllers/`)

**Why controllers?**
- Handle HTTP requests/responses
- Validate input
- Call services

**`notesController.ts`**
```typescript
export const notesController = {
  getAll: async (req, res, next) => {
    try {
      const notes = await notesService.getAll(req.user.id);
      res.json({ success: true, data: notes });
    } catch (error) {
      next(error);
    }
  },

  create: async (req, res, next) => {
    try {
      const note = await notesService.create(req.body, req.user.id);
      res.status(201).json({ success: true, data: note });
    } catch (error) {
      next(error);
    }
  },
  // ... more methods
};
```
- **Purpose**: Request handlers

#### Services (`server/src/services/`)

**Why services?**
- Business logic
- Reusable across controllers
- Easier to test

**`notesService.ts`**
```typescript
export const notesService = {
  getAll: async (userId: string) => {
    return await Note.find({ userId });
  },

  create: async (data, userId: string) => {
    const note = new Note({ ...data, userId });
    await note.save();
    return note;
  },
  // ... more business logic
};
```
- **Purpose**: Business logic layer

#### Routes (`server/src/routes/`)

**Why separate routes?**
- Clean organization
- Easy to see all endpoints
- Modular structure

**`notesRoutes.ts`**
```typescript
import { Router } from 'express';
import { notesController } from '../controllers/notesController';
import { authMiddleware } from '../middleware/auth';

const router = Router();

router.get('/', authMiddleware, notesController.getAll);
router.post('/', authMiddleware, notesController.create);
router.put('/:id', authMiddleware, notesController.update);
router.delete('/:id', authMiddleware, notesController.delete);

export default router;
```
- **Purpose**: Define API endpoints

**`index.ts`**
```typescript
import { Router } from 'express';
import authRoutes from './authRoutes';
import notesRoutes from './notesRoutes';

const router = Router();

router.use('/auth', authRoutes);
router.use('/notes', notesRoutes);

export default router;
```
- **Purpose**: Combine all routes

---

## How Data Flows

### Creating a Note (Complete Flow)

**1. User Action (Frontend)**
```
User clicks "Add Note" button
  ↓
Opens AddNoteModal component
  ↓
User fills form and clicks "Save"
```

**2. Component Handler**
```typescript
const handleSubmit = async () => {
  await createNote({ title, content, category, icon });
};
```

**3. Hook/Store**
```typescript
const createNote = async (data) => {
  const note = await notesService.create(data);
  setNotes([...notes, note]);
};
```

**4. Service (API Call)**
```typescript
export const notesService = {
  create: (data) => apiClient.post('/notes', data)
};
```

**5. Backend Route**
```typescript
router.post('/notes', authMiddleware, notesController.create);
```

**6. Middleware (Auth)**
```typescript
// Verify JWT token
// Attach user to request
```

**7. Controller**
```typescript
export const create = async (req, res, next) => {
  const note = await notesService.create(req.body, req.user.id);
  res.json(note);
};
```

**8. Service (Business Logic)**
```typescript
export const create = async (data, userId) => {
  const note = new Note({ ...data, userId });
  await note.save();
  return note;
};
```

**9. Model (Database)**
```typescript
// Mongoose saves to MongoDB
```

**10. Response Back**
```
Database → Service → Controller → Response → Frontend
```

---

## Adding New Features

### Example: Adding "Reminders" Feature

**Step 1: Frontend Types**
```bash
# Create client/src/types/reminders.types.ts

export interface Reminder {
  id: number;
  title: string;
  time: string;
  recurring: boolean;
}
```

**Step 2: Frontend Service**
```bash
# Create client/src/services/endpoints/reminders.service.ts

export const remindersService = {
  getAll: () => apiClient.get('/reminders'),
  create: (data) => apiClient.post('/reminders', data),
};
```

**Step 3: Frontend Feature Module**
```bash
# Create client/src/features/reminders/

features/reminders/
├── components/
│   ├── ReminderCard.tsx
│   └── AddReminderModal.tsx
├── hooks/
│   └── useReminders.ts
└── index.ts
```

**Step 4: Backend Model**
```bash
# Create server/src/models/Reminder.ts

const ReminderSchema = new Schema({
  userId: String,
  title: String,
  time: Date,
  recurring: Boolean,
});
```

**Step 5: Backend Controller**
```bash
# Create server/src/controllers/remindersController.ts

export const remindersController = {
  getAll: async (req, res) => { /* ... */ },
  create: async (req, res) => { /* ... */ },
};
```

**Step 6: Backend Routes**
```bash
# Create server/src/routes/remindersRoutes.ts

router.get('/', authMiddleware, remindersController.getAll);
router.post('/', authMiddleware, remindersController.create);
```

**Step 7: Register Routes**
```typescript
// In server/src/routes/index.ts
import remindersRoutes from './remindersRoutes';
router.use('/reminders', remindersRoutes);
```

**Done!** New feature integrated seamlessly.

---

## Best Practices

### Frontend
- ✅ Keep components small and focused
- ✅ Use custom hooks for logic
- ✅ Type everything with TypeScript
- ✅ Use Tailwind for styling
- ✅ Keep API calls in services

### Backend
- ✅ Validate all inputs
- ✅ Use middleware for auth
- ✅ Keep controllers thin
- ✅ Business logic in services
- ✅ Proper error handling

### General
- ✅ Consistent naming conventions
- ✅ Comments for complex logic
- ✅ Test new features
- ✅ Git commits after each feature
- ✅ Follow the established patterns

---

## Questions?

- **"Where do I add a new page?"** → Create component in `features/` or `components/layout/`
- **"Where do I add API call?"** → `services/endpoints/`
- **"Where do I add types?"** → `types/`
- **"Where do I add utilities?"** → `utils/`
- **"How do I add backend endpoint?"** → Model → Service → Controller → Route

**Remember**: Follow the patterns established in existing code!

Happy Coding! 🚀
