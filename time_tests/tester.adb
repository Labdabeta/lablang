with Ada.Command_Line;

procedure Tester is
    Value : Integer := 0;
    Argument : Integer;
    pragma Volatile (Value);

    type Iteration_Count is mod 2 ** 64;
begin
    Argument := Integer'Value (Ada.Command_Line.Argument (1));
    for I in Iteration_Count range 1 .. Iteration_Count'Value (Ada.Command_Line.Argument (2))
    loop
        Value := Value / Argument;
        Value := 0;
    end loop;
end Tester;
