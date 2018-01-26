package body LAB is
    procedure Initialize (What : out Processor; Size : in Register_Type) is
        Initial_State : constant Processor_State := (
            Registers => (30 => Last, others => Zero),
            Special_Registers => (others => Zero));
    begin
        What.Memory.Write := False;
        What.Memory.Read := False;

        What.IO.Write := False;
        What.IO.Read := False;

        What.Instructions.Address := Zero;
        What.Instructions.Write := False;
        What.Instructions.Read := True;

        What.State := Initial_State;
    end Initialize;
end LAB;
