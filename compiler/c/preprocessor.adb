with Ada.Strings.Unbounded;
with Ada.Unchecked_Deallocation;
with Buffers;

package body Preprocessor is
    package Character_Buffers is new Buffers (
        Element => Character, Size => 16#1000#);

    Output_Buffer : Character_Buffers.Buffer;

    task Preprocessor is
        entry Open (File_Name : String);
    end Preprocessor;

    task body Preprocessor is separate;

    procedure Open (File : String) is begin
        Preprocessor.Open (File);
    end Open;

    function Extract return Character is
        Result : Character;
    begin
        Output_Buffer.Remove (Result);
        return Result;
    end Extract;

    -- function Location return Location_Type is
    -- begin
    -- end Location;
end Preprocessor;
