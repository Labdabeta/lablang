with Ada.Unchecked_Conversion;

package body LAB.Fast32 is
    function To_Unsigned (Value : in Register_Type)
        return Unsigned_Register_Type is
        function Convert is new Ada.Unchecked_Conversion (
            Source => Register_Type,
            Target => Unsigned_Register_Type);
    begin
        return Convert (Value);
    end To_Unsigned;

    function To_Register (Value : in Unsigned_Register_Type)
        return Register_Type is
        function Convert is new Ada.Unchecked_Conversion (
            Source => Unsigned_Register_Type,
            Target => Register_Type);
    begin
        return Convert (Value);
    end To_Register;

    function To_Float (Value : in Register_Type)
        return Float_Register_Type is
        function Convert is new Ada.Unchecked_Conversion (
            Source => Register_Type,
            Target => Float_Register_Type);
    begin
        return Convert (Value);
    end To_Float;

    function To_Register (Value : in Float_Register_Type)
        return Register_Type is
        function Convert is new Ada.Unchecked_Conversion (
            Source => Float_Register_Type,
            Target => Register_Type);
    begin
        return Convert (Value);
    end To_Register;

    function Create_CPU32 (
        Memory : in Memory_Array_Access;
        Get : in Get_Callback;
        Put : in Put_Callback) return CPU32;

end LAB.Fast32;
