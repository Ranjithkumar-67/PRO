#!/bin/bash

# This script generates all remaining client files

cd /home/claude/personal-manager-app/client

# Create useDebounce hook
cat > src/hooks/useDebounce.ts << 'EOF'
import { useState, useEffect } from 'react';

/**
 * Custom hook for debouncing values
 */
export function useDebounce<T>(value: T, delay: number = 500): T {
  const [debouncedValue, setDebouncedValue] = useState<T>(value);

  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(value);
    }, delay);

    return () => {
      clearTimeout(handler);
    };
  }, [value, delay]);

  return debouncedValue;
}
EOF

# Create index for hooks
cat > src/hooks/index.ts << 'EOF'
export * from './useLocalStorage';
export * from './useTheme';
export * from './useNotification';
export * from './useDebounce';
EOF

echo "Hooks created successfully"

