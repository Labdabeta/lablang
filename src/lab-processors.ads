-- This package implements the most generic possible interface
generic
    type Register_Type is private;
    type Unsigned_Register_Type is private;
    type Immediate_Value is private;
    Zero : Register_Type;
    with procedure Decode (
        Value : in Register_Type;
        Op : out Operation;
        Immediate : out Immediate_Value;
        A : out Register_Index;
        B : out Register_Index);
    with function "/=" (A, B : Register_Type) return Boolean is <>;
    with function "+" (A, B : Register_Type) return Register_Type is <>;
    with function "+" (A : Register_Type; B : Immediate_Value)
        return Register_Type is <>;
    with function "mod" (A, B : Register_Type) return Register_Type is <>;
    -- TODO: more
package LAB.Processors is
    type Register_Page is array (Register_Index) of Register_Type;

    type Bus_Flags is
        record
            -- Write + Read = Read old value, write new one
            Write, Read, Error : Boolean;
        end record;

    type Bus is
        record
            Address : Register_Type; -- Read this - Referenced address
            Data : Register_Type; -- Read/Write to this
            Flags : Bus_Flags; -- Read/Write this
        end record;

    type Processor_State is
        record
            Registers : Register_Page;
            Special_Registers : Register_Page;
        end record;

    type Processor is
        record
            Memory, IO, Instructions : Bus;
            State : Processor_State;
            Previous_A : Register_Index; -- used to read value from busses
        end record;

    procedure Initialize (What : out Processor; Size : in Register_Type);
    -- Note: Reads and Writes take place between steps or on the next step
    procedure Step (What : in out Processor);
    procedure Interrupt (What : in out Processor; Index : in Interrupt_Index);
end LAB.Processors;

