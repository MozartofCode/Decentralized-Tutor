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
        address wallet;
    }

    mapping(address => StudentPerson) public students;
    address[] public studentAddresses;

    event Transfer(address indexed from, address indexed to, uint256 value);

    Tutor public tutorContract;

    constructor(address _tutorContract) {
        tutorContract = Tutor(_tutorContract);
    }

    function addOrUpdateStudent(string memory _name, uint256 _balance, string[] memory _classesTaught, bool[7] memory _daysAvailable, address _adr) public {
        if (!isStudentAddress(_adr)) {
            studentAddresses.push(_adr);
        }
        students[_adr] = StudentPerson(_name, _balance, _classesTaught, _daysAvailable, _adr);
    }

    function sendMoney(address _receiver, uint256 _amount) public returns (bool) {
        require(students[msg.sender].balance < _amount, "Insufficient balance");

        students[msg.sender].balance -= _amount;
        tutorContract.receiveMoney(_amount, _receiver);

        emit Transfer(msg.sender, _receiver, _amount);
        return true;
    }


    function isStudentName(string memory _name) {
        for (uint i = 0; i < studentAddresses.length; i++) {
            if (students[studentAddresses[i]].name == _name) {
                return true
            }
        }
        return false
    }

    function getStudent(string memory _name) public view returns (StudentPerson) {
        for (uint i = 0; i < studentAddresses.length; i++) {
            if (students[studentAddresses[i]].name == _name) {
                return students[studentsAddresses[i]]
            }
        }
    }

    function returnAllStudents() public view returns (StudentPerson[] memory) {
        StudentPerson[] memory studentsList;
        for (uint i = 0; i < studentAddresses.length; i++) {
            studentsList.push(students[studentAddresses[i]]);
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


    function matchWithTutor() public{}

}