# FPGA Project - Phase II

## Team Name:
FPGA Project Group 8


## Team Members:
- Bhasitha Dharmasena(bp2sq)
- Kavish Ranawella(bue6zr)


## Project Title: (changed with Professor's permission)
Serial RISC-V (SERV) with SPI memory access


## Project Description:
Serial RISC-V (SERV) is bit-serial CPU which claims to be the world's smallest RISC-V CPU. In the current implementation, even though most of the core components are serialized, Register File and Memory accessing is still done parallely via a Wishbone interface. With this project, we aim to achieve pure serialization by implementing memory accessing through a Serial Peripheral Interface (SPI).


## Key Objectives:
- Integrate SPI-based memory access into the SERV processor to enable fully serial data handling.
- Minimize logic-to-memory interconnect complexity by reducing bus width and interface overhead.
- Explore architectural trade-offs in designing a purely serial RISC-V system.
- Deepen understanding of serial processor behavior and execution flow through hands-on implementation.

## Expected Outcomes:

- Simulation of the SERV processor with SPI memory access using Verilator.
- Hardware implementation of SERV integrated with SPI FRAM.
- Demonstration of bare-metal program execution on the implemented hardware.

## Tasks:

- Develop Verilog code for a Wishbone-to-SPI converter.
- Verify the Wishbone-to-SPI converter through simulation and hardware testing.
- Integrate the Wishbone-to-SPI converter with the SERV CPU.
- Perform full architecture verification using simulation tools (ModelSim, Verilator).
- Validate the complete design on hardware using the Altera DE0-Nano board and SPI FRAM.
- Run and demonstrate bare-metal programs on the final hardware implementation.
- Prepare comprehensive documentation covering the design, integration, testing, and results.

## Progress so far:

Progress has been made across multiple aspects of the project in parallel. The following milestones have been achieved:

- Completed development of the Wishbone-to-SPI converter in Verilog.
- Successfully verified the converter both through simulation and hardware testing.
- Integrated the converter into the SERV CPU core.

Currently, we are in the debugging phase of the full system implementation. The hardware platform includes the Altera DE0-Nano FPGA board interfaced with an SPI FRAM module.

## File structure

- [serial_out](https://github.com/hplp/2025-fpga-design-projects-fpga_SPI_I2C/tree/main/serial_out): JTAG interface to collect the UART output of the SERV and print it on a terminal
- [testbench](https://github.com/hplp/2025-fpga-design-projects-fpga_SPI_I2C/tree/main/testbench): Verilog testbench for Wishbone to SPI convertor
- [with_spi_fram](https://github.com/hplp/2025-fpga-design-projects-fpga_SPI_I2C/tree/main/with_spi_fram): Verilog testbench for full architecture
- [verilator_tb](https://github.com/hplp/2025-fpga-design-projects-fpga_SPI_I2C/tree/main/verilator_tb): Verilator testbench for full architecture
- [fram_connect](https://github.com/hplp/2025-fpga-design-projects-fpga_SPI_I2C/tree/main/fram_connect): Hardware implementation of the full architecture
