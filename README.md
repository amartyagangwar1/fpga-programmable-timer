# FPGA Programmable Timer / Stopwatch (Basys3, Verilog)

A four-mode programmable stopwatch/timer implemented in Verilog for the Digilent Basys3 FPGA board (Artix-7 XC7A35T). The design uses a modular RTL structure with a controller FSM, synchronous datapath, clock division, input synchronization, and a multiplexed four-digit seven-segment display.

---

## Features

- **Mode 0:** Count up from `00.00`
- **Mode 1:** Count down from `99.99`
- **Mode 2:** Count up from preset seconds (loaded from switches)
- **Mode 3:** Count down from preset seconds
- 10ms resolution (00–99 hundredths of a second)
- Start/Stop and Reset with synchronized inputs
- Controller + datapath architecture
- 4-digit seven-segment multiplexing
- Preset loading via SW2–SW9 (0–9 per digit)
- Synthesizable for Basys3 (100MHz clock)

---

## System Architecture

### **Clock Divider**
Generates a 10ms enable pulse from the 100MHz system clock.

### **Input Synchronizers**
Two-FF synchronizers for Start/Stop and Reset to avoid metastability.

### **Controller FSM**
Handles:
- start/stop control  
- up/down direction  
- zero/max detection  
- mode logic  
- preset load behavior  

### **Datapath**
Maintains the timer values:
- millisecond ones/tens  
- second ones/tens  
- up/down counting  
- preset loading  
- driven by the 10ms tick  

### **Display Multiplexer + Seven-Segment Encoder**
Cycles through the four digits and converts BCD to segment outputs.

---
