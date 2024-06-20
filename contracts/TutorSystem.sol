// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;


/**
 * @title TutorSystem
 * @dev This smart contract stores student and tutors and has functionality for the Student-Tutor System
 */
contract TutorSystem {

     struct Student {
        string name;
        uint256 balance;
        string[] classesRequested;
        bool[7] daysAvailable;
        string[] currentTutors;
        address wallet;
    }

    struct Tutor {
        string name;
        uint256 balance;
        string[] classesTaught;
        bool[7] daysAvailable; // True if available that day False if not
        string[] currentStudents;
        address wallet;
    }


    // Constructor
    constructor {

    }

    // Setters







    // Getters








}