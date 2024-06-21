const TutorSystem = artifacts.require('TutorSystem');

contract('TutorSystem', accounts => {
    let tutorSystemInstance;

    const studentAddress = accounts[0];
    const tutorAddress = accounts[1];

    const studentName = 'Alice';
    const tutorName = 'Bob';

    const classesRequested = ['Math', 'Science'];
    const classesTaught = ['Math', 'Science', 'History'];

    const studentDaysAvailable = [true, true, false, false, false, false, false];
    const tutorDaysAvailable = [true, true, true, true, false, false, false];

    beforeEach(async () => {
        tutorSystemInstance = await TutorSystem.new();
        
        // Creating tutor and student
        await tutorSystemInstance.createTutor(
            tutorName,
            web3.utils.toWei('0', 'ether'),
            classesTaught,
            tutorDaysAvailable,
            [],
            web3.utils.toWei('1', 'ether'),
            tutorAddress
        );

        await tutorSystemInstance.createStudent(
            studentName,
            web3.utils.toWei('10', 'ether'),
            classesRequested,
            studentDaysAvailable,
            [],
            studentAddress
        );
    });

    it('should allow a student to pay a tutor', async () => {
        const sendAmount = web3.utils.toWei('1', 'ether');
    
        // Check initial balances
        const initialStudentBalance = await tutorSystemInstance.getStudentBalance(studentName);
        const initialTutorBalance = await tutorSystemInstance.getTutorBalance(tutorName);
    
        console.log(`Initial balances: Student = ${web3.utils.fromWei(initialStudentBalance)}, Tutor = ${web3.utils.fromWei(initialTutorBalance)}`);
    
        // Ensure student has enough balance to pay tutor
        assert(initialStudentBalance >= sendAmount, 'Student does not have enough balance to pay tutor');
    
        // Perform payment
        try {
            await tutorSystemInstance.studentPayTutor(studentName, tutorName);
    
            // Check balances after payment
            const studentBalanceAfter = await tutorSystemInstance.getStudentBalance(studentName);
            const tutorBalanceAfter = await tutorSystemInstance.getTutorBalance(tutorName);
    
            console.log(`Balances after payment: Student = ${web3.utils.fromWei(studentBalanceAfter)}, Tutor = ${web3.utils.fromWei(tutorBalanceAfter)}`);
    
            assert.equal(studentBalanceAfter, initialStudentBalance - sendAmount, 'Student balance incorrect after payment');
            assert.equal(tutorBalanceAfter, sendAmount, 'Tutor balance incorrect after payment');
        } catch (error) {
            console.error('Error occurred:', error);
            assert.fail('Transaction failed unexpectedly');
        }
    });
    

    it('should find a matching tutor for a student', async () => {
        const dayIndex = 0;
    
        try {
            // Call matchStudentTutor function
            const tx = await tutorSystemInstance.matchStudentTutor(studentName, 'Math', dayIndex, tutorName);
            console.log(tx)
            
            // Assert that a match was found
            assert.isTrue(tx, 'Matching tutor was not found');
        } catch (error) {
            console.error('Error occurred:', error);
            assert.fail('Error calling matchStudentTutor');
        }

        const student = await tutorSystemInstance.getStudent(studentName);
        const tutor = await tutorSystemInstance.getTutor(tutorName);

        const matched = student.currentTutors.includes(tutor.name) && tutor.currentStudents.includes(student.name);

        assert.isTrue(matched, 'Tutor and student are not properly matched');
    });

    // Additional test cases can be added as needed

});

