# reflex_tester
# Reaction Timer — FPGA Design Space Exploration

A reaction time measurement system implemented in VHDL for the Digilent Nexys 4 FPGA board (Xilinx Artix-7 XC7A100T). This project was developed as a case study for introducing high school students to Electronic Design Automation (EDA) and Design Space Exploration (DSE): the same specification is implemented in three different ways, allowing a direct comparison of hardware metrics such as LUT usage, Flip-Flop count, and timing.

---

## How it works

After pressing the start button, the system waits for a random delay before turning on a LED. The player must press the button as soon as the LED turns on. The reaction time is measured in milliseconds and shown on the seven segment display. The system also handles edge cases: false starts (pressing the button before the LED turns on) and timeouts (not pressing the button within 1000 ms).

---

## Repository structure

```
├── reflex_tester1.vhdl   # Implementation 2: free running counter + binary counter + sequential Double Dabble BCD conversion
├── reflex_tester2.vhdl   # Implementation 1: LFSR + BCD cascade counter
├── reflex_tester3.vhdl   # Implementation 3: LFSR + binary counter + average over 5 measurements
├── tb1.vhdl              # Testbench for implementations 1 and 2
├── tb2.vhdl              # Testbench for implementation 3
├── port_map.xdc          # Pin mapping constraints for the Nexys 4 board
└── documentation.zip     # Full project documentation (architectural choices, module descriptions)
```

---

## Implementations

| | Implementation 1 | Implementation 2 | Implementation 3 |
|---|---|---|---|
| Random delay | free running counter | LFSR | LFSR |
| Time measurement | Binary counter | BCD cascade counter | Binary counter |
| BCD conversion | Sequential Double Dabble |  None (direct) | Sequential Double Dabble |
| Result | Single measurement | Single measurement | Average of 5 measurements |
| LUT | 123 | 92 | 184 |
| FF | 185 | 123 | 209 |
| Max frequency | ~191 MHz | ~194 MHz | ~173 MHz |

---

## Hardware requirements

- Digilent Nexys 4 board (Xilinx Artix-7 XC7A100T)
- USB cable for programming
- Xilinx Vivado 2016.1 or later

---

## How to use

### Simulation
1. Create a new Vivado project targeting the `XC7A100T-1CSG324C` device
2. Add the desired implementation file and the corresponding testbench as sources
3. Set the testbench as the simulation top module
4. Run behavioral simulation and inspect the waveforms

`tb1.vhdl` covers implementations 1 and 2; `tb2.vhdl` covers implementation 3.

### Synthesis, implementation and programming
1. Create a new Vivado project targeting the `XC7A100T-1CSG324C` device
2. Add the desired implementation file as a design source
3. Add `port_map.xdc` as a constraints file
4. Set `reflex_tester` as the top module
5. Run synthesis → implementation → generate bitstream
6. Connect the Nexys 4 board via USB, open the Hardware Manager, and program the device

### Test on FPGA
1. Press reset button
2. Press start and get ready to see led light up
3. Press stop as soon as the led lights up
4. Visualize result
5. Depending on implementation, repeat test when asked to or press start/reset to repeat
---

## Inputs and outputs

| Signal | Direction | Description |
|---|---|---|
| `clk` | Input | 100 MHz system clock  |
| `rst` | Input | Synchronous reset — upper button (BTNU, 11 upper in the image below) |
| `i_start_stop` | Input | Start/stop button — centre button (BTNC, 11 center in the image below) |
| `o_led` | Output | GO signal LED (LD0, 7 on the right in the image below) |
| `display[6:0]` | Output | Seven segment display segment drivers (active low) |
| `an[7:0]` | Output | Display anode enables (active low) |

<img width="610" height="758" alt="image" src="https://github.com/user-attachments/assets/a6fadd6b-52ed-4461-b3fc-772fcd76518d" />

---

## Video tutorials

Three screen recording tutorials are available to guide you through the Vivado workflow:

- **Creating a new Project** — how to set up a Vivado project and add design files
- **Running a Simulation** — how to run a behavioral simulation and read the waveforms
- **Programming a FPGA** — how to run synthesis, implementation, generate the bitstream, and program the Nexys 4 board

---

## Documentation

The `documentation.zip` file contains the full project report, covering the motivation behind each architectural choice, a description of all modules, simulation results, synthesis and timing reports, and a comparison of the three implementations from a Design Space Exploration perspective.
