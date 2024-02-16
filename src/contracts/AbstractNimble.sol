// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "./INimble.sol";

abstract contract AbstractNimble is INimble {
    function updatePredictionFeeds(
        bytes[] calldata updateData
    ) public payable virtual override;

    function getPredictionFeed(
        string memory entityAddress
    )
        public
        payable
        virtual
        override
        returns (NimbleStructs.PredictionFeed memory predictionFeed);
}
