import { ethers } from "ethers";

import {
  BNB_ENDPOINT,
  USER_WALLET_PRIVATE_KEY,
  BNB_CONTRACT,
} from "../../constants/constants";

const nimbleAbi = require("../../abis/MockNimble.json");

const providerLocal = new ethers.providers.JsonRpcProvider(BNB_ENDPOINT);
//私钥
const privateKey = USER_WALLET_PRIVATE_KEY;
const wallet = new ethers.Wallet(privateKey, providerLocal);
//读写合约
const ContractAddress = BNB_CONTRACT;
const ContractAbi = nimbleAbi;
const _Contract = new ethers.Contract(ContractAddress, ContractAbi, wallet);

const main = async () => {
  let prediction = await _Contract.getPredictionFeed(
    "0x8B38Da6a701c568545dCfcB03FcB875f56beddC8"
  );
  console.log("prediction:", prediction);
};
main();
