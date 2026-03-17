# 🔬 RISC-V Pipeline Hazard Injection and Analysis

![RISC-V](https://img.shields.io/badge/Architecture-RISC--V-blue?style=for-the-badge&logo=riscv)
![Simulator](https://img.shields.io/badge/Simulator-Ripes-green?style=for-the-badge)
![Language](https://img.shields.io/badge/Language-Assembly-orange?style=for-the-badge)
![Pipeline](https://img.shields.io/badge/Pipeline-5--Stage-red?style=for-the-badge)

> Simulation and analysis of pipeline hazards in a **5-stage RISC-V processor** using the **Ripes simulator** — covering RAW, Load-Use, Control, and Combination hazards through real assembly programs.

---

## 📌 Table of Contents

- [Overview](#-overview)
- [Pipeline Architecture](#-pipeline-architecture)
- [Modules Implemented](#-modules-implemented)
- [Hazard Analysis](#-hazard-analysis)
- [Screenshots](#-screenshots)
- [CPI Observations](#-cpi-observations)
- [Tools Used](#️-tools-used)
- [How to Run](#-how-to-run)
- [Key Takeaways](#-key-takeaways)

---

## 📖 Overview

This project demonstrates how **pipeline hazards** affect the correctness and performance of a 5-stage RISC-V processor. Four assembly programs were designed to intentionally trigger specific types of hazards, which were then observed and analyzed using the **Ripes** visual pipeline simulator.

Each program highlights a different hazard category and shows how the processor handles it through **stalling**, **forwarding**, or **flushing**.

---

## ⚙️ Pipeline Architecture

The 5-stage pipeline used in this project:

```
IF  →  ID  →  EX  →  MEM  →  WB
```

| Stage | Full Name        | Function                          |
|-------|------------------|-----------------------------------|
| IF    | Instruction Fetch   | Fetch instruction from memory  |
| ID    | Instruction Decode  | Decode and read registers      |
| EX    | Execute             | ALU operation / address calc   |
| MEM   | Memory Access       | Read/write data memory         |
| WB    | Write Back          | Write result to register file  |

**Key Hardware Units:**
- 🔁 **Forwarding Unit** — routes results directly between pipeline stages
- 🛑 **Hazard Detection Unit** — detects stalls and flushes
- 🔀 **Branch Predictor** — handles control flow decisions

---

## 🧩 Modules Implemented

### 1. 🔹 Linear Search — *Load-Use Hazard*
**File:** `linear_search.s`

Searches for a target element in an array. A `lw` instruction is immediately followed by an instruction that uses the loaded value — causing an unavoidable **1-cycle stall** that cannot be resolved by forwarding alone.

---

### 2. 🔹 Matrix Multiplication — *RAW Hazard (Read After Write)*
**File:** `matrix_multiplication.s`

Multiplies two matrices using nested loops. Intermediate values written to registers are immediately read in the next instruction — triggering **RAW hazards**, resolved via the forwarding unit.

---

### 3. 🔹 Quick Sort — *Control Hazard*
**File:** `quick_sort.s`

Recursive sorting algorithm with frequent branching. Each conditional branch causes a **pipeline flush** (2-3 cycle penalty) when mispredicted — a classic **control hazard**.

---

### 4. 🔹 Insertion Sort — *Combination of Hazards*
**File:** `insertion_sort.s`

Combines all hazard types in a single program — RAW hazards from comparisons, load-use stalls from array loads, and control hazards from branch instructions. Best demonstrates **real-world pipeline behavior**.

---

## 📊 Hazard Analysis

| Program              | Hazard Type       | Cause                             | Resolution              |
|----------------------|-------------------|-----------------------------------|-------------------------|
| Linear Search        | Load-Use          | `lw` followed by dependent `beq` | 1-cycle pipeline stall  |
| Matrix Multiplication| RAW               | Register written then immediately read | Data forwarding    |
| Quick Sort           | Control           | Branch instructions               | Pipeline flush          |
| Insertion Sort       | Combination       | Mix of all above                  | Stall + Forward + Flush |

---

## 📸 Screenshots

> *Add your Ripes simulator screenshots in the `screenshots/` folder and they will appear below.*

### Load-Use Hazard (Linear Search)
![Load-Use Hazard](screenshots/load_use.png)

### RAW Hazard (Matrix Multiplication)
![RAW Hazard](screenshots/raw_hazard.png)

### Control Hazard (Quick Sort)
![Control Hazard](screenshots/control_hazard.png)

---

## 📈 CPI Observations

| Program              | Ideal CPI | Actual CPI | Stall Cycles | Notes                        |
|----------------------|-----------|------------|--------------|------------------------------|
| Linear Search        | 1.0       | > 1.0      | Load-use stalls | 1 stall per load-use pair |
| Matrix Multiplication| 1.0       | ~1.0       | Minimal      | Forwarding resolves most RAW |
| Quick Sort           | 1.0       | > 1.0      | Branch flushes | Each misprediction = flush  |
| Insertion Sort       | 1.0       | > 1.0      | Mixed         | Worst-case CPI degradation  |

> 💡 **CPI (Cycles Per Instruction):** A value greater than 1.0 indicates pipeline inefficiency due to hazards.

---

## 🛠️ Tools Used

| Tool         | Purpose                              |
|--------------|--------------------------------------|
| [Ripes](https://github.com/mortbopet/Ripes) | Visual RISC-V pipeline simulator |
| RISC-V Assembly (RV32I) | Writing test programs          |
| Ripes Pipeline Viewer | Observing stalls, flushes, forwarding |

---

## ▶️ How to Run

1. **Download Ripes** from [github.com/mortbopet/Ripes/releases](https://github.com/mortbopet/Ripes/releases)
2. Open Ripes and select **5-Stage Pipelined Processor**
3. Enable **Forwarding** and **Hazard Detection** as needed
4. Load any `.s` file:
   - Go to **Editor** tab → paste or open the `.s` file
5. Click **Run** or step through instruction-by-instruction
6. Observe the **Pipeline Diagram** for stalls (bubbles) and flushes

---

## 🎯 Key Takeaways

- ✅ **Forwarding** eliminates most RAW hazards without stalls
- ⚠️ **Load-Use hazards** always introduce at least **1 stall cycle** — unavoidable
- 🔄 **Control hazards** cause **pipeline flushes** on branch mispredictions
- 📉 **Without hazard detection**, the processor executes instructions **incorrectly**
- 🏗️ Proper hardware design (forwarding + hazard detection) is essential for correctness

---

## 👨‍💻 Authors

> 📌 *Add your name, college, and course details here.*

```
Name   : Alphonsa Sooter,Ancy Wilson,Annmariya Saju,Anix k Binoj,Irin Ann Shaji
Course : Computer Organization &  Architecture
College: MBCCET
Year   : 2024-2028
```

---

⭐ *If you found this project useful, consider giving it a star!*
