// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

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

    function addOrUpdateStudent(string memory _name, uint256 _balance, string[] memory _classesTaught, bool[7] memory _daysAvailable, address _adr) public {
        if (!isStudentAddress(_adr)) {
            studentAddresses.push(_adr);
        }
        students[_adr] = StudentPerson(_name, _balance, _classesTaught, _daysAvailable, _adr);
    }
    
    function getBalance(address _adr) public view returns(uint256) {
        return students[_adr].balance;
    }

    function sendMoney(address receiver, uint256 amount) public returns (bool sufficient) {
        require(students[msg.sender].balance < amount, "Insufficient balance");
        students[msg.sender].balance -= amount;
        //students[receiver].balance += amount;
        emit Transfer(msg.sender, receiver, amount);
        return true;
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

}