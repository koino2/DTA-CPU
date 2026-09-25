# DTA - Data Transfer Architecture
## ISA & CPU Architecture Specification

## 1. Introduction
DTA (Data Transfer Architecture) is a minimal and modular CPU architecture designed around a small amount of fundamental datapath control operations rather than a large collection of specialised instructions.  

The ISA provides a mechanism for moving values between components of the processor and triggering those components.  

This also allows DTA CPUs to be modular, i.e. various components of the processor are not fixed but can be changed, and functionality still remains similar. Individual components may be implemented separately while communicating through defined architectural interfaces.

Instead of providing dedicated instructions for arithmetic, memory access, branching, device access, and other operations, DTA exposes a small set of general purpose instructions that can be composed to perform more complex operations.

Most existing ISAs have instructions for each function a processor can perform, like ```ADD```, ```SUB```, ``LOAD``, ``STORE``, ``JUMP``, etc. However, DTA consists of only 3 primitive instructions:  
- ```COPY```
- ```SET```
- ```PULSE```

Higher level operations can be constructed using these primitives.  

The processor is built primarily from:
- A small bank of working memory
- An ALU
- A program counter
- DSC (Device Slot Controller) for I/O

## 2. Instructions
The base instruction set consists of three instructions:
- ```COPY```
- ```SET```
- ```PULSE```

These are general purpose instructions that only control the datapath. The functionality / actual processing happens within the various components of the CPU.  

### 2.1 ```COPY```
This instruction copies the value of one register to another.

Opcode: 01

Format: ```COPY [source] [destination]```   
This copies the value of the source register to the destination register.

Example:
```
COPY READOUT, ALU_A
```
This copies the value of the cache read output register to ALU_A

### 2.2 ```SET```

Opcode: 10

Format: ```SET [destination] [value]```  
This sets the destination register to the value

Example:
```
SET ALU_OP, ADD
```
This sets the value of the ALU Operation register to the ADD function

> The ISA does not define ALU operation codes. Each ALU implementation defines the encoding of ALU_OP.

### 2.3 ```PULSE```

Opcode: 11

Format: ```PULSE [pin]```  
This 'pulses' the given pin, i.e, the pin is set to high voltage / 1 for one clock cycle, and then set back to low voltage / 0.

Example:
```
PULSE WRITE
```
This pulses the write pin, which makes the register bank perform the writing process.

### 2.4 ```NOP```

Opcode: 00

Format: ```NOP```  
Does nothing

---

Each component of the processor can be controlled through its interface registers and control signals.

By changing the values of these registers, software can control where data comes from, where it goes, and how it is processed.  

By selecting values from one component, transferring them to another, configuring that component, and triggering any required state changes, complex operations can be constructed entirely from the three primitive instructions.

This makes the capabilities of a DTA processor largely dependent on the components it contains and how they are related to the datapath. The ISA itself does not need a separate instruction for every operation the processor can perform. The same ``COPY``, ``SET``, and ``PULSE`` primitives can be used to control different components and combine them into complex data processing operations.

For example, a value can be read from the register bank, transferred to the ALU's input, processed by the ALU, and then transferred back into the register bank. The same mechanism can be used to connect other components, allowing software to effectively control the flow of data through the processor.  

Traditional ISAs may have specific instructions for adding:  
```ADD 3 1 2``` computes the sum of register 1 and 2, and saves it to register 3.  
However, a similar function can be achieved with DTA's primitive instructions:
```
SET READADDR 1
COPY READOUT, ALU_A
SET READADDR 2
COPY READOUT, ALU_B
SET ALU_OP, ADD
SET WRITEADDR 3
COPY ALU_OUT, WRITEVAL
PULSE WRITE
```

This code first sets the read address to `1`, causing the register bank's read output to provide the value stored at address `1`. That value is then copied into `ALU_A`.

The read address is then set to `2`, and the value at that address is copied into `ALU_B`.

`ALU_OP` is set to `ADD`.

Finally, the write address is set to `3`. The ALU output is copied into `WRITEVAL`, and the write operation is pulsed, storing the result at address `3` in the register bank.

At a high level, this does the same job of adding two values from the register bank and saving it, but with only 3 primitive instruction types.

> Note that the ALU does not need a ``PULSE`` instruction to do its work. The ALU is combinational / continuously active, so whenever ``ALU_A``, ``ALU_B`` and ``ALU_OP`` have values, ``ALU_OUT`` reflects the result. Meanwhile, the memory writing component / procedure is time-based and is not continuously active, and hence it needs a ``PULSE`` instruction.  

> Here, ``ALU_OP``, ``ALU_A``, etc represents the encoded value corresponding to the addition operation. The assembler can translate the symbolic name ADD into the appropriate numeric value. Similarly, ``ALU_A``, ``ALU_B``, ``ALU_OP``, ``READOUT``, etc are just hypothetical names for the numeric addresses of those registers.

The ISA therefore describes how information is transferred and how hardware components are activated, rather than defining a large collection of individual operations.

## 3. CPU Architecture

DTA CPU components are controlled through interface registers and pulse pins.

The word size is implementation-defined.

### 3.1 Registers and Pulse Pins

#### 3.1.1 Registers
The width of each register is equal to the word size of the processor.  
Registers may be read only, write only, or read and write capable.  
Every register is connected to a central Control Unit with addresses from where the ``SET`` and ``COPY`` instructions are executed.
#### 3.1.2 Pulse Pins
A pulse pin or simply pin, is a 1-wide wire that is designed to be set to ``HIGH`` for a small amount of time to trigger a time-based event.  
All pulse pins are also connected to the Control Unit with addresses to execute ``PULSE`` instructions.

Registers and pulse pins have separate address spaces; therefore, a register address may have the same numeric value as a pulse-pin address.

### 3.2 Instruction Encoding
Each instruction has a fixed length of 3 words, which is enough to accommodate the longest instruction.

The base instruction encoding is as follows:

| Instruction |   Word 0    |   Word 1    |   Word 2    |
|:-----------:|:-----------:|:-----------:|:-----------:|
|   ``NOP``   | Opcode (00) |  Reserved   |  Reserved   |
|  ``COPY``   | Opcode (01) |   Source    | Destination |
|   ``SET``   | Opcode (10) | Destination |    Value    |
|  ``PULSE``  | Opcode (11) |     Pin     |  Reserved   |

The opcode occupies the least significant two bits of Word 0. The remaining bits are ignored.

### 3.3 Instruction cycle
DTA instructions have a fixed length of 3 words. The processor executes one instruction per clock cycle.  

During the start of an instruction cycle, the Program Counter provides the address of the current instruction being executed to the working memory read address. The address is sent to the working memory through another wire called the PC Address Line. This line merges with the main read address line and is finally connected to the working memory.

This causes the memory bank to look up the address and return the instruction in the form of 3 words in registers ``R_OUT``, ``R_OUT2``, and ``R_OUT3``.

These bytes are sent to an instruction decoder and control unit. As soon as these bytes arrive, the PC Address Line is logically disconnected from the working memory address. This frees up the address line for main instruction execution.

Once the bytes reach the instruction decoder, the ``SET``, ``COPY``, and ``PULSE`` instructions are executed.

The program counter is incremented during the falling edge of the clock, and the cycle repeats.

### 3.4 Boot sequence
The CPU starts processing instructions from the address 0 in memory. It increments by 3 every clock cycle.  
The first few bytes of the memory are mapped to a ROM or other nonvolatile storage device, which holds instructions for a boot program. (More detail is given in the memory module description)

These instructions are executed in the same way as normal instructions.

## 4. CPU Components

The CPU is made of these core systems: 
- Working memory
- ALU
- RAM Interface
- Program Counter
- Device Slot Controller (DSC)
- Instruction Decoder

### 4.1 Working Memory
Each CPU has a bank of working memory, or cache.  

The working memory provides the main fast memory available to the CPU and stores the currently executing program and temporary data.  

A fixed portion of the address space starting at address 0 is reserved for a boot program. This address range is mapped to a ROM or other non-volatile memory device, so attempting to read those addresses returns the contents of that device instead of the working memory.

Memory is word addressed, and each address identifies one word of memory.

The maximum amount of memory is limited by the maximum possible value of a register of the word size, since the width of the address is the word size.

Addresses that are out of range for the memory module should return zero. (includes R_OUT2 and R_OUT3 values)

To interface with the memory, the following registers and pulse pins are provided: 

|   Register    | Identifier | Address | Read/Write |                                    Description                                    |
|:-------------:|:----------:|:-------:|:----------:|:---------------------------------------------------------------------------------:|
| Read Address  |   R_ADDR   |  0 [0]  | Write Only |               This register stores the address that is to be read.                |
|  Read Output  |   R_OUT    |  1 [1]  | Read Only  |   This register stores the value that has been read from the specified address.   |
| Read Output 2 |   R_OUT2   | 2 [10]  | Read Only  |    This register stores the value that has been read from the address R_ADDR+1    |
| Read Output 3 |   R_OUT3   | 3 [11]  | Read Only  |    This register stores the value that has been read from the address R_ADDR+2    |
| Write Address |   W_ADDR   | 4 [100] | Write Only |            This register stores the address that is to be written to.             |
|  Write Value  |   W_VAL    | 5 [101] | Write Only |  This register stores the value that is to be written to the specified address.   |

|     Pin     | Identifier | Address |             Description             |
|:-----------:|:----------:|:-------:|:-----------------------------------:|
| Write Pulse |   WRITE    |  0 [0]  | This pin enables the writing system |

### 4.2 Arithmetic and Logic Unit (ALU)
The ALU component is a module that can perform various operations on values.

Actual functions and operations that the ALU performs are implementation defined and are not specified by the ISA.

The ALU interface registers and pins are as follows: 

|   Register    | Identifier | Address  | Read/Write |                                   Description                                    |
|:-------------:|:----------:|:--------:|:----------:|:--------------------------------------------------------------------------------:|
|     ALU A     |   ALU_A    | 6 [110]  | Write Only |   The "A" value, on which operations are performed along with or without ALU_B   |
|     ALU B     |   ALU_B    | 7 [111]  | Write Only |        The "B" value, on which operations are performed along with ALU_A         |
| ALU Operation |   ALU_OP   | 8 [1000] | Write Only | The operation code that defines which operation is performed on ALU_A and ALU_B  |
|  ALU Output   |  ALU_OUT   | 9 [1001] | Read Only  | The output calculated by the ALU, based on ALU_A, ALU_B and the operation ALU_OP |

The ALU is continuously active, and it does not need a pulse for ALU_OP to be computed.

### 4.3 RAM Interface
The CPU communicates with external RAM through a dedicated interface.

To the processor, RAM appears as a large, addressable memory space containing values at different addresses.

Reads are continuously reflected through RAM_R_OUT, while writes are performed by providing an address and value and pulsing RAM_WRITE.

|     Register      | Identifier |  Address  | Read/Write |                                         Description                                          |
|:-----------------:|:----------:|:---------:|:----------:|:--------------------------------------------------------------------------------------------:|
| RAM Read Address  | RAM_R_ADDR | 10 [1010] | Write Only |                This register stores the address that is to be read from RAM.                 |
|  RAM Read Output  | RAM_R_OUT  | 11 [1011] | Read Only  | This register continuously reflects the value stored at the address specified by RAM_R_ADDR. |
| RAM Write Address | RAM_W_ADDR | 12 [1100] | Write Only |              This register stores the address that is to be written to in RAM.               |
|  RAM Write Value  | RAM_W_VAL  | 13 [1101] | Write Only |    This register stores the value that is to be written to the specified address in RAM.     |

|       Pin       | Identifier | Address |                                                   Description                                                   |
|:---------------:|:----------:|:-------:|:---------------------------------------------------------------------------------------------------------------:|
| RAM Write Pulse | RAM_WRITE  |  1 [1]  | This pin triggers the write operation, writing the value of ``RAM_W_VAL`` to the address ``RAM_W_ADDR`` in ram. |

### 4.4 Program Counter
The program counter is the component that stores the address of the instruction currently being executed.

It has a adder connected to it to increment the address by 3 every instruction, effectively moving to the next instruction in memory.

The program counter also facilitates direct jump and conditional jump operations.

|    Register     | Identifier |  Address   |  Read/Write  |                               Description                               |
|:---------------:|:----------:|:----------:|:------------:|:-----------------------------------------------------------------------:|
| Program Counter |     PC     | 14 [1110]  | Read & Write |         The current address of the instruction being executed.          |
|      Value      |  PC_VALUE  | 15 [1111]  |  Write Only  |         The value which is compared for conditional statements          |
|     Target      | PC_TARGET  | 16 [10000] |  Write Only  |               The target value for conditional statements               |
|      Jump       |   PC_JMP   | 17 [10001] |  Write Only  | The address which will be loaded into the PC if the comparison succeeds |

| Pin  | Identifier | Address |                   Description                    |
|:----:|:----------:|:-------:|:------------------------------------------------:|
| Jump |    JUMP    | 2 [10]  | This pin triggers the conditional jump sequence. |

The program counter is incremented during the falling edge of the clock. It is incremented by 3 every time.

For unconditional jumps, the Program Counter register can be directly updated to order to effectively jump to the address.

Conditional jumps are also possible, by checking if one value is equal to another value.
When the Jump pin is triggered, a conditional jump is executed, causing the program counter to jump to the value of PC_JMP only if PC_VALUE is equal to PC_TARGET.

> The program counter increments during the falling edge, while the jump actions (and all execution) are performed during the clock's high period. Thus, the clock increments even after the jump statement, and so the next instruction that will be executed is the instruction at the jump address + 3. Therefore, a jump to location X results in execution continuing at address X+3

### 4.5 Device Slot Controller
The Device Slot Controller (DSC) is a component for communicating with external devices and general I/O.

Communication with DSC devices happens through interface registers DSC_D0-7, DSC_STATUS and DSC_DEVICE, as well as 5 general purpose pulse pins.

|     Register      |  Identifier   |         Address         |  Read/Write  |                                      Description                                      |
|:-----------------:|:-------------:|:-----------------------:|:------------:|:-------------------------------------------------------------------------------------:|
|   DSC Data 0-7    | DSC_D0-DSC_D7 | 18-25 [10010] - [11001] | Read & Write | Eight general purpose interface registers labelled DSC_D0, DSC_D1, DSC_D2, ... DSC_D7 |
| DSC Device Status |  DSC_STATUS   |       26 [11010]        |  Read Only   |    A one word register reflecting the status of the device, stated by the device.     |
|    DSC Device     |  DSC_DEVICE   |       27 [11011]        |  Write Only  |               The address of the device currently activated by the DSC.               |

|     Pin     |  Identifier   |    Address    |                       Description                       |
|:-----------:|:-------------:|:-------------:|:-------------------------------------------------------:|
| DSC Pin 0-4 | DSC_P0-DSC_P4 | 3-7 [011-111] | General purpose pulse pins for interfacing with devices |

Each device slot has its own device address. The number of slots depends on the implementation of the DSC.

The DSC device register holds the address of the device currently being interacted with. When a value is present in the DSC Device register, all other DSC device interfaces apart from the one with that address are deactivated.

The DSC data registers 0-7 are for communicating with the selected device. The DSC Device Status register is read only, and it holds information about the activated device's status. This status register is controlled by the device.

Additionally, there are 5 general purpose pulse pins for each device. Triggering one of the DSC pins from the CPU pulses the appropriate pin on that device.

Each device exposes 8 data registers, 1 status register and 5 pulse pins. The DSC selects the device currently being accessed and provides the interface for reading from and writing to it.

## Complete tables of registers and pins

### Registers

|     Register      |  Identifier   |         Address         |  Read/Write  |                                         Description                                          |
|:-----------------:|:-------------:|:-----------------------:|:------------:|:--------------------------------------------------------------------------------------------:|
|   Read Address    |    R_ADDR     |          0 [0]          |  Write Only  |                     This register stores the address that is to be read.                     |
|    Read Output    |     R_OUT     |          1 [1]          |  Read Only   |        This register stores the value that has been read from the specified address.         |
|   Read Output 2   |    R_OUT2     |         2 [10]          |  Read Only   |         This register stores the value that has been read from the address R_ADDR+1          |
|   Read Output 3   |    R_OUT3     |         3 [11]          |  Read Only   |         This register stores the value that has been read from the address R_ADDR+2          |
|   Write Address   |    W_ADDR     |         4 [100]         |  Write Only  |                  This register stores the address that is to be written to.                  |
|    Write Value    |     W_VAL     |         5 [101]         |  Write Only  |      This register stores the value that has is to be written to the specified address.      |
|       ALU A       |     ALU_A     |         6 [110]         |  Write Only  |         The "A" value, on which operations are performed along with or without ALU_B         |
|       ALU B       |     ALU_B     |         7 [111]         |  Write Only  |              The "B" value, on which operations are performed along with ALU_A               |
|   ALU Operation   |    ALU_OP     |        8 [1000]         |  Write Only  |       The operation code that defines which operation is performed on ALU_A and ALU_B        |
|    ALU Output     |    ALU_OUT    |        9 [1001]         |  Read Only   |       The output calculated by the ALU, based on ALU_A, ALU_B and the operation ALU_OP       |
| RAM Read Address  |  RAM_R_ADDR   |        10 [1010]        |  Write Only  |                This register stores the address that is to be read from RAM.                 |
|  RAM Read Output  |   RAM_R_OUT   |        11 [1011]        |  Read Only   | This register continuously reflects the value stored at the address specified by RAM_R_ADDR. |
| RAM Write Address |  RAM_W_ADDR   |        12 [1100]        |  Write Only  |              This register stores the address that is to be written to in RAM.               |
|  RAM Write Value  |   RAM_W_VAL   |        13 [1101]        |  Write Only  |  This register stores the value that has is to be written to the specified address in RAM.   |
|  Program Counter  |      PC       |        14 [1110]        | Read & Write |                    The current address of the instruction being executed.                    |
|       Value       |   PC_VALUE    |        15 [1111]        |  Write Only  |                    The value which is compared for conditional statements                    |
|      Target       |   PC_TARGET   |       16 [10000]        |  Write Only  |                         The target value for conditional statements                          |
|       Jump        |    PC_JMP     |       17 [10001]        |  Write Only  |           The address which will be loaded into the PC if the comparison succeeds            |
|   DSC Data 0-7    | DSC_D0-DSC_D7 | 18-25 [10010] - [11001] | Read & Write |    Eight general purpose interface registers labelled DSC_D0, DSC_D1, DSC_D2, ... DSC_D7     |
| DSC Device Status |  DSC_STATUS   |       26 [11010]        |  Read Only   |        A one byte register reflecting the status of the device, stated by the device.        |
|    DSC Device     |  DSC_DEVICE   |       27 [11011]        |  Write Only  |                  The address of the device currently activated by the DSC.                   |

### Pins

|       Pin       |  Identifier   |    Address    |                                                   Description                                                   |
|:---------------:|:-------------:|:-------------:|:---------------------------------------------------------------------------------------------------------------:|
|   Write Pulse   |     WRITE     |     0 [0]     |                                       This pin enables the writing system                                       |
| RAM Write Pulse |   RAM_WRITE   |     1 [1]     | This pin triggers the write operation, writing the value of ``RAM_W_VAL`` to the address ``RAM_W_ADDR`` in ram. |
|      Jump       |     JUMP      |    2 [10]     |                                This pin triggers the conditional jump sequence.                                 |
|   DSC Pin 0-4   | DSC_P0-DSC_P4 | 3-7 [011-111] |                             General purpose pulse pins for interfacing with devices                             |

## the end