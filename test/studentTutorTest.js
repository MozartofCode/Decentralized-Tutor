const Student = artifacts.require('Student');
const Tutor = artifacts.require('Tutor');

contract('Student and Tutor', accounts => {
    let studentContract;
    let tutorContract;

    const studentAddress = accounts[0];
    const tutorAddress = accounts[1];

    const studentName = 'Alice';
    const tutorName = 'Bob';

    const classesRequested = ['Math', 'Science'];
    const classesTaught = ['Math', 'Science', 'History'];

    const studentDaysAvailable = [true, true, false, false, false, false, false];
    const tutorDaysAvailable = [true, true, true, true, false, false, false];

    beforeEach(async () => {
        tutorContract = await Tutor.new();
        studentContract = await Student.new(tutorContract.address);

        await tutorContract.addOrUpdateTutor(tutorName, web3.utils.toWei('0', 'ether'), classesTaught, tutorDaysAvailable, [], tutorAddress);
        await studentContract.addOrUpdateStudent(studentName, web3.utils.toWei('10', 'ether'), classesRequested, studentDaysAvailable, [], studentAddress);
    });

    it('should allow a student to send money to a tutor', async () => {
        const sendAmount = web3.utils.toWei('1', 'ether');

        await studentContract.sendMoney(tutorAddress, sendAmount, { from: studentAddress });

        const student = await studentContract.students(studentAddress);
        const tutor = await tutorContract.tutors(tutorAddress);

        assert.equal(web3.utils.fromWei(student.balance, 'ether'), '9');
        assert.equal(web3.utils.fromWei(tutor.balance, 'ether'), '1');
    });

    it('should return all students', async () => {
        const students = await studentContract.returnAllStudents();
        assert.equal(students.length, 1);
        assert.equal(students[0].name, studentName);
    });

    it('should get a student by name', async () => {
        const student = await studentContract.getStudent(studentName);
        assert.equal(student.name, studentName);
    });

    it('should get a tutor by name', async () => {
        const tutor = await tutorContract.getTutor(tutorName);
        assert.equal(tutor.name, tutorName);
    });

    it('should find a matching tutor', async () => {
        // Perform the match
        const matchResult = await studentContract.matchWithTutor(studentName, { from: studentAddress });
    
        // Assert that a match was found
        assert.isTrue(matchResult, 'Matching tutor was not found');
    
        // Retrieve updated student and tutor information
        const student = await studentContract.getStudent(studentName);
        const tutor = await tutorContract.getTutor(tutorName);
    
        // Check if the tutor is now assigned to the student and vice versa
        const matched = student.currentTutors.includes(tutor.name) && tutor.currentStudents.includes(student.name);
    
        // Assert that the tutor and student are now matched
        assert.isTrue(matched, 'Tutor and student are not properly matched');
    });
    
});
