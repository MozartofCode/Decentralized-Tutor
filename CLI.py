# @Author: Bertan Berker
# @ Filename: CLI.py
# This is the command line interface for a decentralized tutor-student match system

import json
from web3 import Web3

def commands():
    print()
    print("Here are the possible comments:")
    print("Add a Student:- addStudent [name, balance, [Classrequired], [daysAvailable in T/F form], [currentTutors], wallet address]")
    print("Add a tutor:- addTutor [name, balance, [ClassesTaught], [daysAvailable in T/F form], [CurrentStudents], wallet address]")
    print("Get a tutor's current students:- getCurrentStudents name")
    print("Get a student's current tutors:- getCurrentTutors name")
    print("Show all the students in the system:- showStudents")
    print("Get a student:- getStudent name")
    print("Get a tutor:- getTutor name")
    print("Delete Student:- deleteStudent name")
    print("Delete Tutor:- deleteTutor name")
    print("Show all available tutors for a given day:- getDayTutors Day")
    print("Show all available tutors for a given class:- getClassTutors class")
    print("Match student with tutor:- match studentname tutorname")
    print("Quit the system:- quit")
    print()

def main():
    print("Welcome to Tutor-Student Match Management System...")
    commands()
    
    # Connecting to Ganache
    ganache_url = "http://127.0.0.1:7545"
    web3 = Web3(Web3.HTTPProvider(ganache_url))

    print("Connection to Ganache successful?: " + str(web3.is_connected()))

    # Replace with the address of the deployed contract
    contract_address = '0xEe45A386016A7c0f325fccf92d8d8fA258FA006A'

    # Replace with the path to your contract's JSON file
    with open('build/contracts/TutorSystem.json') as f:
        contract_json = json.load(f)
        contract_abi = contract_json['abi']

    contract = web3.eth.contract(address=contract_address, abi=contract_abi)
    web3 = web3
    contract = contract
    web3.eth.default_account = web3.eth.accounts[0]

    print("Add a Student:- addStudent [name, balance, [Classrequired], [daysAvailable in T/F form], [currentTutors], wallet address]")
    print("Add a tutor:- addTutor [name, balance, [ClassesTaught], [daysAvailable in T/F form], [CurrentStudents], wallet address]")



    while True:
        command = input("What do you want to do:- ")
        command = command.split(" ")

        if command == "quit":
            print()
            print("Thank you for using Tutor-Student Match Management")
            print()
            break    
        
        elif command[0] == "addStudent":
            name = command[1]
            balance = int(command[2])
            classesRequired = list(command[3])
            currentTutors = []
            address = ""
            contract.functions.createStudent(name, balance, classesRequired, currentTutors, address).call()
        
        elif command[0] == "addTutor":
            name = command[1]
            balance = int(command[2])
            classesTaught = list(command[3])
            currentStudents = []
            address = ""
            contract.functions.createTutor(name, balance, classesTaught, currentStudents, address).call()
        
        elif command[0] == "getCurrentStudents":
            tutorName = command[1]
            students = contract.functions.getTutorCurrentStudents(tutorName).call()

            for student in students:
                print("Name: " + str(student.name))
                print("Balance: " + str(student.balance))
                print("Classes Requested: " + str(student.classesRequested))
                print("Available Days: " + str(student.daysAvailable))
                print("Current Tutors: " + str(student.currentTutors))
                print("Wallet Address: " + str(student.address))            
                print()

        
        elif command[0] == "getCurrentTutors":
            studentName = command[1]
            tutors = contract.functions.getStudentCurrentTutors(studentName).call()

            for tutor in tutors:
                print("Name: " + str(tutor.name))
                print("Balance: " + str(tutor.balance))
                print("Classes Taught: " + str(tutor.classesTaught))
                print("Available Days: " + str(tutor.daysAvailable))
                print("Current Students: " + str(tutor.currentStudents))
                print("Price For A Class: " + str(tutor.priceForClass))
                print("Wallet Address: " + str(tutor.address))            
                print()


        
        elif command[0] == "showStudents":
            
            students = contract.functions.showAllStudents().call()
            for student in students:
                print("Name: " + str(student.name))
                print("Balance: " + str(student.balance))
                print("Classes Requested: " + str(student.classesRequested))
                print("Available Days: " + str(student.daysAvailable))
                print("Current Tutors: " + str(student.currentTutors))
                print("Wallet Address: " + str(student.address))            
                print()

        
        elif command[0] == "getStudent":
            studentName = command[1]
            student = contract.functions.getStudent(studentName).call()

            print("Name: " + str(student.name))
            print("Balance: " + str(student.balance))
            print("Classes Requested: " + str(student.classesRequested))
            print("Available Days: " + str(student.daysAvailable))
            print("Current Tutors: " + str(student.currentTutors))
            print("Wallet Address: " + str(student.address))            
            print()

            
        elif command[0] == "getTutor":
            tutorName = command[1]
            tutor = contract.functions.getTutor(tutorName).call()
            
            print("Name: " + str(tutor.name))
            print("Balance: " + str(tutor.balance))
            print("Classes Taught: " + str(tutor.classesTaught))
            print("Available Days: " + str(tutor.daysAvailable))
            print("Current Students: " + str(tutor.currentStudents))
            print("Price For A Class: " + str(tutor.priceForClass))
            print("Wallet Address: " + str(tutor.address))            
            print()

            
        
        elif command[0] == "deleteStudent":
            studentName = command[1]
            contract.functions.deleteStudent(studentName).call()
        
        elif command[0] == "deleteTutor":
            TutorName = command[1]
            contract.functions.deleteTutor(tutorName).call()
        
        elif command[0] == "getDayTutors":
            day = command[1]
            tutors = contract.functions.showTutorsOnDay(day).call()
    
            for tutor in tutors:
                print("Name: " + str(tutor.name))
                print("Balance: " + str(tutor.balance))
                print("Classes Taught: " + str(tutor.classesTaught))
                print("Available Days: " + str(tutor.daysAvailable))
                print("Current Students: " + str(tutor.currentStudents))
                print("Price For A Class: " + str(tutor.priceForClass))
                print("Wallet Address: " + str(tutor.address))            
                print()


        
        elif command[0] == "getClassTutors":
            _class = command[1]
            tutors = contract.functions.showTutorsOnDay(_class).call()

            for tutor in tutors:
                print("Name: " + str(tutor.name))
                print("Balance: " + str(tutor.balance))
                print("Classes Taught: " + str(tutor.classesTaught))
                print("Available Days: " + str(tutor.daysAvailable))
                print("Current Students: " + str(tutor.currentStudents))
                print("Price For A Class: " + str(tutor.priceForClass))
                print("Wallet Address: " + str(tutor.address))            
                print()


        elif command[0] == "match": 
            student = input("Student Name: ")
            tutor = input("Tutor Name: ")
            _class = input("What class: ")
            dayIndex = input("What day (0-6 index): ")

            if (contract.functions.matchStudentTutor(student, _class, dayIndex, tutor).call()):
                print("Match is successful...")
            else:
                print("Match is UNSUCCESSFUL. Please try again...")
        
    




if __name__ == "__main__":
    main()