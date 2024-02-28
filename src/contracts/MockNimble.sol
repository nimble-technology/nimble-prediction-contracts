// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "./AbstractNimble.sol";
import "./NimbleErrors.sol";
import "./NimbleGovernance.sol";

contract MockNimble is AbstractNimble, NimbleGovernance {
    mapping(string => NimbleStructs.PredictionFeed) predictionFeeds;
    uint64 sequenceNumber;
    uint64 chainId;

    constructor(
        uint64 chainId_,
        uint64 getActionfee_,
        uint64 updateActionfee_
    ) {
        require(chainId_ > 0, "invalid chainId");
        require(getActionfee_ >= 0, "invalid getActionfee");
        require(updateActionfee_ >= 0, "invalid updateActionfee");
        owner = msg.sender;
        chainId = chainId_;
        getActionfee = getActionfee_;
        updateActionfee = updateActionfee_;
    }

    function getPredictionFeed(
        string memory entityAddress
    )
        public
        payable
        override
        returns (NimbleStructs.PredictionFeed memory predictionFeed)
    {
        require(msg.value >= getActionfee, "insufficient value");
        if (bytes(predictionFeeds[entityAddress].entityAddress).length == 0) {
            revert NimbleErrors.PredictionFeedNotFound();
        }
        return predictionFeeds[entityAddress];
    }

    // Takes an array of encoded price feeds and stores them.
    // You can create this data either by calling createPriceFeedData or
    // by using web3.js or ethers abi utilities.
    function updatePredictionFeeds(
        bytes[] calldata updateData
    ) public payable override onlyOwner {
        require(
            msg.value >= updateActionfee * updateData.length,
            "insufficient value"
        );
        for (uint i = 0; i < updateData.length; i++) {
            NimbleStructs.PredictionFeed memory predictionFeed = abi.decode(
                updateData[i],
                (NimbleStructs.PredictionFeed)
            );

            uint lastPublishTime = predictionFeeds[predictionFeed.entityAddress]
                .prediction
                .publishTime;

            if (lastPublishTime < predictionFeed.prediction.publishTime) {
                predictionFeeds[predictionFeed.entityAddress] = predictionFeed;
                emit PredictionFeedUpdate(
                    predictionFeed.entityAddress,
                    uint8(predictionFeed.entity),
                    predictionFeed.prediction.publishTime,
                    predictionFeed.prediction.tags,
                    predictionFeed.prediction.reputationScore,
                    predictionFeed.model.modelID,
                    predictionFeed.model.modelName
                );
            }
        }

        emit BatchPredictionFeedUpdate(chainId, sequenceNumber);
        sequenceNumber += 1;
    }
}
