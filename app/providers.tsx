'use client'

import { type State } from 'wagmi'
import type { ReactNode } from 'react'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { DynamicContextProvider } from '@dynamic-labs/sdk-react-core'
import { StarknetWalletConnectors } from '@dynamic-labs/starknet'

import { sepolia } from '@starknet-react/chains'
import { argent, braavos } from '@starknet-react/core'
import { StarknetConfig, publicProvider } from '@starknet-react/core'

type Props = {
    children: ReactNode
    initialState?: State | undefined
}

export function Providers({ children }: Props) {
    return (
        <StarknetConfig
            chains={[sepolia]}
            provider={publicProvider()}
            connectors={[braavos(), argent()]}
        >
            <DynamicContextProvider
                settings={{
                    environmentId: process.env.NEXT_PUBLIC_DYNAMIC_ENV_ID || '',
                    walletConnectors: [StarknetWalletConnectors],
                }}
            >
                <QueryClientProvider client={new QueryClient()}>{children}</QueryClientProvider>
            </DynamicContextProvider>
        </StarknetConfig>
    )
}
