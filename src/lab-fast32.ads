with Interfaces;

-- Fastest running 32-bit implementation viable
package LAB.Fast32 is
    type Register_Type is new Interfaces.Integer_32;
    type Unsigned_Register_Type is new Interfaces.Unsigned_32;
    type Float_Register_Type is new Interfaces.IEEE_Float_32;

    type CPU32 is private;

    function To_Unsigned (Value : in Register_Type)
        return Unsigned_Register_Type;
    function To_Register (Value : in Unsigned_Register_Type)
        return Register_Type;
    function To_Float (Value : in Register_Type)
        return Float_Register_Type;
    function To_Register (Value : in Float_Register_Type)
        return Register_Type;

    type Get_Callback is access function (Address : Register_Type);
    type Put_Callback is access procedure (Address, Value : Register_Type);

    type Memory_Array is array (Unsigned_Register_Type range <>) of
        Register_Type;
    type Memory_Array_Access is access all Memory_Array;

    function Create_CPU32 (
        Memory : in Memory_Array_Access;
        Get : in Get_Callback;
        Put : in Put_Callback) return CPU32;
    procedure Trigger_Interrupt (
        Which : in out CPU32;
        Interrupt : in Interrupt_Index);
    procedure Step (Which : in out CPU32);
private
    type CPU32 is
        record

        end record;
end LAB.Fast32;
