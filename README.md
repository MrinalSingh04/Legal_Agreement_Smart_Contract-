# 🤝 Legal Agreement with Auto-Enforcement — Smart Contract

## 🧠 What is this?

This smart contract allows **two parties** (e.g., freelancer and client, startup and investor) to enter into a **digitally signed agreement** with: 

- Predefined legal terms 
- Locked penalty amount (escrowed)
- Auto-enforcement of penalties if either party reports a breach
     
## 🚀 Why this matters 

Legal agreements (like NDAs or freelance contracts) are often unenforceable unless you go to court — **time-consuming, expensive, and inefficient**.

This contract ensures:

- ✅ Transparent agreement terms
- ✅ Mutual digital signature
- ✅ Penalty amount is locked on-chain
- ✅ Immediate penalty execution if breach is reported
- ✅ No need for legal action or centralized authority

## 🏗️ How it works

1. **Party A** deploys the contract with:

   - Party B’s address
   - Agreement terms (as string)
   - Escrowed penalty amount (sent with contract)

2. **Both parties** call `signAgreement()` to digitally sign.

3. Once signed:

   - Status becomes `Active`

4. If either party violates the agreement:

   - The other can call `reportBreach()` and trigger automatic **penalty transfer**

5. If completed without issues:
   - `markCompleted()` returns the locked penalty amount to Party A.

## 🛠️ Functions

| Function                         | Description                                       |
| -------------------------------- | ------------------------------------------------- |
| `signAgreement()`                | Each party signs the agreement                    |
| `reportBreach(address offender)` | Report breach by other party and transfer penalty |
| `markCompleted()`                | Mark agreement as fulfilled and release penalty   |
| `getStatus()`                    | View current status of agreement                  |

---

## 🧾 Example Use Cases

- Freelance contract enforcement
- Non-Disclosure Agreement (NDA)
- Partnership commitment deal
- Client-retainer trust setup

---

## 🔒 Security Notice

This contract assumes **mutual trust** in breach reporting. For real-world use, consider integrating oracles, notaries, or DAO arbitration.

---

## 📜 License

MIT — feel free to use, extend, or remix.
