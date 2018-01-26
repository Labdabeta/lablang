package body LAB.Processors is
    procedure Initialize (What : out Processor; Size : in Register_Type) is
        Initial_State : Processor_State := (
            Registers => (30 => Size, others => Zero),
            Special_Registers => (others => Zero));
    begin
        What.Memory.Flags := (False, False, False);
        What.IO.Flags := (False, False, False);
        What.Instructions.Address := Zero;
        What.Instructions.Flags := (False, True, False);
        What.State := Initial_State;
    end Initialize;

    procedure Do_Interrupt (On : in out Processor; To : in Register_Type) is
    begin
    end Do_Interrupt;

    procedure Step (What : in out Processor) is
        Op : Operation;
        Immediate : Immediate_Value;
        A : Register_Index;
        B : Register_Index;
    begin
        -- Copy A values if necessary
        if What.Memory.Flags.Read then
            if
                What.Memory.Flags.Error and
                What.State.Special_Registers (27) /= Zero
            then
                Do_Interrupt (What, What.State.Special_Registers (27));
            else
                What.Registers (What.Previous_A) := What.Memory.Data;
            end if;
            What.Memory.Flags.Read := False;
        end if;

        if
            What.Instructions.Error and
            What.State.Special_Registers (26) /= Zero
        then
            Do_Interrupt (What, What.State.Special_Registers (26));
        else
            Decode (What.Instructions.Data, Op, Immediate, A, B);

            case Op is
                when OP_ADD =>
                    What.State.Registers (A) := What.State.Registers (A) +
                        What.State.Registers (B) + Immediate;
                when OP_MUL =>
                    What.State.Registers (A) := What.State.Registers (A) *
                        (What.State.Registers (B) + Immediate);
                when OP_DIV =>
                    if What.State.Registers (B) + Immediate /= Zero then
                        What.State.Registers (A) := What.State.Registers (A) /
                            (What.State.Registers (B) + Immediate);
                    else
                        if What.State.Special_Registers (28) /= Zero then
                            Do_Interrupt (
                                What, What.State.Special_Registers (28));
                        end if;
                    end if;
                when OP_MOD =>
                    if What.State.Registers (B) + Immediate /= Zero then
                        What.State.Registers (A) := What.State.Registers (A) mod
                            (What.State.Registers (B) + Immediate);
                    else
                        if What.State.Special_Registers (28) /= Zero then
                            Do_Interrupt (
                                What, What.State.Special_Registers (28));
                        end if;
                    end if;
                when OP_ADU =>
                    null; -- TODO
            end case;
        end if;
    end Step;
end LAB.Processors;
