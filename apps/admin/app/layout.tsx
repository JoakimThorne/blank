import { Geist, Geist_Mono } from "next/font/google"

import "@workspace/ui/globals.css"
import { Providers } from "@/components/providers"
import ThemeToggle from "@/components/theme-toggle"

const fontSans = Geist({
  subsets: ["latin"],
  variable: "--font-sans",
})

const fontMono = Geist_Mono({
  subsets: ["latin"],
  variable: "--font-mono",
})

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body className={`${fontSans.variable} ${fontMono.variable} font-sans antialiased`}>
        <Providers>
          <div className="flex flex-col min-h-screen">
            <header className="flex items-center justify-between px-6 py-4 bg-background text-foreground shadow">
              <h1 className="text-2xl font-bold">Admin Panel</h1>
              <ThemeToggle />
            </header>
            <main className="flex-grow">{children}</main>
          </div>
        </Providers>
      </body>
    </html>
  )
}
