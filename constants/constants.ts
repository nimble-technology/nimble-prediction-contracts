const main_config = require("../config/mainnet_config.json");

// private keys
export const USER_WALLET_PRIVATE_KEY = main_config.userWalletPrivateKey;

// endpoints
export const ARBITRUM_ENDPOINT = main_config.endPoints.Arbitrum;
export const AVAX_ENDPOINT = main_config.endPoints.Avalanche;
export const BNB_ENDPOINT = main_config.endPoints.Binance;
export const ETHEREUM_ENDPOINT = main_config.endPoints.Ethereum;
export const OPTIMISM_ENDPOINT = main_config.endPoints.Optimism;
export const POLYGON_ENDPOINT = main_config.endPoints.Polygon;

// contracts
export const BNB_CONTRACT = main_config.contracts.Binance;
export const ARBITRUM_CONTRACT = main_config.contracts.Arbitrum;
export const AVAX_CONTRACT = main_config.contracts.Avalanche;
export const ETHEREUM_CONTRACT = main_config.contracts.Ethereum;
export const OPTIMISM_CONTRACT = main_config.contracts.Optimism;
export const POLYGON_CONTRACT = main_config.contracts.Polygon;
