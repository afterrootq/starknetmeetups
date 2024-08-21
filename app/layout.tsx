import './global.css'
import { Inter } from 'next/font/google'
import { Providers } from './providers'
import { DynamicWidget } from '@dynamic-labs/sdk-react-core'

const inter = Inter({ subsets: ['latin'] })

export default function RootLayout({
    children,
}: Readonly<{
    children: React.ReactNode
}>) {
    return (
        <html lang="en">
            <Providers>
                <body className={inter.className}>
                    <header className="flex items-center h-16 px-4 border-b-2 border-blue-800 sticky">
                        <div className="flex items-center">
                            <a href="/" className="block">
                                <img src="/logo.png" alt="StarknetMeetups" className="h-8 w-auto fill-current" />
                            </a>
                        </div>
                        <nav className="flex"></nav>
                        <span className="ml-auto align-right justify-end"></span>
                        <span className="align-right justify-end"><DynamicWidget /></span>
                    </header>
                    <div>{children}</div>
                </body>
            </Providers>
        </html>
    )
}
