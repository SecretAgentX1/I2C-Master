# I2C Master (Verilog)

A synthesizable I2C Master controller written in Verilog HDL. This project implements the I2C protocol using a finite state machine (FSM) and is intended for FPGA and digital design learning purposes.

## Features

- I2C Master implementation
- Supports Start and Stop conditions
- 7-bit slave addressing
- Read and Write operations
- Supports Successive Writes
- Supports Successive Reads
- ACK/NACK handling
- Finite State Machine (FSM) architecture
- Simulation testbench included

---

## Project Structure

```
.
├── I2C_master.v        # Main I2C Master module
├── I2C_master_tb.v     # Testbench
├── SCA.v               # Serial Clock Generator
└── README.md
```

---

## Inputs

| Signal | Width | Description |
|--------|------:|-------------|
| clk_i | 1 | System clock |
| rst_i | 1 | Active-low reset |
| m_start_i | 1 | Start transaction |
| m_stop_i | 1 | Stop transaction |
| m_w_r_i | 1 | Write = 0, Read = 1 |
| m_slave_add_i | 7 | Slave address |
| m_data_i | 8 | Data to transmit |
| m_ack_i | 1 | ACK input |

---

## Outputs

| Signal | Width | Description |
|--------|------:|-------------|
| m_busy_o | 1 | Master busy |
| m_error_o | 1 | Error detected |
| m_data_ready_o | 1 | Read data is valid |
| m_data_o | 8 | Received data |

---

## FSM

The controller operates through the following states:

  - IDLE
  - START
  - WRITE_ADDRESS
  - WRITE_BYTE
  - RECV_ACK_NACK
  - READ_BYTE
  - SEND_ACK_NACK
  - AFTER_ACK
  - STOP

---

## Simulation

Example using Icarus Verilog:

```bash
iverilog -o sim I2C_master.v SCA.v I2C_master_tb.v
vvp sim
```

Generate waveform:

```bash
iverilog -o sim I2C_master.v SCA.v I2C_master_tb.v
vvp sim
gtkwave dump.vcd
```

---

## Signals
1. full write byte from start to stop
   <img width="1851" height="449" alt="Screenshot_20260724_024616" src="https://github.com/user-attachments/assets/d42f84d4-d52b-433f-afab-97969f56954c" />

---

## Requirements

- Icarus Verilog
- GTKWave (optional)
- ModelSim / QuestaSim (optional)

---

## Future Improvements

- Repeated START support
- Clock stretching
- Configurable I2C clock frequency
- Arbitration support (Multi-master)

---


## Author

**SecretAgentX**
