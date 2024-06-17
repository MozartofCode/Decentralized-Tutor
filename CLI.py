# @Author: Bertan Berker
# @ Filename: CLI.py
# This is the command line interface for a decentralized tutor-student match system

def commands():
    print()
    print("Here are the possible comments:")
    print("Add a Student:- addStudent [name, balance, [Classrequired], [daysAvailable in T/F form], wallet address]")
    print("Add a tutor:- addTutor [name, balance, [ClassesTaught], [daysAvailable in T/F form], wallet address]")
    print("Show all available tutors for a given day:- getTutors Day")
    print("Show all the students in the system:- showStudents")
    print("Get a student:- getStudent name")
    print("Get a tutor:- getTutor name")
    print("Match student with tutor:- match studentname&tutorname")
    print("Quit the system:- quit")
    print()

def main():
    print("Welcome to Tutor-Student Match Management System...")
    commands()
    
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