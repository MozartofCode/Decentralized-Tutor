// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

/**
 * @title Tutor
 * @dev Stores the Tutors and handles certain interactions between students and tutors
 */
contract Tutor {

    struct TutorPerson {
        string name;
        uint256 balance;
        string[] classesTaught;
        bool[7] daysAvailable; // True if available that day False if not
        address wallet;
    }

    mapping(address => TutorPerson) public tutors;
    address[] public tutorAddresses;

    event Received(address from, uint256 amount);

    function receiveMoney(uint256 _amount, address _adr) public {
        tutors[_adr].balance += _amount;
        emit Received(msg.sender, _amount);
    }


    // Function to check if an address is in the tutorAddresses array
    function isTutorAddress(address _address) public view returns (bool) {
        for (uint i = 0; i < tutorAddresses.length; i++) {
            if (tutorAddresses[i] == _address) {
                return true;
            }
        }
        return false;
    }    

    function isTutorName(string memory _name) public view returns (bool) {
    for (uint i = 0; i < tutorAddresses.length; i++) {
        if (keccak256(bytes(tutors[tutorAddresses[i]].name)) == keccak256(bytes(_name))) {
            return true;
        }
    }
    return false;
}


    function getTutor(string memory _name) public view returns (TutorPerson memory) {
        for (uint i = 0; i < tutorAddresses.length; i++) {
            if (keccak256(bytes(tutors[tutorAddresses[i]].name)) == keccak256(bytes(_name))) {
                return tutors[tutorAddresses[i]];
            }
        }
        revert("Tutor not found");
    }


    function addOrUpdateTutor(string memory _name, uint256 _balance, string[] memory _classesTaught, bool[7] memory _daysAvailable, address _adr ) public {
        if (!isTutorAddress(_adr)) {
            tutorAddresses.push(_adr);
        }

        tutors[_adr] = TutorPerson(_name, _balance, _classesTaught, _daysAvailable, _adr);
    }


    function getBalance(address _adr) public view returns(uint256) {
        return tutors[_adr].balance;
    }    

    // Day is the index of the day (0-indexed where 0 being monday and 6 being sunday)
    function getAvailableTutors(uint256 _day) public view returns (TutorPerson[] memory) {
        
        uint numTutor = 0;
        
        for (uint i = 0; i < tutorAddresses.length; i++) {
            if (tutors[tutorAddresses[i]].daysAvailable[_day]) {
                numTutor += 1;
            }
        }

        TutorPerson[] memory tutorList = new TutorPerson[](numTutor);
        
        for (uint i = 0; i < tutorAddresses.length; i++) {
            if (tutors[tutorAddresses[i]].daysAvailable[_day]) {
                tutorList[i] = tutors[tutorAddresses[i]];
            }
        }
        return tutorList;
    }


}