// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;


/**
 * @title TutorSystem
 * @dev This smart contract stores student and tutors and has functionality for the Student-Tutor System
 */
contract TutorSystem {
  
    struct Tutor {
        string name;
        uint256 balance;
        string[] classesTaught;
        bool[7] daysAvailable; // True if available that day False if not
        string[] currentStudents;
        address wallet;
    }

    struct Student {
        string name;
        uint256 balance;
        string[] classesRequested;
        bool[7] daysAvailable;
        string[] currentTutors;
        address wallet;
    }

  
    mapping(address => Student) public students;
    address[] public studentAddresses;
    
    mapping(address => Tutor) public tutors;
    address[] public tutorAddresses;

    // Constructors for Tutor and Student
    function createTutor(string memory _name, uint256 _balance, string[] memory _classesTaught, bool[7] memory _daysAvailable, string[] memory _currentStudents, address _adr) public {
        tutors[_adr] = Tutor(_name, _balance, _classesTaught, _daysAvailable, _currentStudents, _adr);
        tutorAddresses.push(_adr);
    }

    function createStudent(string memory _name, uint256 _balance, string[] memory _classesTaught, bool[7] memory _daysAvailable, string[] memory _currentTutors, address _adr) public {
        students[_adr] = Student(_name, _balance, _classesTaught, _daysAvailable, _currentTutors, _adr);
        studentAddresses.push(_adr);
    }


    // Setters (The search is always going to be initiated with address)
    function setTutorBalance(address _adr, uint256 _balance) public {
        tutors[_adr].balance = _balance;
    }

    function setTutorClassesTaught(address _adr, string[] memory _classesTaught) public {
        tutors[_adr].classesTaught = _classesTaught;
    }

    function setTutorDaysAvailable(address _adr, bool[7] memory _daysAvailable) public {
        tutors[_adr].daysAvailable = _daysAvailable;
    }

    function setTutorCurrentStudents(address _adr, string[] memory _currentStudents) public {
        tutors[_adr].currentStudents = _currentStudents;
    }

    function setStudentBalance(address _adr, uint256 _balance) public {
        students[_adr].balance = _balance;
    }

    function setStudentClassesRequested(address _adr, string[] memory _classesRequested) public {
        students[_adr].classesRequested = _classesRequested;
    }

    function setStudentDaysAvailable(address _adr, bool[7] memory _daysAvailable) public {
        students[_adr].daysAvailable = _daysAvailable;
    }

    function setStudentCurrentTutors(address _adr, string[] memory _currentTutors) public {
        students[_adr].currentTutors = _currentTutors;
    }


    // Getters
    function getTutorBalance(address _adr) public view returns (uint256) {
        return tutors[_adr].balance;
    }

    function getTutorClassesTaught(address _adr) public view returns (string[] memory) {
        return tutors[_adr].classesTaught;
    }

    function getTutorDaysAvailable(address _adr) public view returns (bool[7] memory) {
        return tutors[_adr].daysAvailable;
    }

    function getTutorCurrentStudents(address _adr) public view returns (string[] memory) {
        return tutors[_adr].currentStudents;
    }

    function getStudentBalance(address _adr) public view returns (uint256) {
        return students[_adr].balance;
    }

    function getStudentClassesRequested(address _adr) public view returns (string[] memory) {
        return students[_adr].classesRequested;
    }

    function getStudentDaysAvailable(address _adr) public view returns (bool[7] memory) {
        return students[_adr].daysAvailable;
    }

    function getStudentCurrentTutors(address _adr) public view returns (string[] memory) {
        return students[_adr].currentTutors;
    }









}