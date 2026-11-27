# DTA (Data Transfer Architecture)
DTA is a type of CPU Architecture / Instruction Set Architecture designed for minimal CPU logic complexity and a simple instruction set.

## ISA
The ISA specification can be found at ``/spec-1/DTA.md``

### Programs
There are several demo / test programs located in ``/programs``.
Keep in mind that many of these were made during development of the ISA and won't work properly.

### Emulator
I have also made an emulator for a DTA processor, which can be found at github.com/koino2/DTA-Emulator

## Instructions
The ISA only has 3 instructions: ``COPY [01]``, ``SET [10]``, and ``PULSE [11]``.
- ``COPY`` copies the value of one register to another register
- ``SET`` sets the value of a register to a certain value
- ``PULSE`` pulses a pin for 1 clock cycle.