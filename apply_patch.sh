#!/usr/bin/env bash

echo '{"cmd":["apply_patch","*** Begin Patch
*** Add File: packages/supabase/package.json
+{
+  "name": "@workspace/supabase",
+  "version": "0.0.0",
+  "type": "module",
+  "private": true,
+  "main": "src/index.ts",
+  "types": "src/index.ts",
+  "scripts": {
+    "test": "jest"
+  },
+  "dependencies": {
+    "@supabase/supabase-js": "^2.0.0"
+  },
+  "devDependencies": {
+    "@workspace/typescript-config": "workspace:*",
+    "typescript": "^5.7.3",
+    "jest": "^29.5.0",
+    "ts-jest": "^29.1.0",
+    "@types/jest": "^29.5.0"
+  }
+}
*** End Patch

*** Begin Patch
*** Add File: packages/supabase/tsconfig.json
+{
+  "extends": "@workspace/typescript-config/base.json",
+  "include": ["src"],
+  "compilerOptions": {
+    "outDir": "dist",
+    "rootDir": "src"
+  }
+}
*** End Patch

*** Begin Patch
*** Add File: packages/supabase/jest.config.cjs
+module.exports = {
+  preset: 'ts-jest',
+  testEnvironment: 'node',
+  roots: ['<rootDir>/src'],
+  transform: {
+    '^.+\\.ts$': 'ts-jest'
+  },
+  moduleFileExtensions: ['ts', 'js', 'json'],
+  testRegex: '(/__tests__/.*|(\\.|/)(test|spec))\\.tsx?$',
+  globals: {
+    'ts-jest': {
+      tsconfig: 'tsconfig.json'
+    }
+  }
+};
*** End Patch

*** Begin Patch
*** Add File: packages/supabase/src/client.ts
+import { createClient, SupabaseClient } from '@supabase/supabase-js';
+
+const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
+const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
+
+if (!supabaseUrl || !supabaseAnonKey) {
+  throw new Error('Missing NEXT_PUBLIC_SUPABASE_URL or NEXT_PUBLIC_SUPABASE_ANON_KEY environment variables');
+}
+
+export const supabaseClient: SupabaseClient = createClient(supabaseUrl, supabaseAnonKey);
*** End Patch

*** Begin Patch
*** Add File: packages/supabase/src/server.ts
+import { createClient, SupabaseClient } from '@supabase/supabase-js';
+
+const supabaseUrl = process.env.SUPABASE_URL;
+const supabaseServiceKey = process.env.SUPABASE_SERVICE_KEY;
+
+if (!supabaseUrl || !supabaseServiceKey) {
+  throw new Error('Missing SUPABASE_URL or SUPABASE_SERVICE_KEY environment variables');
+}
+
+export const supabaseServerClient: SupabaseClient = createClient(supabaseUrl, supabaseServiceKey);
*** End Patch

*** Begin Patch
*** Add File: packages/supabase/src/fetchTest.ts
+import { supabaseServerClient } from './server';
+
+export async function fetchTestData(): Promise<any[]> {
+  const { data, error } = await supabaseServerClient.from('test').select('*');
+  if (error) {
+    throw error;
+  }
+  return data || [];
+}
*** End Patch

*** Begin Patch
*** Add File: packages/supabase/src/__tests__/fetchTest.test.ts
+import { supabaseServerClient } from '../server';
+import { fetchTestData } from '../fetchTest';
+
+jest.mock('../server', () => ({
+  supabaseServerClient: {
+    from: jest.fn().mockReturnThis(),
+    select: jest.fn()
+  }
+}));
+
+describe('fetchTestData', () => {
+  beforeEach(() => {
+    jest.clearAllMocks();
+  });
+
+  it('should return data when no error', async () => {
+    const mockData = [{ id: 1, value: 'test' }];
+    (supabaseServerClient.select as jest.Mock).mockResolvedValue({ data: mockData, error: null });
+    const data = await fetchTestData();
+    expect(supabaseServerClient.from).toHaveBeenCalledWith('test');
+    expect(data).toEqual(mockData);
+  });
+
+  it('should throw error when fetch returns error', async () => {
+    const mockError = new Error('Fetch error');
+    (supabaseServerClient.select as jest.Mock).mockResolvedValue({ data: null, error: mockError });
+    await expect(fetchTestData()).rejects.toThrow('Fetch error');
+  });
+});
*** End Patch
"}';
