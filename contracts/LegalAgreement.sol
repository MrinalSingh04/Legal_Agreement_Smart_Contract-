// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract LegalAgreement {
    address public partyA;
    address public partyB;
    string public agreementTerms;
    uint256 public penaltyAmount;
    bool public isSignedByA;
    bool public isSignedByB;
    bool public isBreached;
    address public breachedBy;

    enum AgreementState { Pending, Active, Breached, Completed }
    AgreementState public currentState;

    modifier onlyParties() {
        require(msg.sender == partyA || msg.sender == partyB, "Not authorized");
        _;
    }

    constructor(
        address _partyB,
        string memory _agreementTerms,
        uint256 _penaltyAmount
    ) payable {
        require(msg.value == _penaltyAmount, "Penalty must be escrowed by Party A");
        partyA = msg.sender;
        partyB = _partyB;
        agreementTerms = _agreementTerms;
        penaltyAmount = _penaltyAmount;
        currentState = AgreementState.Pending;
    }

    function signAgreement() external onlyParties {
        if (msg.sender == partyA) {
            isSignedByA = true;
        } else if (msg.sender == partyB) {
            isSignedByB = true;
        }

        if (isSignedByA && isSignedByB) {
            currentState = AgreementState.Active;
        }
    }

    function reportBreach(address _offender) external onlyParties {
        require(currentState == AgreementState.Active, "Agreement not active");
        require(_offender == partyA || _offender == partyB, "Invalid offender");

        isBreached = true;
        breachedBy = _offender;
        currentState = AgreementState.Breached;

        address beneficiary = _offender == partyA ? partyB : partyA;
        payable(beneficiary).transfer(penaltyAmount);
    }

    function markCompleted() external onlyParties {
        require(currentState == AgreementState.Active, "Not in active state");
        currentState = AgreementState.Completed;
        payable(partyA).transfer(penaltyAmount);
    }

    function getStatus() external view returns (string memory) {
        if (currentState == AgreementState.Pending) return "Pending Signatures";
        if (currentState == AgreementState.Active) return "Active";
        if (currentState == AgreementState.Breached) return "Breached";
        if (currentState == AgreementState.Completed) return "Completed";
        return "Unknown";
    }
}
