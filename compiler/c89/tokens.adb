with Source; use Source;

package body Tokens is
    function "=" (Left, Right : in Preprocessing_Token) return Boolean is
    begin
        return Left.Kind = Right.Kind and Left.Data = Right.Data;
    end "=";

    function Image (PT : in Preprocessing_Token) return String is
    begin
        return Source.Image (PT.Data) & "{" &
            Preprocessing_Token_Type'Image (PT.Kind) & "}";
    end Image;
end Tokens;
