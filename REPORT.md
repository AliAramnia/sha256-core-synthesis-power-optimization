cat > REPORT.md << 'EOF'
# SHA-256 Core Logic Synthesis and Power Optimization  
## Detailed Project Report

## 1. Project Introduction

This project was developed as part of the **Synthesis and Optimization of Digital Systems** course.

The objective of this project is to perform a complete logic synthesis and post-synthesis analysis flow for a SHA-256 hardware core. The design was provided at RTL level and synthesized using a standard-cell technology library. The project focuses on evaluating the main hardware design metrics after synthesis:

- timing slack,
- cell area,
- dynamic power,
- leakage power,
- clock-gating impact,
- Multi-VT synthesis impact,
- custom timing-path reporting using TCL in PrimeTime.

SHA-256 is a cryptographic hash algorithm widely used in security applications. In this project, the main focus is not the cryptographic algorithm itself, but the synthesis and optimization of its hardware implementation.

---

## 2. Tools Used

The following tools were used in the project:

| Tool | Purpose |
|---|---|
| Synopsys Design Compiler | Logic synthesis |
| Synopsys PrimeTime | Static timing analysis and power analysis |
| QuestaSim | Post-synthesis simulation and VCD generation |
| TCL | Automation and custom reporting |
| STcmos65 standard-cell libraries | Technology libraries for synthesis and analysis |

---

## 3. Project Flow

The project follows a standard digital synthesis and post-synthesis analysis flow:

```text
RTL Verilog
   |
   v
Logic Synthesis with Synopsys Design Compiler
   |
   v
Post-Synthesis Netlist and SDC
   |
   v
Post-Synthesis Simulation with QuestaSim
   |
   v
VCD File Generation
   |
   v
PrimeTime Timing and Power Analysis
