// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "./NimbleStructs.sol";
import "./INimbleEvents.sol";

interface INimble is INimbleEvents {
    function getPredictionFeed(
        string memory entityAddress
    )
        external
        payable
        returns (NimbleStructs.PredictionFeed memory predictionFeed);

    function updatePredictionFeeds(
        bytes[] calldata updateData
    ) external payable;
}
