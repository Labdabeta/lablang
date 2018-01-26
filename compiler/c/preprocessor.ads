-- The preprocessor implements translation phase 4
package Preprocessor is
    type Location_Type (Size : Natural) is
        record
            -- Contains a list of all included files
            -- e.g. File included from a.h/b.h/c.h x.h
            File : String (1 .. Size);
            Line : Natural;
            Column : Natural;
        end record;

    procedure Open (File : String);

    -- Returns Character'First when done, open a new file to reset
    function Extract return Character;

    -- function Location return Location_Type;
end Preprocessor;
