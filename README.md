# Personal Manager App

A comprehensive personal management application built with React, TypeScript, and modern web technologies.

## 🏗️ Project Structure

```
personal-manager-app/
├── client/                 # Frontend React application
│   ├── public/            # Static assets
│   ├── src/
│   │   ├── components/    # Reusable UI components
│   │   ├── features/      # Feature-based modules
│   │   ├── hooks/         # Custom React hooks
│   │   ├── services/      # API services
│   │   ├── store/         # State management
│   │   ├── types/         # TypeScript types
│   │   ├── utils/         # Utility functions
│   │   └── App.tsx        # Root component
│   └── package.json
├── server/                # Backend Node.js application
│   ├── src/
│   │   ├── config/        # Configuration files
│   │   ├── controllers/   # Request handlers
│   │   ├── models/        # Database models
│   │   ├── routes/        # API routes
│   │   ├── middleware/    # Custom middleware
│   │   ├── services/      # Business logic
│   │   └── server.ts      # Server entry point
│   └── package.json
└── README.md
```

## 🎯 Why This Structure?

### Feature-Based Architecture
- **Scalability**: Each feature is self-contained with its own components, hooks, and logic
- **Maintainability**: Easy to locate and modify feature-specific code
- **Team Collaboration**: Multiple developers can work on different features simultaneously

### Separation of Concerns
- **Client/Server Split**: Clear boundary between frontend and backend
- **Layer Architecture**: Components → Hooks → Services → API
- **Type Safety**: TypeScript throughout for better DX and fewer bugs

## 🚀 Getting Started

### Prerequisites
- Node.js 18+ and npm
- Git

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/personal-manager-app.git
cd personal-manager-app
```

2. **Install client dependencies**
```bash
cd client
npm install
```

3. **Install server dependencies**
```bash
cd ../server
npm install
```

4. **Set up environment variables**
```bash
# In server directory
cp .env.example .env
# Edit .env with your configuration
```

### Running the Application

**Development Mode:**

Terminal 1 - Start Backend:
```bash
cd server
npm run dev
```

Terminal 2 - Start Frontend:
```bash
cd client
npm run dev
```

The app will be available at:
- Frontend: http://localhost:5173
- Backend API: http://localhost:3000

**Production Build:**
```bash
# Build frontend
cd client
npm run build

# Start production server
cd ../server
npm start
```

## 📦 Available Scripts

### Client
- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run preview` - Preview production build
- `npm run lint` - Run ESLint
- `npm run type-check` - Run TypeScript compiler check

### Server
- `npm run dev` - Start development server with hot reload
- `npm start` - Start production server
- `npm run build` - Compile TypeScript
- `npm run lint` - Run ESLint
- `npm test` - Run tests

## 🛠️ Tech Stack

### Frontend
- **React 18**: UI library
- **TypeScript**: Type safety
- **Vite**: Build tool and dev server
- **Tailwind CSS**: Utility-first CSS
- **Lucide React**: Icon library
- **Zustand**: State management

### Backend
- **Node.js**: Runtime environment
- **Express**: Web framework
- **TypeScript**: Type safety
- **MongoDB/PostgreSQL**: Database (choose one)
- **JWT**: Authentication
- **Zod**: Validation

## 📁 Detailed Directory Structure

### Client Structure
```
client/src/
├── components/
│   ├── common/          # Shared components (Button, Card, Modal)
│   ├── layout/          # Layout components (Header, Navigation)
│   └── ui/              # Base UI components
├── features/
│   ├── auth/            # Authentication feature
│   ├── notes/           # Notes management
│   ├── tasks/           # Task management
│   ├── goals/           # Goals tracking
│   ├── expenses/        # Expense tracking
│   └── habits/          # Habit tracking
├── hooks/
│   ├── useAuth.ts       # Authentication hook
│   ├── useLocalStorage.ts
│   └── useTheme.ts
├── services/
│   ├── api.ts           # API client configuration
│   └── endpoints/       # API endpoint functions
├── store/
│   ├── authStore.ts     # Auth state
│   ├── notesStore.ts    # Notes state
│   └── settingsStore.ts # Settings state
├── types/
│   ├── auth.types.ts
│   ├── notes.types.ts
│   └── index.ts
└── utils/
    ├── constants.ts
    ├── formatters.ts
    └── validators.ts
```

### Server Structure
```
server/src/
├── config/
│   ├── database.ts      # DB configuration
│   └── env.ts           # Environment variables
├── controllers/
│   ├── authController.ts
│   ├── notesController.ts
│   └── tasksController.ts
├── models/
│   ├── User.ts
│   ├── Note.ts
│   └── Task.ts
├── routes/
│   ├── authRoutes.ts
│   ├── notesRoutes.ts
│   └── index.ts
├── middleware/
│   ├── auth.ts          # JWT verification
│   ├── errorHandler.ts
│   └── validator.ts
├── services/
│   ├── authService.ts
│   └── notesService.ts
└── server.ts
```

## 🔐 Environment Variables

### Server (.env)
```
PORT=3000
NODE_ENV=development
DATABASE_URL=your_database_url
JWT_SECRET=your_jwt_secret
JWT_EXPIRES_IN=7d
```

### Client (.env)
```
VITE_API_URL=http://localhost:3000/api
```

## 🌐 API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - User login
- `GET /api/auth/profile` - Get user profile

### Notes
- `GET /api/notes` - Get all notes
- `POST /api/notes` - Create note
- `PUT /api/notes/:id` - Update note
- `DELETE /api/notes/:id` - Delete note

### Tasks
- `GET /api/tasks` - Get all tasks
- `POST /api/tasks` - Create task
- `PUT /api/tasks/:id` - Update task
- `DELETE /api/tasks/:id` - Delete task

## 🧪 Testing

```bash
# Run all tests
npm test

# Run tests with coverage
npm run test:coverage

# Run tests in watch mode
npm run test:watch
```

## 📝 Code Style

- **Prettier**: Code formatting
- **ESLint**: Code linting
- **Husky**: Git hooks for pre-commit checks

## 🚢 Deployment

### Frontend (Vercel/Netlify)
```bash
cd client
npm run build
# Deploy dist/ folder
```

### Backend (Railway/Render/Heroku)
```bash
cd server
npm run build
# Deploy with start script
```

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License.

## 👥 Authors

Your Name - [@yourhandle](https://twitter.com/yourhandle)

## 🙏 Acknowledgments

- Lucide Icons for beautiful icons
- Tailwind CSS for styling
- React community for amazing tools
