with Source;

package Tokens is
    -- A continuation token is just more of the previous token. It occurs after
    -- use of the concatenation operator and is cleaned up in phase 5/6.
    type Preprocessing_Token_Type is (
        PTT_Header_Name, PTT_Identifier, PTT_Number, PTT_Character_Constant,
        PTT_String_Literal, PTT_Operator, PTT_Whitespace, PTT_EOL, PTT_EOF,
        PTT_Continuation);
    type Preprocessing_Token is
        record
            Kind : Preprocessing_Token_Type;
            Data : Source.String;
        end record;
    function "=" (Left, Right : in Preprocessing_Token) return Boolean;
    function Image (PT : in Preprocessing_Token) return String;
end Tokens;
