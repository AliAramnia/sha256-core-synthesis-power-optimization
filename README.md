cat > README.md << 'EOF'
# SHA-256 Core Synthesis and Power Optimization

A digital synthesis and power optimization project for a SHA-256 hardware core, developed as part of the **Synthesis and Optimization of Digital Systems** course.

## Overview

This project implements a complete synthesis and post-synthesis analysis flow for a SHA-256 hardware core. The design is synthesized using a standard-cell library, analyzed for timing and power, and optimized using clock gating and Multi-VT synthesis.

The goal of the project is to study how different synthesis and optimization techniques affect the main hardware design metrics:

- timing slack,
- cell area,
- dynamic power,
- leakage power,
- threshold-voltage cell distribution.

The project uses Synopsys Design Compiler for logic synthesis, Synopsys PrimeTime for timing and power analysis, and QuestaSim to generate VCD switching activity for power estimation.

## Project Name

**SHA-256 Core Synthesis and Power Optimization**

## Author

**ARAMNIA ALI**

## Acknowledgements

I would like to thank **Professor Valentino Peluso** and **Professor Andrea Calimera** for their lectures, laboratory material, and guidance throughout the Synthesis and Optimization of Digital Systems course.

## What This Project Does

The project starts from an RTL implementation of a SHA-256 core and performs synthesis and analysis through multiple configurations.

First, a baseline implementation is synthesized using the LVT library. Then, the clock period is explored to find the minimum valid period that satisfies both timing and area constraints.

After the baseline solution is selected, clock gating is applied to study its impact on power, performance, and area. Finally, clock gating is combined with Multi-VT synthesis using LVT, SVT, and HVT libraries to reduce leakage power and analyze the resulting trade-offs.

The project also includes a custom PrimeTime TCL procedure that reports timing paths together with the number of cells and total power of the cells in each path.

## Main Results

| Configuration | Clock Period (ns) | Area (um2) | Slack (ns) | Leakage Power (mW) | Dynamic Power (mW) |
|---|---:|---:|---:|---:|---:|
| Baseline LVT            | 2.500000 | 33207.200083 | 0.000099 | 0.01244 | 15.846 |
| Clock Gating            | 2.500000 | 30000.880089 | 0.000028 | 0.01212 | 19.597 |
| Clock Gating + Multi-VT | 2.500000 | 37878.360001 | 0.000192 | 0.006853 | 20.131 |

## Multi-VT Cell Distribution

| Cell Type | Percentage |
|---|---:|
| LVT | 38.508867% |
| SVT | 18.747738% |
| HVT | 42.743395% |

## Project Structure

```text
.
├── README.md
├── REPORT.md
├── REPORT.pdf
├── ex1
│   ├── pt_analysis.tcl
│   ├── sha256_core.sdc
│   ├── synopsys_dc.setup
│   └── synopsys_pt.setup
├── ex2.1
│   ├── pt_analysis.tcl
│   ├── sha256_core.sdc
│   ├── synopsys_dc.setup
│   ├── synopsys_pt.setup
│   └── synthesis.tcl
├── ex2.2
│   ├── pt_analysis.tcl
│   ├── sha256_core.sdc
│   ├── synopsys_dc.setup
│   ├── synopsys_pt.setup
│   └── synthesis.tcl
└── ex3
    └── custom_report.tcl
