const Student = artifacts.require("Student");
const Tutor = artifacts.require("Tutor");

contract("Student and Tutor", (accounts) => {
    let studentInstance;
    let tutorInstance;

    const [owner, student1, student2, tutor1, tutor2] = accounts;

    before(async () => {
        // Deploy Tutor contract
        tutorInstance = await Tutor.new({ from: owner });

        // Deploy Student contract and pass the address of the Tutor contract
        studentInstance = await Student.new(tutorInstance.address, { from: owner });

        // Initialize tutors in the Tutor contract
        await tutorInstance.addOrUpdateTutor("Tutor1", 0, ["Math", "Physics"], [true, true, true, true, true, true, true], tutor1, { from: owner });
        await tutorInstance.addOrUpdateTutor("Tutor2", 0, ["Chemistry", "Biology"], [false, true, true, true, true, true, false], tutor2, { from: owner });

        // Initialize students with sufficient balance in the Student contract
        await studentInstance.addOrUpdateStudent("Student1", web3.utils.toWei('10', 'ether'), ["Math"], [true, true, true, true, true, true, true], student1, { from: owner });
        await studentInstance.addOrUpdateStudent("Student2", web3.utils.toWei('5', 'ether'), ["Biology"], [false, true, true, true, true, true, false], student2, { from: owner });
    });

    it("should allow adding/updating students and tutors", async () => {
        // Check student1
        const student1Data = await studentInstance.students(student1);
        assert.equal(student1Data.name, "Student1", "Student1 name should be correct");
        assert.equal(web3.utils.fromWei(student1Data.balance, 'ether'), '10', "Student1 balance should be correct");

        // Check student2
        const student2Data = await studentInstance.students(student2);
        assert.equal(student2Data.name, "Student2", "Student2 name should be correct");
        assert.equal(web3.utils.fromWei(student2Data.balance, 'ether'), '5', "Student2 balance should be correct");

        // Check tutor1
        const tutor1Data = await tutorInstance.tutors(tutor1);
        assert.equal(tutor1Data.name, "Tutor1", "Tutor1 name should be correct");

        // Check tutor2
        const tutor2Data = await tutorInstance.tutors(tutor2);
        assert.equal(tutor2Data.name, "Tutor2", "Tutor2 name should be correct");
    });

    it("should allow a student to send money to a tutor", async () => {
        // Initial balances
        const initialStudentBalance = (await studentInstance.students(student1)).balance;
        const initialTutorBalance = (await tutorInstance.tutors(tutor1)).balance;

        // Amount to send
        const amountToSend = web3.utils.toWei('1', 'ether');

        // Perform the money transfer from student1 to tutor1
        await studentInstance.sendMoney(tutor1, amountToSend, { from: student1 });

        // Final balances
        const finalStudentBalance = (await studentInstance.students(student1)).balance;
        const finalTutorBalance = (await tutorInstance.tutors(tutor1)).balance;

        // Assert the balances
        assert.equal(
            finalStudentBalance.toString(),
            (BigInt(initialStudentBalance) - BigInt(amountToSend)).toString(),
            "Student's balance should decrease by the amount sent"
        );

        assert.equal(
            finalTutorBalance.toString(),
            (BigInt(initialTutorBalance) + BigInt(amountToSend)).toString(),
            "Tutor's balance should increase by the amount received"
        );
    });

    it("should correctly match tutors by availability", async () => {
        // Get available tutors for Monday (index 0)
        let availableTutors = await tutorInstance.getAvailableTutors(0);
        assert.equal(availableTutors.length, 1, "One tutor should be available on Monday");
        assert.equal(availableTutors[0].name, "Tutor1", "Tutor1 should be available on Monday");

        // Get available tutors for Tuesday (index 1)
        availableTutors = await tutorInstance.getAvailableTutors(1);
        assert.equal(availableTutors.length, 2, "Two tutors should be available on Tuesday");
    });

    it("should retrieve student and tutor by name", async () => {
        // Retrieve student by name
        const student1Data = await studentInstance.getStudent("Student1");
        assert.equal(student1Data.name, "Student1", "Should retrieve the correct student by name");

        // Retrieve tutor by name
        const tutor1Data = await tutorInstance.getTutor("Tutor1");
        assert.equal(tutor1Data.name, "Tutor1", "Should retrieve the correct tutor by name");
    });

    it("should return all students", async () => {
        const allStudents = await studentInstance.returnAllStudents();
        assert.equal(allStudents.length, 2, "There should be two students");
    });
});
