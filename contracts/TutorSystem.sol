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
        uint256 priceForClass;
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

    // Map name to students
    mapping(string => Student) public students;
    string[] public studentNames;
    
    mapping(string => Tutor) public tutors;
    string[] public tutorNames;

    event Matched(bool matchResult);


    // Constructors for Tutor and Student
    function createTutor(string memory _name, uint256 _balance, string[] memory _classesTaught, bool[7] memory _daysAvailable, string[] memory _currentStudents, uint256 _price, address _adr) public {
        tutors[_name] = Tutor(_name, _balance, _classesTaught, _daysAvailable, _currentStudents, _price, _adr);
        tutorNames.push(_name);
    }

    function createStudent(string memory _name, uint256 _balance, string[] memory _classesTaught, bool[7] memory _daysAvailable, string[] memory _currentTutors, address _adr) public {
        students[_name] = Student(_name, _balance, _classesTaught, _daysAvailable, _currentTutors, _adr);
        studentNames.push(_name);
    }


    // Setters (The search is always going to be initiated with address)
    function setTutorBalance(string memory _name, uint256 _balance) public {
        tutors[_name].balance = _balance;
    }

    function setTutorClassesTaught(string memory _name, string[] memory _classesTaught) public {
        tutors[_name].classesTaught = _classesTaught;
    }

    function setTutorDaysAvailable(string memory _name, bool[7] memory _daysAvailable) public {
        tutors[_name].daysAvailable = _daysAvailable;
    }

    function setTutorPrice(string memory _name, uint256 _price) public {
        tutors[_name].priceForClass = _price;
    }

    function setTutorCurrentStudents(string memory _name, string[] memory _currentStudents) public {
        tutors[_name].currentStudents = _currentStudents;
    }

    function setStudentBalance(string memory _name, uint256 _balance) public {
        students[_name].balance = _balance;
    }

    function setStudentClassesRequested(string memory _name, string[] memory _classesRequested) public {
        students[_name].classesRequested = _classesRequested;
    }

    function setStudentDaysAvailable(string memory _name, bool[7] memory _daysAvailable) public {
        students[_name].daysAvailable = _daysAvailable;
    }

    function setStudentCurrentTutors(string memory _name, string[] memory _currentTutors) public {
        students[_name].currentTutors = _currentTutors;
    }


    // Getters
    function getTutor(string memory _name) public view returns(Tutor memory) {
        return tutors[_name];
    }

    function getStudent(string memory _name) public view returns(Student memory) {
        return students[_name];
    }

    function getTutorBalance(string memory _name) public view returns (uint256) {
        return tutors[_name].balance;
    }

    function getTutorPrice(string memory _name) public view returns (uint256) {
        return tutors[_name].priceForClass;
    }

    function getTutorClassesTaught(string memory _name) public view returns (string[] memory) {
        return tutors[_name].classesTaught;
    }

    function getTutorDaysAvailable(string memory _name) public view returns (bool[7] memory) {
        return tutors[_name].daysAvailable;
    }

    function getTutorCurrentStudents(string memory _name) public view returns (string[] memory) {
        return tutors[_name].currentStudents;
    }

    function getStudentBalance(string memory _name) public view returns (uint256) {
        return students[_name].balance;
    }

    function getStudentClassesRequested(string memory _name) public view returns (string[] memory) {
        return students[_name].classesRequested;
    }

    function getStudentDaysAvailable(string memory _name) public view returns (bool[7] memory) {
        return students[_name].daysAvailable;
    }

    function getStudentCurrentTutors(string memory _name) public view returns (string[] memory) {
        return students[_name].currentTutors;
    }

    // Addtional System Functions
    
    // Return all Student names and their addresses
    function showAllStudents() public view returns (Student[] memory) {
        Student[] memory AllStudents = new Student[](studentNames.length);
        for (uint i = 0; i < studentNames.length; i++) {
            AllStudents[i] = students[studentNames[i]];
        }
        return AllStudents;
    }  

    function deleteStudent(string memory _name) public {
        delete students[_name];
        for (uint i = 0; i < studentNames.length; i++) {
            if (keccak256(abi.encodePacked(studentNames[i])) == keccak256(abi.encodePacked(_name))) {
                studentNames[i] = studentNames[studentNames.length - 1];
                studentNames.pop();
                break;
            }
        }
    }

    function deleteTutor(string memory _name) public {
        delete tutors[_name];
        for (uint i = 0; i < tutorNames.length; i++) {
            if (keccak256(abi.encodePacked(tutorNames[i])) == keccak256(abi.encodePacked(_name))) {
                tutorNames[i] = tutorNames[tutorNames.length - 1];
                tutorNames.pop();
                break;
            }
        }

    }

    function showTutorsOnDay(uint256 _dayIndex) public view returns (Tutor[] memory) {
        
        uint256 tutorNum = 0;

        for (uint i = 0; i < tutorNames.length; i++) {
            bool[7] memory theDays = getTutorDaysAvailable(tutorNames[i]);
            if (theDays[_dayIndex]) {
                tutorNum += 1;
            }
        }

        Tutor[] memory availableTutors = new Tutor[](tutorNum);
        uint256 count = 0;

        for (uint i = 0; i < tutorNames.length; i++) {
            bool[7] memory theDays = getTutorDaysAvailable(tutorNames[i]);
            if (theDays[_dayIndex]) {
                availableTutors[count] = getTutor(tutorNames[i]); 
                count += 1;
            }
        }

        return availableTutors;
    }


    function showTutorsOnClass(string memory _class) public view returns (Tutor[] memory) {
        
        uint256 tutorNum = 0;

         for (uint i = 0; i < tutorNames.length; i++) {
            string[] memory classes = getTutorClassesTaught(tutorNames[i]);
            for (uint j = 0; j < classes.length; j++) {
                if (keccak256(abi.encodePacked(classes[j])) == keccak256(abi.encodePacked(_class))) {
                    tutorNum += 1;
                }
            }   
        }

        Tutor[] memory availableTutors = new Tutor[](tutorNum);
        uint256 count = 0;

        for (uint i = 0; i < tutorNames.length; i++) {
            string[] memory classes = getTutorClassesTaught(tutorNames[i]);
            for (uint j = 0; j < classes.length; j++) {
                if (keccak256(abi.encodePacked(classes[j])) == keccak256(abi.encodePacked(_class))) {
                    availableTutors[count] = getTutor(tutorNames[i]); 
                    count += 1;
                }
            }   
        }

        return availableTutors;
    }

    function matchStudentTutor(string memory _studentName, string memory _class, uint256 _dayIndex, string memory _tutorName) public returns (bool) {

        string[] memory classes = getTutorClassesTaught(_tutorName);
        bool[7] memory theDays = getTutorDaysAvailable(_tutorName);

        if (theDays[_dayIndex]) {
            for (uint i = 0; i < classes.length; i++) {
                 if (keccak256(abi.encodePacked(classes[i])) == keccak256(abi.encodePacked(_class))) {
                    updateMatch(_studentName, _dayIndex, _tutorName);
                    emit Matched(true);
                    return true;
                 }
            }
        }

        return false;
    }


    function updateMatch(string memory _studentName, uint256 _dayIndex, string memory _tutorName) public {
        // No longer available in those days
        students[_studentName].daysAvailable[_dayIndex] = false;
        tutors[_tutorName].daysAvailable[_dayIndex] = false;
        studentPayTutor(_studentName, _tutorName);
    }


    function studentPayTutor(string memory _studentName, string memory _tutorName) public {
        require(tutors[_tutorName].priceForClass < students[_studentName].balance, "Insufficient balance for student");
        students[_studentName].balance -= tutors[_tutorName].priceForClass;
        tutors[_tutorName].balance += tutors[_tutorName].priceForClass;
    }    

}