const Student = artifacts.require("Student");
const Tutor = artifacts.require("Tutor");

contract("Student and Tutor", (accounts) => {
    let studentInstance;
    let tutorInstance;

    const [owner, student, tutor] = accounts;

    before(async () => {
        // Deploy Tutor contract
        tutorInstance = await Tutor.new({ from: owner });

        // Deploy Student contract and pass the address of the Tutor contract
        studentInstance = await Student.new(tutorInstance.address, { from: owner });

        // Initialize a tutor in the Tutor contract
        await tutorInstance.addOrUpdateTutor("TutorName", 0, ["Math", "Physics"], [true, true, true, true, true, true, true], tutor, { from: owner });

        // Initialize a student with sufficient balance in the Student contract
        await studentInstance.addOrUpdateStudent("StudentName", web3.utils.toWei('10', 'ether'), ["Math"], [true, true, true, true, true, true, true], student, { from: owner });
    });

    it("should allow a student to send money to a tutor", async () => {
        // Initial balances
        const initialStudentBalance = (await studentInstance.students(student)).balance;
        const initialTutorBalance = (await tutorInstance.tutors(tutor)).balance;

        // Amount to send
        const amountToSend = web3.utils.toWei('1', 'ether');

        // Perform the money transfer from student to tutor
        await studentInstance.sendMoney(tutor, amountToSend, { from: student });

        // Final balances
        const finalStudentBalance = (await studentInstance.students(student)).balance;
        const finalTutorBalance = (await tutorInstance.tutors(tutor)).balance;

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
});
