# Programmable Timer

A 4-digit programmable timer implemented in Verilog for the Basys 3 FPGA (Xilinx Artix-7). Displays time as `SS.MS` (seconds and hundredths of a second) from `00.00` to `99.99`, with count-up and count-down modes and a preset start time.

## Features

- Count up or count down with 10ms resolution
- Preset start time via onboard switches (seconds only)
- Start, pause, and reset controls
- Multiplexed 4-digit seven-segment display
- Metastability-safe button inputs via 2-stage flip-flop synchronizers

## Hardware

| Component | Part |
|-----------|------|
| Board | Digilent Basys 3 |
| FPGA | Xilinx Artix-7 (XC7A35T) |
| Clock | 100 MHz onboard oscillator |

## Operating Modes

Modes are selected using **SW1** (bit 1) and **SW0** (bit 0):

| SW1 | SW0 | Mode | Description |
|-----|-----|------|-------------|
| 0 | 0 | Count Up | Count up from `00.00` |
| 0 | 1 | Count Down | Count down from `99.99` |
| 1 | 0 | Preset Up | Count up from preset seconds value |
| 1 | 1 | Preset Down | Count down from preset seconds value |

## Controls

| Input | Pin | Function |
|-------|-----|----------|
| `btnU` (Up button) | T18 | Start / Stop (toggle) |
| `btnC` (Center button) | U18 | Reset — loads initial value for selected mode |
| SW0–SW1 | V17, V16 | Mode select |
| SW2–SW5 | W16–V15 | Preset seconds ones digit (0–9) |
| SW6–SW9 | W14–T3 | Preset seconds tens digit (0–9) |

**Setting a preset:** flip SW6–SW9 and SW2–SW5 to encode the desired start time in BCD, then press Reset. The timer loads `SS.00` where `SS` is the switch value.

## Display

The four seven-segment digits show `SS.MS`:

```
 [sec tens] [sec ones] . [ms tens] [ms ones]
```

The decimal point is always off; the dot position between digits 1 and 2 (from the right) visually separates seconds from hundredths.

## Module Hierarchy

```
top
├── ff_sync        — 2-stage synchronizer for reset button
├── ff_sync        — 2-stage synchronizer for startstop button
├── clkdiv         — 100 MHz → 10ms pulse generator
├── controller     — 4-state FSM (INIT → IDLE → RUN ↔ PAUSE, → DONE)
├── datapath
│   ├── digit_counter  (ms ones)
│   ├── digit_counter  (ms tens)
│   ├── digit_counter  (sec ones)
│   └── digit_counter  (sec tens)
├── display_mux    — time-multiplexes 4 digits onto shared segment bus
└── sevenseg       — BCD-to-7-segment decoder (active low)
```

### Key Modules

**`controller`** — FSM with four states:
- **IDLE**: waiting for Start button
- **RUN**: counting; transitions to PAUSE on button press or DONE at limit
- **PAUSE**: counting halted; resumes on button press
- **DONE**: terminal state (count reached 00.00 or 99.99 limit)

**`datapath`** — four cascaded BCD digit counters with ripple-carry enables. On reset, loads the mode-appropriate initial value. Asserts `at_zero` and `at_max` status signals back to the controller.

**`clkdiv`** — counts 1,000,000 cycles of the 100 MHz clock and emits a single-cycle `clk_10ms` pulse, giving exactly 10ms tick resolution.

**`display_mux`** — uses bits `[15:14]` of a free-running 16-bit counter to cycle through the four anodes at ~1.5 kHz refresh per digit.

## Project Structure

```
programmable-timer.srcs/
├── sources_1/new/
│   ├── top.v              — top-level module
│   ├── controller.v       — FSM
│   ├── datapath.v         — BCD counter array
│   ├── digit_counter.v    — single BCD digit with ripple
│   ├── clk_div.v          — clock divider
│   ├── display_mux.v      — display multiplexer
│   ├── sevenseg.v         — 7-segment decoder
│   └── ff_sync.v          — flip-flop synchronizer
├── sim_1/new/
│   └── top_tb.v           — testbench (all four modes + edge cases)
└── constrs_1/new/
    └── Lab6.xdc           — Basys 3 pin and timing constraints
```

## Simulation

Open the project in Vivado, set `top_tb` as the active simulation source, and run behavioral simulation. The testbench exercises all four modes including preset loading, start/stop toggling, and mode switching mid-count.

## Synthesis & Implementation

1. Open `programmable-timer.xpr` in Vivado.
2. Run **Synthesis** → **Implementation** → **Generate Bitstream**.
3. Connect the Basys 3 via USB-JTAG and program the device using **Open Hardware Manager**.

Timing constraint: 100 MHz clock (10 ns period) defined in `Lab6.xdc`.
