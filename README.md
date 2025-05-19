# **Fitness Tracker on Nexys A7-100T**

## **Overview**
This project implements a simplified version of a Fitbit-like activity tracker on the **Nexys A7-100T FPGA board** using **Verilog**. The system tracks user steps, calculates distance, and displays metrics in real time on a 6-digit 7-segment display. The design emphasizes modular hardware architecture, real-time input handling, and effective display control.

## **Features**
- **Step Tracking:** Counts steps based on user input (simulated via push-buttons).
- **Distance Calculation:** Converts steps to distance using fixed logic.
- **Mode Rotation:** Switches display between step count, distance, and current mode.
- **Real-Time Display:** Outputs values to a 6-digit 7-segment display.

## **System Architecture**
The project consists of the following Verilog modules:
- **Debounce Modules:** Filter mechanical noise from push-buttons (START/STOP).
- **Pulse Generator:** Converts button press events into clean pulses.
- **Fitbit Tracker Module:** Core logic for step counting and metric computation.
- **Binary to BCD Converter:** Implements the Double Dabble algorithm to prepare values for display.
- **Rotation Module:** Rotates between different display modes.
- **BCD to 7-Segment Converter:** Converts BCD values to 7-segment encoding.

## **Hardware**
- **Board Used:** Nexys A7-100T
- **Display:** 6-digit 7-segment LED
- **Inputs:** Two push-buttons (simulated START and STOP)
- **Outputs:** Dynamic metric display cycling through step count and distance

## **Outcome**
Successfully deployed the design onto the Nexys A7-100T board with clean user interaction, accurate metric tracking, and smooth real-time visual output. The project highlights structured digital design and integration of multiple subsystems on FPGA.

## **Demo**
 [Watch Explanation Video](https://drive.google.com/file/d/1wQbRALDL-USc6IeVVzssgsk52rIvq4YW/view?usp=sharing)  
[Watch Demo Video on FPGA Board](https://drive.google.com/file/d/1wQbRALDL-USc6IeVVzssgsk52rIvq4YW/view?usp=sharing)
