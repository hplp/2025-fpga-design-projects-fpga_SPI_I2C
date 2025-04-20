# FPGA Project - Phase I


## Team Name:
FPGA Project Group 8


## Team Members:
- Bhasitha Dharmasena(bp2sq)
- Kavish Ranawella(bue6zr)


## Project Title:
Optimizing SPI-to-I2C Conversion using LLM prompting techniques


## Project Description:
SPI-to-I2C conversion is widely used in embedded systems and SoCs to
enable communication between devices operating on different protocols. A conventional
SPI-to-I2C conversion involves significant buffering, where the entire SPI message is first
collected before being transmitted as an I2C message. This introduces overhead and
delays due to the serial-to-parallel-to-serial conversion. To achieve a more efficient, near
real-time SPI-to-I2C conversion, buffering must be kept at a minimum. We aim to leverage
LLM-assisted optimization techniques to refine this conversion, reducing latency and
improving efficiency by enabling a more direct serial-to-serial data transfer


## Key Objectives:
- Understanding protocol bridging in a pure serial-to-serial data transfer process
- Exploring the usability of LLMs in FPGA designing optimization
- Evaluate the LLM's capabilities in uderstanding hardware designs

## Technology Stack:
- Vitis HLS
- Vivado
- C++
- Verilog
- I2C FRAM
- ChatGPT


## Expected Outcomes:
- Tested framework for the SPI-to-I2C convertor (simulation and hardware)
- ChatGPT workflow to generate two functional versions of the SPI-to-I2C convertor: the
HLS version and the Verilog version
- ChatGPT workflow to optimize the two versions while maintaining functionality
- Compiled results to compare the two approaches based on the amount of prompting
done and the level of optimization reached
- Documentation with the prompting journey to be used as a case study

## Tasks:
- Create a test framework for verilog and HLS approaches (bue6zr & bp2sq)
- Generate a functionally verified Verilog code for the SPI-to-I2C convertor (bue6zr)
- Generate a functionally verified HLS code for the SPI-to-I2C convertor (bp2sq)
- Optimize the Verilog code using ChatGPT (bue6zr)
- Optimize the HLS code using ChatGPT (bp2sq)
- Documentation (bue6zr & bp2sq)


## Timeline:
- Create a test framework for verilog and HLS approaches (upto 1 weeks)
- Generate a functionally verified Verilog and HLS codes for the SPI-to-I2C convertor (0.5 weeks)
- Optimize the Verilog and HLS codes using ChatGPT (1.5 weeks)
- Documentation (1 weeks)
