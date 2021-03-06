## Preface 

The LAB machine language is designed such that its code is somewhat legible as
an ASCII file. It can be used as an educational language to teach assembly in a
relatively high-level environment.

Each operation takes a single argument. Each symbol has a different meaning
depending on situation. 




## Preface

The LAB machine language is a modal machine language designed such that its code
is somewhat legible as an ASCII file. It can be used as an educational language
to teach assembly in a relatively high-level environment.

This **is** a Von Neumann architecture, even if it doesn't always look like one.
Indeed this code can be executed as it sees values, and does not need any form
of parser. 

## Registers

All latin alphabet characters are registers, and can be accessed either
lowercase or uppercase. There are also a few special registers. The '\_'
register represents the current accumulator. It is not directly accessible.

## Modes

Every command is a single byte. Its effect will change depending on the mode.
Each command has an execution time, and each mode has a decoding time. Add the
two to determine the time of the resulting execution.

In the following descriptions 'Next' indicates the next mode, and _ is the
accumulator. When a command takes a register, it is denoted by ?.

Many modes merely expect some constant. They are all very similar. Their effects
are denoted under results with x as the value. Their state is described in
{Number Mode}. These modes are indicated with an exclamation mark.

The current memory address is indicated by * and the current program counter is
indicated by @. If @ is not modified, assume it is incremented.

Any unlisted modes are assumed to be NOPs. 
All operations are atomic in memory. Multiple threads have unique stacks and
registers. Each thread shares dynamic memory (other than stack) and static
memory.

### Normal Mode

Code: NORM
Decode time: ?u

Execution begins in normal mode. Here are the normal mode commands:

```
Next | X | Result                                                       | Time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NORM | ! | _ = !_                                                       | ?u
STR  | " | _ = @ + 1                                                    | ?u
REM  | # |                                                              | ?u
ALC! | $ | Set mode to _                                                | ?u
MOD! | % | _ = _ % x                                                    | ?u
AND! | & | _ = _ bit-and x                                              | ?u
NORM | ' | _ = READ                                                     | ?u
LRL! | ( | _ = _ rotate left x                                          | ?u
LRR! | ) | _ = _ rotate right x                                         | ?u
MUL! | * | _ = _ * x                                                    | ?u
ADD! | + | _ = _ + x                                                    | ?u
NORM | , | WRITE _                                                      | ?u
SUB! | - | _ = _ - x                                                    | ?u
NORM | . | _ = @ + 2                                                    | ?u
DIV! | / | _ = _ / x                                                    | ?u
NORM |0-9| _ = X - '0'                                                  | ?u
MOV! | : | memory at x = _                                              | ?u
DEV! | ; | DEVICE = x                                                   | ?u
LT!  | < | _ = _ < x                                                    | ?u
EQ!  | = | _ = _ == x                                                   | ?u
GT!  | > | _ = _ > x                                                    | ?u
BR!  | ? | If _ = 0 then @ = x                                          | ?u
ASS! | @ | _ = memory at x                                              | ?u
NORM |A-Z| _ = ?                                                        | ?u
NORM | [ | Push _                                                       | ?u
CHAR | \ | _ = memory at @ + 1        @ = @ + 2                         | ?u
NORM | ] | Pop _                                                        | ?u
XOR! | ^ | _ = _ bit-xor x                                              | ?u
CAS! | _ | if memory _ = x then memory _ = y and _ = 1 else _ = 0       | ?u
NORM | ` | See fork                                                     | ?u
NORM |a-z| ? = _                                                        | ?u
LSL! | { | _ = _ bit-left x                                             | ?u
OR!  | | | _ = _ bit-or x                                               | ?u
LSR! | } | _ = _ bit-right x                                            | ?u
NORM | ~ | _ = bit-not _                                                | ?u
```

Forking via the '`' command involves first checking the accumulator. If it is
zero, then the process exits. Otherwise it will become zero, but spawn a new
process in which the accumulator is the same as it was.

### Number Mode

Code: NUMB
Decode time: ?u

```
 X | Resulting x value                                                  | Time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 ! | !_                                                                 | ?u
 " | Similar to STR mode                                                | ?u
 ' | READ BYTE                                                          | ?u
0-9| X - '0'                                                            | ?u
 @ | Memory at _                                                        | ?u
A-Z| ?                                                                  | ?u
 ~ | bit-not _                                                          | ?u
```


In this mode all capitol registers return their values (time ?u), lowercase
registers return their memory (time ?u), _ returns itself (time ?u), @ returns
the program counter (time ?u

### Comment Mode

Code: REM
Decode time: 0u

This mode is useful for creating comments.

```
Next | X | Result                                                       | Time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NORM |  |                                                              | ?u
```

### String Mode

Code: STR
Decode time: ?u

This mode is useful for embedding byte-wise literals.

```
Next | X | Result                                                       | Time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NORM | " |                                                              | ?u
```

### Character Mode

Code: CHAR
Decode time: ?u

This mode is useful for embedding the value of a byte.
Essentially be 'returning' a pointer to the next byte, this provides access to
static memory. Unlike some other machine languages, this means that character
literals are embedded directly in the code.

```
Next | X | Result                                                       | Time
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NORM |any| _ = pointer to current memory                                | ?u
```
