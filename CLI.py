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
    print("Show all availavle tutors for a given class:- getClassTutors class")
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


    while True:
        command = input("What do you want to do:- ")

        if command == "quit":
            print()
            print("Thank you for using Tutor-Student Match Management")
            print()
            break    

        elif command[0] == "addStudent":
            return
        
        elif command[0] == "addTutor":
            return
        
        elif command[0] == "showStudents":
            return
        
        elif command[0] == "getTutors":
            return
        
        elif command[0] == "match":
            return
        
        elif command[0] == "getStudent":
            return
        
        elif command[0] == "getTutor":
            return





if __name__ == "__main__":
    main()