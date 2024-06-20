// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import './Tutor.sol';

/**
 * @title Student
 * @dev Stores the Students and handles certain interactions between students and tutors
 */
contract Student {

    struct StudentPerson {
        string name;
        uint256 balance;
        string[] classesRequested;
        bool[7] daysAvailable;
        string[] currentTutors;
        address wallet;
    }

    mapping(address => StudentPerson) public students;
    address[] public studentAddresses;

    event Transfer(address indexed from, address indexed to, uint256 value);

    Tutor public tutorContract;

    constructor(address _tutorContract) {
        tutorContract = Tutor(_tutorContract);
    }

    function addOrUpdateStudent(string memory _name, uint256 _balance, string[] memory _classesTaught, bool[7] memory _daysAvailable, string[] memory _currentTutors, address _adr) public {
        if (!isStudentAddress(_adr)) {
            studentAddresses.push(_adr);
        }
        students[_adr] = StudentPerson(_name, _balance, _classesTaught, _daysAvailable, _currentTutors, _adr);
    }

    function sendMoney(address _receiver, uint256 _amount) public returns (bool) {
        require(students[msg.sender].balance >= _amount, "Insufficient balance");

        students[msg.sender].balance -= _amount;
        tutorContract.receiveMoney(_amount, _receiver);

        emit Transfer(msg.sender, _receiver, _amount);
        return true;
    }


    function isStudentName(string memory _name) public view returns (bool) {
        for (uint i = 0; i < studentAddresses.length; i++) {
            if (keccak256(bytes(students[studentAddresses[i]].name)) == keccak256(bytes(_name))) {
                return true;
            }
        }
        return false;
    }

    function getStudent(string memory _name) public view returns (StudentPerson memory) {
        for (uint i = 0; i < studentAddresses.length; i++) {
             if (keccak256(bytes(students[studentAddresses[i]].name)) == keccak256(bytes(_name))) {
                return students[studentAddresses[i]];
            }
        }

        revert("Student not found");
    }

    function returnAllStudents() public view returns (StudentPerson[] memory) {
        
        
        StudentPerson[] memory studentsList = new StudentPerson[](studentAddresses.length);
        for (uint i = 0; i < studentAddresses.length; i++) {
            studentsList[i] = students[studentAddresses[i]];
        }
        return studentsList;
    }


    // Function to check if an address is in the tutorAddresses array
    function isStudentAddress(address _address) public view returns (bool) {
        for (uint i = 0; i < studentAddresses.length; i++) {
            if (studentAddresses[i] == _address) {
                return true;
            }
        }
        return false;
    }


    function matchWithTutor(string memory _studentName) public returns (bool) {
        StudentPerson storage std = students[msg.sender]; // assuming msg.sender is the student's address
        
        tutorContract.TutorPerson[] possibleTutors = tutorContract.getAvailableTutorsClass(std.classesRequested);

        for (uint i = 0; i < std.daysAvailable.length; i++) {
            if (std.daysAvailable[i]) {
                TutorPerson[] memory possibleTutorDay = tutorContract.getAvailableTutors(i);
                for (uint j = 0; j < possibleTutorDay.length; j++) {
                    for (uint k = 0; k < possibleTutors.length; k++) {
                        if (compareTutors(possibleTutorDay[j], possibleTutors[k])) {
                            // There is a match!
                            possibleTutorDay[j].daysAvailable[i] = false;
                            std.daysAvailable[i] = false;
                            std.currentTutors.push(possibleTutorDay[j].name); // Add tutor's name or address
                            possibleTutorDay[j].currentStudents.push(std.name); // Add student's name or address
                            return true;
                        }
                    }
                }
            }
        }

        return false; // No match found
    }


     function getStudentAddressByName(string memory _name) internal view returns (address) {
        for (uint i = 0; i < studentAddresses.length; i++) {
            if (keccak256(bytes(students[studentAddresses[i]].name)) == keccak256(bytes(_name))) {
                return studentAddresses[i];
            }
        }
        revert("Student not found");
    }

}

