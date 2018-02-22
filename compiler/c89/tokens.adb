with Source; use Source;
with Ada.Unchecked_Deallocation;

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

    function "=" (Left, Right : in C_Token) return Boolean is
    begin
        return Left.Kind = Right.Kind and Left.Data = Right.Data;
    end "=";

    function Image (PT : in C_Token) return String is
    begin
        return Source.Image (PT.Data) & "{" &
            C_Token_Type'Image (PT.Kind) & "}";
    end Image;

    function Image (Item : in Parse_Tree_Node) return String is
        function Children_Image (Index : in Natural) return String is begin
            if Index <= Item.Size then
                return Image (Item.Children (Index).all) & ", " &
                    Children_Image (Index + 1);
            else
                return "EOF";
            end if;
        end Children_Image;
    begin
        if Item.Size = 0 then
            return Parse_Node_Type'Image (Item.Kind) &
                " (" & Image (Item.Contents) & ")";
        else
            return Parse_Node_Type'Image (Item.Kind) &
                " (" & Children_Image (1) & ")";
        end if;
    end Image;

    procedure Free (Item : in out Parse_Tree_Node_Access) is
        procedure Free_PTN is new Ada.Unchecked_Deallocation (
            Parse_Tree_Node, Parse_Tree_Node_Access);
    begin
        if Item.Size /= 0 then
            for I in Item.Children'Range loop
                Free (Item.Children (I));
            end loop;
        end if;

        Free_PTN (Item);
    end Free;
end Tokens;
