// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TutoringService {

    struct Class {
        string title;
        string description;
        address payable teacher;
        uint256 price;
        bool isAvailable;
    }

    Class[] public classes;
    mapping(address => uint256[]) public teacherClasses;
    mapping(address => uint256[]) public studentClasses;

    event ClassCreated(uint256 classId, address teacher);
    event ClassPurchased(uint256 classId, address student);

    function createClass(string memory _title, string memory _description, uint256 _price) public {
        Class memory newClass = Class({
            title: _title,
            description: _description,
            teacher: payable(msg.sender),
            price: _price,
            isAvailable: true
        });
        classes.push(newClass);
        uint256 classId = classes.length - 1;
        teacherClasses[msg.sender].push(classId);
        emit ClassCreated(classId, msg.sender);
    }

    function purchaseClass(uint256 _classId) public payable {
        require(_classId < classes.length, "Class does not exist");
        Class storage classToPurchase = classes[_classId];
        require(classToPurchase.isAvailable, "Class is not available");
        require(msg.value == classToPurchase.price, "Incorrect value sent");

        classToPurchase.teacher.transfer(msg.value);
        studentClasses[msg.sender].push(_classId);
        emit ClassPurchased(_classId, msg.sender);
    }

    function getClass(uint256 _classId) public view returns (string memory, string memory, address, uint256, bool) {
        require(_classId < classes.length, "Class does not exist");
        Class memory classToGet = classes[_classId];
        return (classToGet.title, classToGet.description, classToGet.teacher, classToGet.price, classToGet.isAvailable);
    }

    function getTeacherClasses(address _teacher) public view returns (uint256[] memory) {
        return teacherClasses[_teacher];
    }

    function getStudentClasses(address _student) public view returns (uint256[] memory) {
        return studentClasses[_student];
    }
}

