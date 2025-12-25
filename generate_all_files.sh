#!/bin/bash

cd /home/claude/personal-manager-app/client

# ============= API SERVICE FILES =============

# API Client
cat > src/services/api.ts << 'EOF'
import axios, { AxiosInstance, AxiosError } from 'axios';
import { API_BASE_URL, API_TIMEOUT, STORAGE_KEYS } from '@utils/constants';

class ApiClient {
  private client: AxiosInstance;

  constructor() {
    this.client = axios.create({
      baseURL: API_BASE_URL,
      timeout: API_TIMEOUT,
      headers: {
        'Content-Type': 'application/json',
      },
    });

    // Request interceptor
    this.client.interceptors.request.use(
      (config) => {
        const token = localStorage.getItem(STORAGE_KEYS.AUTH_TOKEN);
        if (token) {
          config.headers.Authorization = `Bearer ${token}`;
        }
        return config;
      },
      (error) => Promise.reject(error)
    );

    // Response interceptor
    this.client.interceptors.response.use(
      (response) => response,
      (error: AxiosError) => {
        if (error.response?.status === 401) {
          // Clear auth and redirect to login
          localStorage.removeItem(STORAGE_KEYS.AUTH_TOKEN);
          localStorage.removeItem(STORAGE_KEYS.USER_DATA);
          window.location.href = '/';
        }
        return Promise.reject(error);
      }
    );
  }

  getInstance(): AxiosInstance {
    return this.client;
  }
}

export const apiClient = new ApiClient().getInstance();
EOF

# Auth Service
cat > src/services/endpoints/auth.service.ts << 'EOF'
import { apiClient } from '../api';
import type { LoginCredentials, RegisterCredentials, AuthResponse, User } from '@types';

export const authService = {
  login: async (credentials: LoginCredentials): Promise<AuthResponse> => {
    const response = await apiClient.post('/auth/login', credentials);
    return response.data;
  },

  register: async (credentials: RegisterCredentials): Promise<AuthResponse> => {
    const response = await apiClient.post('/auth/register', credentials);
    return response.data;
  },

  getProfile: async (): Promise<User> => {
    const response = await apiClient.get('/auth/profile');
    return response.data;
  },

  logout: async (): Promise<void> => {
    await apiClient.post('/auth/logout');
  },
};
EOF

# Notes Service
cat > src/services/endpoints/notes.service.ts << 'EOF'
import { apiClient } from '../api';
import type { Note, CreateNoteInput, UpdateNoteInput } from '@types';

export const notesService = {
  getAll: async (): Promise<Note[]> => {
    const response = await apiClient.get('/notes');
    return response.data;
  },

  getById: async (id: number): Promise<Note> => {
    const response = await apiClient.get(`/notes/${id}`);
    return response.data;
  },

  create: async (note: CreateNoteInput): Promise<Note> => {
    const response = await apiClient.post('/notes', note);
    return response.data;
  },

  update: async (id: number, note: Partial<CreateNoteInput>): Promise<Note> => {
    const response = await apiClient.put(`/notes/${id}`, note);
    return response.data;
  },

  delete: async (id: number): Promise<void> => {
    await apiClient.delete(`/notes/${id}`);
  },
};
EOF

# Tasks Service
cat > src/services/endpoints/tasks.service.ts << 'EOF'
import { apiClient } from '../api';
import type { Task, CreateTaskInput, UpdateTaskInput } from '@types';

export const tasksService = {
  getAll: async (): Promise<Task[]> => {
    const response = await apiClient.get('/tasks');
    return response.data;
  },

  getById: async (id: number): Promise<Task> => {
    const response = await apiClient.get(`/tasks/${id}`);
    return response.data;
  },

  create: async (task: CreateTaskInput): Promise<Task> => {
    const response = await apiClient.post('/tasks', task);
    return response.data;
  },

  update: async (id: number, task: Partial<UpdateTaskInput>): Promise<Task> => {
    const response = await apiClient.put(`/tasks/${id}`, task);
    return response.data;
  },

  delete: async (id: number): Promise<void> => {
    await apiClient.delete(`/tasks/${id}`);
  },

  toggleComplete: async (id: number): Promise<Task> => {
    const response = await apiClient.patch(`/tasks/${id}/toggle`);
    return response.data;
  },
};
EOF

# Goals Service
cat > src/services/endpoints/goals.service.ts << 'EOF'
import { apiClient } from '../api';
import type { Goal, CreateGoalInput, UpdateGoalInput } from '@types';

export const goalsService = {
  getAll: async (): Promise<Goal[]> => {
    const response = await apiClient.get('/goals');
    return response.data;
  },

  create: async (goal: CreateGoalInput): Promise<Goal> => {
    const response = await apiClient.post('/goals', goal);
    return response.data;
  },

  update: async (id: number, goal: Partial<UpdateGoalInput>): Promise<Goal> => {
    const response = await apiClient.put(`/goals/${id}`, goal);
    return response.data;
  },

  delete: async (id: number): Promise<void> => {
    await apiClient.delete(`/goals/${id}`);
  },
};
EOF

# Expenses Service
cat > src/services/endpoints/expenses.service.ts << 'EOF'
import { apiClient } from '../api';
import type { Expense, CreateExpenseInput, UpdateExpenseInput, ExpenseStats } from '@types';

export const expensesService = {
  getAll: async (): Promise<Expense[]> => {
    const response = await apiClient.get('/expenses');
    return response.data;
  },

  create: async (expense: CreateExpenseInput): Promise<Expense> => {
    const response = await apiClient.post('/expenses', expense);
    return response.data;
  },

  update: async (id: number, expense: Partial<UpdateExpenseInput>): Promise<Expense> => {
    const response = await apiClient.put(`/expenses/${id}`, expense);
    return response.data;
  },

  delete: async (id: number): Promise<void> => {
    await apiClient.delete(`/expenses/${id}`);
  },

  getStats: async (): Promise<ExpenseStats> => {
    const response = await apiClient.get('/expenses/stats');
    return response.data;
  },
};
EOF

# Habits Service
cat > src/services/endpoints/habits.service.ts << 'EOF'
import { apiClient } from '../api';
import type { Habit, CreateHabitInput, UpdateHabitInput } from '@types';

export const habitsService = {
  getAll: async (): Promise<Habit[]> => {
    const response = await apiClient.get('/habits');
    return response.data;
  },

  create: async (habit: CreateHabitInput): Promise<Habit> => {
    const response = await apiClient.post('/habits', habit);
    return response.data;
  },

  update: async (id: number, habit: Partial<UpdateHabitInput>): Promise<Habit> => {
    const response = await apiClient.put(`/habits/${id}`, habit);
    return response.data;
  },

  delete: async (id: number): Promise<void> => {
    await apiClient.delete(`/habits/${id}`);
  },

  toggleComplete: async (id: number): Promise<Habit> => {
    const response = await apiClient.patch(`/habits/${id}/toggle`);
    return response.data;
  },
};
EOF

# Services Index
cat > src/services/index.ts << 'EOF'
export * from './api';
export * from './endpoints/auth.service';
export * from './endpoints/notes.service';
export * from './endpoints/tasks.service';
export * from './endpoints/goals.service';
export * from './endpoints/expenses.service';
export * from './endpoints/habits.service';
EOF

echo "API Services created"

