import yargs from "yargs";
import { hideBin } from "yargs/helpers";
import { ethers } from "ethers";
import {
  BNB_ENDPOINT,
  USER_WALLET_PRIVATE_KEY,
  ARBITRUM_ENDPOINT,
  AVAX_ENDPOINT,
  ETHEREUM_ENDPOINT,
  OPTIMISM_ENDPOINT,
  POLYGON_ENDPOINT,
  BNB_CONTRACT,
  ARBITRUM_CONTRACT,
  AVAX_CONTRACT,
  ETHEREUM_CONTRACT,
  OPTIMISM_CONTRACT,
  POLYGON_CONTRACT,
} from "../../constants/constants";

function sleep(ms: number) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

const argv = yargs(hideBin(process.argv))
  .option("network", {
    description:
      "Network to relay on(string). e.g: Arbitrum/Avalanche/Binance/Ethereum/Optimism/Polygon",
    type: "string",
    required: false,
    default: "Binance",
  })
  .option("address", {
    description:
      "entity address for the prediction service(string). e.g: 0x8B38Da6a701c568545dCfcB03FcB875f56beddC8",
    type: "string",
    required: true,
  })
  .option("data", {
    description:
      "data for the prediction service(array), must be encode. e.g: 0x0000000...",
    type: "array",
    required: true,
  })
  .help()
  .alias("help", "h")
  .parserConfiguration({
    "parse-numbers": false,
  })
  .parseSync();

let endPoints: string;
let contractAddr: string;
if (argv.network === "Arbitrum") {
  endPoints = ARBITRUM_ENDPOINT;
  contractAddr = ARBITRUM_CONTRACT;
} else if (argv.network === "Avalanche") {
  endPoints = AVAX_ENDPOINT;
  contractAddr = AVAX_CONTRACT;
} else if (argv.network === "Binance") {
  endPoints = BNB_ENDPOINT;
  contractAddr = BNB_CONTRACT;
} else if (argv.network === "Ethereum") {
  endPoints = ETHEREUM_ENDPOINT;
  contractAddr = ETHEREUM_CONTRACT;
} else if (argv.network === "Optimism") {
  endPoints = OPTIMISM_ENDPOINT;
  contractAddr = OPTIMISM_CONTRACT;
} else if (argv.network === "Polygon") {
  endPoints = POLYGON_ENDPOINT;
  contractAddr = POLYGON_CONTRACT;
} else {
  throw new Error("network does not support");
}

const nimbleAbi = require("../../abis/MockNimble.json");
const providerLocal = new ethers.providers.JsonRpcProvider(endPoints);
const privateKey = USER_WALLET_PRIVATE_KEY;
const wallet = new ethers.Wallet(privateKey, providerLocal);

// update
const ContractAddress = contractAddr;
const ContractAbi = nimbleAbi;
const _Contract = new ethers.Contract(ContractAddress, ContractAbi, wallet);

const main = async () => {
  await _Contract.updatePredictionFeeds(argv.data as string[]);
  console.log("updatePredictionFeeds suc");
  await sleep(15000);
  let prediction = await _Contract.getPredictionFeed(argv.address);
  console.log("prediction:", prediction);
};
main();
