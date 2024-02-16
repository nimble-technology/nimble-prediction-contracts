// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;
import "./INimbleEvents.sol";

contract NimbleGovernance is INimbleEvents {
    address owner;
    uint64 getActionfee;
    uint64 updateActionfee;

    function updateFeeForGetPrediction(uint64 fee) public onlyOwner {
        require(fee >= 0, "fee must be >= 0");
        require(fee != getActionfee, "fee must be != old fee");

        uint64 oldFee = getActionfee;
        getActionfee = fee;

        emit NimbleGetActionFeeUpdate(oldFee, getActionfee);
    }

    function updateFeeForUpdatePrediction(uint64 fee) public onlyOwner {
        require(fee >= 0, "fee must be >= 0");
        require(fee != getActionfee, "fee must be != old fee");

        uint64 oldFee = updateActionfee;
        updateActionfee = fee;

        emit NimbleUpdateActionFeeUpdate(oldFee, updateActionfee);
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "caller not the owner");
        _;
    }
}
