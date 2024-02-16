import { ethers } from "ethers";
import {
  BNB_ENDPOINT,
  USER_WALLET_PRIVATE_KEY,
  BNB_CONTRACT,
} from "../../constants/constants";

// constants
const nimbleAbi = require("../../abis/MockNimble.json");
const fs = require("fs");
const providerLocal = new ethers.providers.JsonRpcProvider(BNB_ENDPOINT);
const privateKey = USER_WALLET_PRIVATE_KEY;
const wallet = new ethers.Wallet(privateKey, providerLocal);

// update
const ContractAddress = BNB_CONTRACT;
const ContractAbi = nimbleAbi;
const _Contract = new ethers.Contract(ContractAddress, ContractAbi, wallet);
const filePath = "/prediction.csv";

const main = async () => {
  var csvstr = fs.readFileSync(__dirname + filePath).toString();
  var updateData = csvstr.split("\n");
  await _Contract.updatePredictionFeeds(updateData);
  console.log("updatePredictionFeeds suc");
};
main();
