with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Source is
    function "=" (Left, Right : in Character) return Boolean is begin
        return Left.File_Name = Right.File_Name and Left.Row = Right.Row and
            Left.Column = Right.Column and Left.Value = Right.Value;
    end "=";

    function "=" (Left, Right : in String) return Boolean is begin
        return Left.File_Name = Right.File_Name and Left.Row = Right.Row and
            Left.Column = Right.Column and Left.Value = Right.Value;
    end "=";

    function Image (C : in Source.Character) return Standard.String is begin
        return To_String (C.File_Name) &
            "|" & Positive'Image (C.Row) &
            " col" & Positive'Image (C.Column) &
            "| " & C.Value;
    end Image;
    function Image (C : in Source.String) return Standard.String is begin
        return To_String (C.File_Name) &
            "|" & Positive'Image (C.Row) &
            " col" & Positive'Image (C.Column) &
            "| " & To_String (C.Value);
    end Image;
end Source;
