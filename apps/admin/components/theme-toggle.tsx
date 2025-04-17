"use client";

import { Button } from "@workspace/ui/components/button";
import { Moon, Sun } from "lucide-react";
import { useTheme } from "next-themes";
import * as React from "react";

export default function ThemeToggle() {
  const { theme, setTheme } = useTheme();
  const [mounted, setMounted] = React.useState(false);

  React.useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) {
    return null;
  }

  const isDark = theme === "dark";

  return (
    <Button
      variant="ghost"
      size="icon"
      onClick={() => setTheme(isDark ? "light" : "dark")}
    >
      {isDark ? <Sun /> : <Moon />}
    </Button>
  );
}
