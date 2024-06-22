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

    print("Welcome to Tutor-Student Match Management System...")
    commands()

    while True:
        print()
        command = input("What do you want to do:- ")
        command = command.split(" ")

        if command[0] == "quit":
            print()
            print("Thank you for using Tutor-Student Match Management")
            print()
            break    
        
        elif command[0] == "addStudent":
            name = "Alice"
            balance = 100
            classesRequired = ["Math", "Physics", "English"]
            days = [True, False, True, False, True, False, True]
            tutors = ["Michael", "Jordan"]
            address = "0xA2fB0bCfa18b62C5A54b17d781c7D42f42e6fD8A"
        
        
        #     name = command[1]
        #     balance = int(command[2])
        #     classesRequired = ["Math", "English"]
        #     # list(command[3])
        #     currentTutors = []
        #     address = web3.eth.accounts[0]
            contract.functions.createStudent(name, balance, classesRequired, days, tutors, address).transact()
        
        elif command[0] == "addTutor":
            # name = command[1]
            # balance = int(command[2])
            # classesTaught = list(command[3])
            # currentStudents = []
            # address = ""
            
            name = "Alexis"
            balance = 100
            classesTaught = ["Math", "Physics", "English"]
            days = [True, False, True, False, True, False, True]
            currentStudents = ["Jane", "Jennifer"]
            address = "0xA2fB0bCfa18b62C5A54b17d781c7D42f42e6fD8A"
            price = 10

            contract.functions.createTutor(name, balance, classesTaught, days, currentStudents, price, address).transact()
        
        elif command[0] == "getCurrentStudents":
            tutorName = command[1]
            students = contract.functions.getTutorCurrentStudents(tutorName).call()
            print(str(students))

        
        elif command[0] == "getCurrentTutors":
            studentName = command[1]
            tutors = contract.functions.getStudentCurrentTutors(studentName).call()
            print(str(tutors))


        
        elif command[0] == "showStudents":
            
            students = contract.functions.showAllStudents().call()

            for student in students:
                print("Name: " + str(student[0]))
                print("Balance: " + str(student[1]))
                print("Classes Requested: " + str(student[2]))
                print("Available Days: " + str(student[3]))
                print("Current Tutors: " + str(student[4]))
                print("Wallet Address: " + str(student[5]))            
                print()

        
        elif command[0] == "getStudent":
            studentName = command[1]
            student = contract.functions.getStudent(studentName).call()
            
            print("Name: " + str(student[0]))
            print("Balance: " + str(student[1]))
            print("Classes Requested: " + str(student[2]))
            print("Available Days: " + str(student[3]))
            print("Current Tutors: " + str(student[4]))
            print("Wallet Address: " + str(student[5]))            
            print()

            
        elif command[0] == "getTutor":
            tutorName = command[1]
            tutor = contract.functions.getTutor(tutorName).call()
            
            print("Name: " + str(tutor[0]))
            print("Balance: " + str(tutor[1]))
            print("Classes Taught: " + str(tutor[2]))
            print("Available Days: " + str(tutor[3]))
            print("Current Students: " + str(tutor[4]))
            print("Price For A Class: " + str(tutor[5]))
            print("Wallet Address: " + str(tutor[6]))            
            print()
            
        
        elif command[0] == "deleteStudent":
            studentName = command[1]
            contract.functions.deleteStudent(studentName).transact()
        
        elif command[0] == "deleteTutor":
            TutorName = command[1]
            contract.functions.deleteTutor(tutorName).transact()
        
        elif command[0] == "getDayTutors":
            day = int(command[1])
            tutors = contract.functions.showTutorsOnDay(day).call()
    
            for tutor in tutors:
                print("Name: " + str(tutor[0]))
                print("Balance: " + str(tutor[1]))
                print("Classes Taught: " + str(tutor[2]))
                print("Available Days: " + str(tutor[3]))
                print("Current Students: " + str(tutor[4]))
                print("Price For A Class: " + str(tutor[5]))
                print("Wallet Address: " + str(tutor[6]))            
                print()

        
        elif command[0] == "getClassTutors":
            _class = command[1]
            tutors = contract.functions.showTutorsOnClass(_class).call()

            for tutor in tutors:
                print("Name: " + str(tutor[0]))
                print("Balance: " + str(tutor[1]))
                print("Classes Taught: " + str(tutor[2]))
                print("Available Days: " + str(tutor[3]))
                print("Current Students: " + str(tutor[4]))
                print("Price For A Class: " + str(tutor[5]))
                print("Wallet Address: " + str(tutor[6]))            
                print()


        elif command[0] == "match": 
            student = input("Student Name: ")
            tutor = input("Tutor Name: ")
            _class = input("What class: ")
            dayIndex = input("What day (0-6 index): ")

            if (contract.functions.matchStudentTutor(student, _class, dayIndex, tutor).transact()):
                print("Match is successful...")
            else:
                print("Match is UNSUCCESSFUL. Please try again...")
        
    


if __name__ == "__main__":
    main()