# LAB Assembly

## Design Goals

Write an assembly language that is easy to use and complete enough to write a
full c-compiler, operating system, etc for in a cross-platform way.

## Instruction Set

Every instruction is 16 bits wide. They are interpreted, in big-endian form as
one of the following forms:

```
SFNNNKII IIIXXXXX
```

Where S indicates whether to treat values as signed or not, F as whether to
treat values as floats or not, NNN as the number of bits to use to represent
each number. IIIII is the instruction code and XXXXX is the provided argument.
If K is 0 then no expansion will be done on the results (they will be truncated
mod NNN bits), otherwise the values will expand if possible to accomodate the
desired value. Thus this flag can be considered an overflow flag.

### Codes

The instruction codes are divided into 4 blocks. Here instructions are written
in pseudo code with _ referring to the accumulator, and X referring to
the passed value. R refers to the X'th register. Square brackets around a value
denote the value in memory at that location. Curly brackets around a value
denote Load-Link/Store-Conditional memory.
 
The arithmetic block contains 8 instructions, prefixed with 11. They are:

```
Code | Signed Operation | Unsigned Operation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  0  | _ += X           | _ xor= X
  1  | _ *= X           | _ and= X
  2  | _ /= X           | _ or= X
  3  | _ %= X           | _ nand= X
  4  | _ += R           | _ xor= R
  5  | _ *= R           | _ and= R
  6  | _ /= R           | _ or= R
  7  | _ %= R           | _ nand= R
```

The memory block contains 8 instructions, prefixed with 10. They are:

```
Code | Operation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  0  | _ = [R]
  1  | [R] = _
  2  | [_] = R
  3  | R = [_]
  4  | _ = {R} 
  5  | {R} = _; _ = 1 if success, 0 otherwise
  6  | _ = R
  7  | R = _
```

The control block contains 8 instructions, prefixed with 01. They are:

```
Code | Operation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  0  | Set R to next instruction address
  1  | _ = (_ < R)
  2  | _ = (_ = R)
  3  | _ = (_ = X)
  4  | if _ go forward X instructions
  5  | if _ go to instruction at word R
  6  | go forward X instructions
  7  | go to instruction at word R
```

The system block contains 8 instructions, prefixed with 00. They are:

```
Code | Operation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  0  | Nullary operation X (See nullary ops table)
  1  | _ = _ rotl/r X
  2  | _ = _ arith_shiftl/r X
  3  | _ = _ rotl/r R
  4  | _ = _ arith_shiftl/r R
  5  | Set I/O device to _ with argument X (see I/O)
  6  | Unpriviledge R instructions, starting at _ (must be privilidged)
  7  | Go to _, then set _ to R
 ``` 

There are 32 nullary operations. They are:

```
Code | Operation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  0  | _ = 0
  1  | _ = 1
  2  | _ = 2
  3  | _ = 3
  4  | _ = 4
  5  | _ = 5
  6  | _ = 6
  7  | _ = 7
  8  | _ = 8
  9  | _ = 9
 10  | _ = 10
 11  | _ = 11
 12  | _ = 12
 13  | _ = 13
 14  | _ = 14
 15  | _ = 15
 16  | _ = 16
 17  | _ = 17
 18  | _ = 18
 19  | _ = 19
 20  | _ = 20
 21  | _ = 21
 22  | _ = 22
 23  | _ = 23
 24  | _ = 24
 25  | _ = fork()
 26  | exit(_)
 27  | _ = !_
 28  | _ = ~_
 29  | _ = read_co         
 30  | _ = device status
 31  | _ = read from device
 32  | write _ to device
```
