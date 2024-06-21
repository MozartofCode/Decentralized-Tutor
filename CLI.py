# @Author: Bertan Berker
# @ Filename: CLI.py
# This is the command line interface for a decentralized tutor-student match system

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