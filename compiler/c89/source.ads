with Ada.Strings.Unbounded;
with Buffers;

package Source is
    -- Most processing is done in terms of source characters, not normal
    -- characters
    type Character is
        record
            File_Name : Ada.Strings.Unbounded.Unbounded_String;
            Row : Positive;
            Column : Positive;
            Value : Standard.Character;
        end record;
    type String is
        record
            File_Name : Ada.Strings.Unbounded.Unbounded_String;
            Row : Positive;
            Column : Positive;
            Value : Ada.Strings.Unbounded.Unbounded_String;
        end record;
    function "=" (Left, Right : in Character) return Boolean;
    function "=" (Left, Right : in String) return Boolean;
    function Image (C : in Source.Character) return Standard.String;
    function Image (C : in Source.String) return Standard.String;
end Source;
