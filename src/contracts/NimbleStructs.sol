// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

contract NimbleStructs {
    // A prediction is scores and tags associated with an entity.
    struct Prediction {
        string[] tags;
        // Unix timestamp describing when the prediction was published
        uint64 publishTime;
        int64 reputationScore;
    }

    struct Model {
        // unique identifier for this model type
        uint8 modelID;
        // model description
        string modelName;
    }

    enum Entity {
        WALLET,
        TOKEN,
        PROTOCOL
    }

    // PredictionFeed represents a current entity prediction
    struct PredictionFeed {
        // The entity address.
        string entityAddress;
        Entity entity;
        Prediction prediction;
        Model model;
    }
}
