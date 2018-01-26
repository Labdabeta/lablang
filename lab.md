Note: #!/bin/lab\n translates to 23212F62696E2F6C61620A which sets r3,r1 and rF
to 23 and _ to 10. This can easily be undone via: 00A011131F

Instructions:

16 gp registers
[x] = data memory at x
{x} = instruction memory at x
_ = internal accumulator (double width!)

```
Hex | Description - signed mode | Description - unsigned mode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 0x | Set _ to rX               | Set _ to X
 1x | Set rX to lo(_)           | _ = (_ = X)
 2x | Set rX to [_]             | Set rX to {_}
 3x | Set [_] to rX             | Set {_} to rX (&0xFF)
 4x | _ += rX                   | _ xor= rX
 5x | _ *= rX                   | _ and= rX
 6x | _ /= rX (0 if rX == 0)    | _ or= rX
 7x | _ %= rX (0 if rX == 0)    | _ nand= rX
 8x | _ = (_ < rX)              | _ = (_ = rX)
 9x | _ = _ arith_shiftl/r rX   | _ = _ rotl/r rX
 Ax | Switch to unsigned mode   | Switch to signed mode
 Bx | rX = load-link(_)         | store-conditional(_) = rX, _ = success?
 Cx | _ = fork(X)               | exit(X)
 Dx | read rX from device _     | write rX to device _
 Ex | if _ go to rX             | if _ go forward X
 Fx | go to _ + X               | go forward _ + X
```

fork() takes an affinity and returns 0 for child, 1 for parent.
This implementation acts as if it has infinite cores. 
Note: The first task running is the only task with permission to call fork!

The system begins in unsigned mode.
