# 🎓 Decentralized Tutor – Blockchain-Powered Tutoring Platform  

**A decentralized tutor application where smart contracts facilitate secure, transparent interactions between students and tutors. Built using Solidity, Truffle, and Web3.py.**  

## 📌 Overview  
Decentralized Tutor is a **blockchain-based tutoring platform** that leverages **Ethereum smart contracts** to create a **transparent and trustless** environment for students and tutors. The project is deployed on a **test Ethereum blockchain using Ganache**, ensuring secure transactions and interactions.  

## 🔥 Key Features  
✅ **Smart Contract-Based Tutoring** – Secure agreements between students and tutors using **Solidity**.  
✅ **Decentralized Payments** – Transactions handled via **Ethereum blockchain** for trustless interactions.  
✅ **CLI-Based Smart Contract Interaction** – Uses **Web3.py** to interact with the blockchain.  
✅ **Truffle Framework Integration** – Simplifies smart contract deployment and testing.  
✅ **Local Ethereum Test Environment** – Deployed on **Ganache** for development and testing.  

## 🏗️ Tech Stack  
- **Smart Contracts:** Solidity  
- **Blockchain Development:** Truffle, Ganache  
- **Backend Interaction:** Web3.py  
- **Ethereum Test Environment:** Ganache  

## 🛠️ Installation & Setup  
### **Clone the repository:**  
```sh
git clone https://github.com/MozartofCode/Decentralized-Tutor.git
cd Decentralized-Tutor
```

### **Setup & Deploy Smart Contracts**  
1. **Install Truffle (if not installed):**  
   ```sh
   npm install -g truffle
   ```
2. **Start a local blockchain using Ganache:**  
   ```sh
   ganache-cli
   ```
3. **Compile and deploy the smart contract:**  
   ```sh
   truffle migrate --reset
   ```

### **Interact with the Smart Contract using CLI.py**  
1. Install dependencies:  
   ```sh
   pip install -r requirements.txt
   ```
2. Run the command-line interface to interact with the smart contract:  
   ```sh
   python CLI.py
   ```

## 🎯 How It Works  
1️⃣ **Students request tutoring services** through smart contracts.  
2️⃣ **Tutors accept and fulfill requests**, ensuring decentralized, trustless interactions.  
3️⃣ **Payments are securely processed** using Ethereum-based transactions.  

## 🚧 Future Enhancements  
🔹 **Implement a Web3.js Frontend** – Develop a UI for seamless user interaction.  
🔹 **Integrate MetaMask Authentication** – Enable secure login via Ethereum wallets.  
🔹 **Expand Smart Contract Features** – Support escrow services and automated dispute resolution.  
