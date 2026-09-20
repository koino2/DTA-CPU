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
- A small bank of working memory / cache / register bank
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

Format: ```COPY [source] [destination]```   
This copies the value of the source register to the destination register.

Example:
```
COPY READOUT, ALU_A
```
This copies the value of the cache read output register to ALU_A

### 2.2 ```SET```

Format: ```SET [destination] [value]```  
This sets the destination register to the value

Example:
```
SET ALU_OP, ADD
```
This sets the value of the ALU Operation register to the ADD function

### 2.3 ```PULSE```

Format: ```PULSE [pin]```  
This 'pulses' the given pin, i.e, the pin is set to high voltage / 1 for one clock cycle, and then set back to low voltage / 0.

Example:
```
PULSE WRITE
```
This pulses the write pin, which makes the register bank perform the writing process.

---

Each component of the processor can be controlled through its interface registers and control signals.

By changing the values of these registers, **software can control where data comes from, where it goes, and how it is processed**.  

By selecting values from one component, transferring them to another, configuring that component, and triggering any required state changes, complex operations can be constructed entirely from the three primitive instructions.

This makes the capabilities of a DTA processor largely dependent on the components it contains and how they are related to the datapath. The ISA itself does not need a separate instruction for every operation the processor can perform. The same ``COPY``, ``SET``, and ``PULSE`` primitives can be used to control different components and combine them into complex data processing operations.

For example, a value can be read from the register bank, transferred to the ALU's input, processed by the ALU, and then transferred back into the register bank. The same mechanism can be used to connect other components, allowing software to effectively control the flow of data through the processor.  

Traditional ISAs may have specific instructions for adding:  
```ADD 3 1 2``` computes the sum of register 1 and 2, and saves it to register 3.  
However, a similar functions can be achieved with DTA's primitive instructions:
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

At a high level, this does the same job of adding two values from the register bank and saving it, but with only 3 simple instructions.

> Note that the ALU does not need a ``PULSE`` instruction to do its work. The ALU is combinational / continuously active, so whenever ``ALU_A``, ``ALU_B`` and ``ALU_OP`` have values, ``ALU_OUT`` reflects the result. Meanwhile, the memory writing component / procedure is time-based and is not continuously active, and hence it needs a ``PULSE`` instruction.  

> Here, ``ALU_OP``, ``ALU_A``, etc represents the encoded value corresponding to the addition operation. The assembler can translate the symbolic name ADD into the appropriate numeric value. Similarly, ``ALU_A``, ``ALU_B``, ``ALU_OP``, ``READOUT``, etc are just hypothetical names for the numeric addresses of those registers.

The ISA therefore describes how information is transferred and how hardware components are activated, rather than defining a large collection of individual operations.

## 3. CPU Architecture
DTA CPU components are controlled through interface registers and pulse pins.
### 3.1 Registers and Pulse Pins
#### 3.1.1 Registers
The width of each register is equal to the word size of the processor.  
Registers may be read only, write only, or read and write capable.  
Every register is connected to a central Control Unit with addresses from where the ``SET`` and ``COPY`` instructions are executed.
#### 3.1.2 Pulse Pins
A pulse pin or simply pin, is a 1-wide wire that is designed to be set to ``HIGH`` for a small amount of time to trigger a time-based event.  
All pulse pins are also connected to the Control Unit with addresses to execute ``PULSE`` instructions.

### Instruction cycle

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

To interface with the memory, the following registers and pulse pins are provided: 

|   Register    | Identifier | Read/Write |                                    Description                                     |
|:-------------:|:----------:|:----------:|:----------------------------------------------------------------------------------:|
| Read Address  |   R_ADDR   | Write Only |                This register stores the address that is to be read.                |
|  Read Output  |   R_OUT    | Read Only  |   This register stores the value that has been read from the specified address.    |
| Write Address |   W_ADDR   | Write Only |             This register stores the address that is to be written to.             |
|  Write Value  |   W_VAL    | Write Only | This register stores the value that has is to be written to the specified address. |

|     Pin     | Identifier |             Description             |
|:-----------:|:----------:|:-----------------------------------:|
| Write Pulse |   WRITE    | This pin enables the writing system |

Additionally, there is also a seperate interface used for getting instructions for the fetch step.