// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

/// @title INimbleEvents contains the events that Nimble contract emits.
/// @dev This interface can be used for listening to the updates for off-chain and testing purposes.
interface INimbleEvents {
    /// @dev Emitted when the prediction feed with `entityAddress` has received a fresh update.
    /// @param entityAddress The Nimble Prediction Feed EntityAddress.
    /// @param entityType Entity Type of the given EntityAddress, 0, 1, 2...
    /// @param publishTime Publish time of the given price update.
    event PredictionFeedUpdate(
        string indexed entityAddress,
        uint8 entityType,
        uint64 publishTime,
        string[] tags,
        int64 reputationScore,
        uint8 modelID,
        string modelName
    );

    event BatchPredictionFeedUpdate(uint64 chainId, uint64 sequenceNumber);

    event NimbleGetActionFeeUpdate(uint64 oldFee, uint64 newFee);

    event NimbleUpdateActionFeeUpdate(uint64 oldFee, uint64 newFee);
}
