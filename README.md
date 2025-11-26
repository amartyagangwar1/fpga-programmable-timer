This project implements a multi-mode programmable stopwatch/timer on the Digilent Basys3 FPGA board using Verilog RTL, a custom controller/datapath architecture, and a fully multiplexed 4-digit seven-segment display.

The system supports four operating modes, including counting up, counting down, and loading custom preset values from the FPGA’s switch inputs. It is fully synthesizable and designed around clean modular components: clock divider, debounced inputs, controller FSM, time-keeping datapath, and seven-segment display driver.

⭐ Features

4 modes of operation:

Mode 0: Count up from 00.00

Mode 1: Count down from 99.99

Mode 2: Count up from externally loaded preset seconds

Mode 3: Count down from externally loaded preset seconds

10ms resolution (hundreds counted 0–99 every second)

Internal controller FSM for start/stop/reset logic

Synchronous datapath for millisecond + second counting

Button synchronizers for glitch-free operation

4-digit seven-segment display multiplexed at high refresh

Preset loading via switches (0–9 range for both digits)

Works on Artix-7 XC7A35T (Basys3)

🧩 System Architecture

This design follows a structured RTL approach:

1. Clock Divider

Generates a stable 10ms tick from the 100MHz Basys3 clock.

2. Button Synchronizers

Two-stage flip-flop synchronizers for:

Reset

Start/Stop

Prevents metastability and glitching.

3. Controller FSM

Implements:

Start/Stop toggling

Up/Down selection

Zero/Max detection

Reset behavior per mode

Preset load logic

4. Datapath

Handles:

Milliseconds ones/tens

Seconds ones/tens

Up/down counting

Load preset values

Count enable gating

5. Display MUX + Seven-Segment Encoder

Refreshes the four digits and encodes BCD→7-segment segments.
