with Source;
with Tokens; use Tokens;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Concatenating is
    type Token_Type is (
        TT_Keyword, TT_Identifier, TT_Constant, TT_String_Literal, TT_Operator,
        TT_EOF);
    type Token is
        record
            Kind : Token_Type;
            Data : Source.String;
        end record;
    task body Concatenator is
        Next : Tokens.Preprocessing_Token;
        Initial_Last : Token := (
            TT_EOF, (
                To_Unbounded_String (""), 1, 1, To_Unbounded_String ("")));
        Last : Token;

        function Is_Keyword (Text : in String) return Boolean is begin
            return Text = "auto" or Text = "double" or Text = "int" or
                   Text = "struct" or Text = "break" or Text = "else" or
                   Text = "long" or Text = "switch" or Text = "case" or
                   Text = "enum" or Text = "register" or Text = "typedef" or
                   Text = "char" or Text = "extern" or Text = "return" or
                   Text = "union" or Text = "const" or Text = "float" or
                   Text = "short" or Text = "unsigned" or Text = "continue" or
                   Text = "for" or Text = "signed" or Text = "void" or
                   Text = "default" or Text = "goto" or Text = "sizeof" or
                   Text = "volatile" or Text = "do" or Text = "if" or
                   Text = "static" or Text = "while";
        end Is_Keyword;

        function Is_Operator (Text : in String) return Boolean is begin
            return Text = "[" or Text = "]" or Text = "(" or Text = ")" or
                   Text = "{" or Text = "}" or Text = "." or Text = "..." or
                   Text = "->" or Text = ";" or Text = "++" or Text = "--" or
                   Text = "&" or Text = "*" or Text = "+" or Text = "-" or
                   Text = "~" or Text = "!" or Text = "sizeof" or Text = "/" or
                   Text = "%" or Text = "<<" or Text = ">>" or Text = "<" or
                   Text = ">" or Text = "<=" or Text = ">=" or Text = "==" or
                   Text = "!=" or Text = "^" or Text = "|" or Text = "&&" or
                   Text = "||" or Text = "?" or Text = ":" or Text = "=" or
                   Text = "*=" or Text = "/=" or Text = "%=" or Text = "+=" or
                   Text = "-=" or Text = "<<=" or Text = ">>=" or Text = "&=" or
                   Text = "^=" or Text = "|=" or Text = "," or Text = "#";
        end Is_Operator;

        -- Replacement must not contain Pattern
        procedure String_Replace (
            Source : in out Unbounded_String;
            Pattern : in String;
            Replacement : in String) is
            Index : Natural := 0;
            Result : Unbounded_String;
            Thunk : String := Replacement;
        begin
            Thunk (Thunk'First) := Character'Succ (
                Replacement (Replacement'First));
            Result := Source;
            loop
                Index := Ada.Strings.Unbounded.Index (Source, Pattern);
                exit when Index = 0;
                Replace_Slice (
                    Source, Index, Index + Pattern'Length - 1, Thunk);
                Replace_Slice (
                    Result, Index, Index + Pattern'Length - 1, Replacement);
            end loop;

            Source := Result;
        end String_Replace;

        procedure Escapify (Text : in out Unbounded_String) is
        begin
            String_Replace (Text, "\a", "" & ASCII.BEL);
            String_Replace (Text, "\b", "" & ASCII.BS);
            String_Replace (Text, "\f", "" & ASCII.FF);
            String_Replace (Text, "\n", "" & ASCII.LF);
            String_Replace (Text, "\r", "" & ASCII.CR);
            String_Replace (Text, "\t", "" & ASCII.HT);
            String_Replace (Text, "\v", "" & ASCII.VT);
            String_Replace (Text, "\'", "'");
            String_Replace (Text, "\""", """");
            String_Replace (Text, "\?", "?");
            String_Replace (Text, "\e", "" & ASCII.ESC);

            -- TODO: Octal/hex

            String_Replace (Text, "\\", "\");
        end Escapify;

        -- Parses the data to make the terminal accurate
        procedure Insert (What : in Token) is
            Element : C_Token;
        begin
            Element.Data := What.Data;
            case What.Kind is
                when TT_Keyword =>
                    if What.Data.Value = "auto" then
                        Element.Kind := CT_AUTO;
                    elsif What.Data.Value = "double" then
                        Element.Kind := CT_DOUBLE;
                    elsif What.Data.Value = "int" then
                        Element.Kind := CT_INT;
                    elsif What.Data.Value = "struct" then
                        Element.Kind := CT_STRUCT;
                    elsif What.Data.Value = "break" then
                        Element.Kind := CT_BREAK;
                    elsif What.Data.Value = "else" then
                        Element.Kind := CT_ELSE;
                    elsif What.Data.Value = "long" then
                        Element.Kind := CT_LONG;
                    elsif What.Data.Value = "switch" then
                        Element.Kind := CT_SWITCH;
                    elsif What.Data.Value = "case" then
                        Element.Kind := CT_CASE;
                    elsif What.Data.Value = "enum" then
                        Element.Kind := CT_ENUM;
                    elsif What.Data.Value = "register" then
                        Element.Kind := CT_REGISTER;
                    elsif What.Data.Value = "typedef" then
                        Element.Kind := CT_TYPEDEF;
                    elsif What.Data.Value = "char" then
                        Element.Kind := CT_CHAR;
                    elsif What.Data.Value = "extern" then
                        Element.Kind := CT_EXTERN;
                    elsif What.Data.Value = "return" then
                        Element.Kind := CT_RETURN;
                    elsif What.Data.Value = "union" then
                        Element.Kind := CT_UNION;
                    elsif What.Data.Value = "const" then
                        Element.Kind := CT_CONST;
                    elsif What.Data.Value = "float" then
                        Element.Kind := CT_FLOAT;
                    elsif What.Data.Value = "short" then
                        Element.Kind := CT_SHORT;
                    elsif What.Data.Value = "unsigned" then
                        Element.Kind := CT_UNSIGNED;
                    elsif What.Data.Value = "continue" then
                        Element.Kind := CT_CONTINUE;
                    elsif What.Data.Value = "for" then
                        Element.Kind := CT_FOR;
                    elsif What.Data.Value = "signed" then
                        Element.Kind := CT_SIGNED;
                    elsif What.Data.Value = "void" then
                        Element.Kind := CT_VOID;
                    elsif What.Data.Value = "default" then
                        Element.Kind := CT_DEFAULT;
                    elsif What.Data.Value = "goto" then
                        Element.Kind := CT_GOTO;
                    elsif What.Data.Value = "sizeof" then
                        Element.Kind := CT_SIZEOF;
                    elsif What.Data.Value = "volatile" then
                        Element.Kind := CT_VOLATILE;
                    elsif What.Data.Value = "do" then
                        Element.Kind := CT_DO;
                    elsif What.Data.Value = "if" then
                        Element.Kind := CT_IF;
                    elsif What.Data.Value = "static" then
                        Element.Kind := CT_STATIC;
                    elsif What.Data.Value = "while" then
                        Element.Kind := CT_WHILE;
                    else
                        Element.Kind := CT_ERROR;
                    end if;
                when TT_Operator =>
                    if What.Data.Value = "[" then
                        Element.Kind := CT_OPEN_BRACKET;
                    elsif What.Data.Value = "]" then
                        Element.Kind := CT_CLOSE_BRACKET;
                    elsif What.Data.Value = "(" then
                        Element.Kind := CT_OPEN_PAREN;
                    elsif What.Data.Value = ")" then
                        Element.Kind := CT_CLOSE_PAREN;
                    elsif What.Data.Value = "{" then
                        Element.Kind := CT_OPEN_BRACE;
                    elsif What.Data.Value = "}" then
                        Element.Kind := CT_CLOSE_BRACE;
                    elsif What.Data.Value = "." then
                        Element.Kind := CT_DOT;
                    elsif What.Data.Value = "..." then
                        Element.Kind := CT_ELLIPSIS;
                    elsif What.Data.Value = "->" then
                        Element.Kind := CT_PTR_OP;
                    elsif What.Data.Value = ";" then
                        Element.Kind := CT_SEMICOLON;
                    elsif What.Data.Value = "++" then
                        Element.Kind := CT_INC_OP;
                    elsif What.Data.Value = "--" then
                        Element.Kind := CT_DEC_OP;
                    elsif What.Data.Value = "&" then
                        Element.Kind := CT_AMPERSAND;
                    elsif What.Data.Value = "*" then
                        Element.Kind := CT_STAR;
                    elsif What.Data.Value = "+" then
                        Element.Kind := CT_ADD;
                    elsif What.Data.Value = "-" then
                        Element.Kind := CT_SUB;
                    elsif What.Data.Value = "~" then
                        Element.Kind := CT_TILDE;
                    elsif What.Data.Value = "!" then
                        Element.Kind := CT_EXCLAM;
                    elsif What.Data.Value = "sizeof" then
                        Element.Kind := CT_SIZEOF;
                    elsif What.Data.Value = "/" then
                        Element.Kind := CT_DIV;
                    elsif What.Data.Value = "%" then
                        Element.Kind := CT_PERCENT;
                    elsif What.Data.Value = "<<" then
                        Element.Kind := CT_LEFT_OP;
                    elsif What.Data.Value = ">>" then
                        Element.Kind := CT_RIGHT_OP;
                    elsif What.Data.Value = "<" then
                        Element.Kind := CT_LESS;
                    elsif What.Data.Value = "<=" then
                        Element.Kind := CT_LE_OP;
                    elsif What.Data.Value = ">=" then
                        Element.Kind := CT_GE_OP;
                    elsif What.Data.Value = "==" then
                        Element.Kind := CT_EQ_OP;
                    elsif What.Data.Value = "!=" then
                        Element.Kind := CT_NE_OP;
                    elsif What.Data.Value = "^" then
                        Element.Kind := CT_CARET;
                    elsif What.Data.Value = "|" then
                        Element.Kind := CT_BAR;
                    elsif What.Data.Value = "&&" then
                        Element.Kind := CT_AND_OP;
                    elsif What.Data.Value = "||" then
                        Element.Kind := CT_OR_OP;
                    elsif What.Data.Value = "?" then
                        Element.Kind := CT_QUESTION;
                    elsif What.Data.Value = ":" then
                        Element.Kind := CT_COLON;
                    elsif What.Data.Value = "=" then
                        Element.Kind := CT_ASSIGN;
                    elsif What.Data.Value = "*=" then
                        Element.Kind := CT_MUL_ASSIGN;
                    elsif What.Data.Value = "/=" then
                        Element.Kind := CT_DIV_ASSIGN;
                    elsif What.Data.Value = "%=" then
                        Element.Kind := CT_MOD_ASSIGN;
                    elsif What.Data.Value = "+=" then
                        Element.Kind := CT_ADD_ASSIGN;
                    elsif What.Data.Value = "-=" then
                        Element.Kind := CT_SUB_ASSIGN;
                    elsif What.Data.Value = "<<=" then
                        Element.Kind := CT_LEFT_ASSIGN;
                    elsif What.Data.Value = ">>=" then
                        Element.Kind := CT_RIGHT_ASSIGN;
                    elsif What.Data.Value = "&=" then
                        Element.Kind := CT_AND_ASSIGN;
                    elsif What.Data.Value = "^=" then
                        Element.Kind := CT_XOR_ASSIGN;
                    elsif What.Data.Value = "|=" then
                        Element.Kind := CT_OR_ASSIGN;
                    elsif What.Data.Value = "," then
                        Element.Kind := CT_COMMA;
                    else
                        Element.Kind := CT_ERROR;
                    end if;
                when TT_Identifier =>
                    -- Type names will be converted upon detection via typedef
                    Element.Kind := CT_IDENTIFIER;
                when TT_Constant =>
                    Element.Kind := CT_CONSTANT;
                when TT_String_Literal =>
                    Element.Kind := CT_STRING_LITERAL;
                when TT_EOF =>
                    Element.Kind := CT_EOF;
            end case;
            Output.Insert (Element);
        end Insert;

        procedure Add_Last is begin
            case Last.Kind is
                when TT_Identifier =>
                    if Is_Keyword (To_String (Last.Data.Value)) then
                        Last.Kind := TT_Keyword;
                    end if;

                    if Last.Data.Value = "sizeof" then
                        Last.Kind := TT_Operator;
                    end if;

                    Insert (Last);
                    Last := Initial_Last;
                when TT_Operator =>
                    if Next.Kind = PTT_Operator and
                        Is_Operator (
                            To_String (Last.Data.Value & Next.Data.Value))
                    then
                        Last.Data.Value := Last.Data.Value & Next.Data.Value;
                    else
                        Insert (Last);
                        Last := Initial_Last;
                    end if;
                when TT_Constant =>
                    Escapify (Last.Data.Value);
                    Insert (Last);
                    Last := Initial_Last;
                when TT_String_Literal =>
                    Escapify (Last.Data.Value);
                    Insert (Last);
                    Last := Initial_Last;
                when others =>
                    null;
            end case;
        end Add_Last;

        procedure Concatenate_Last is begin
            if Last.Kind = TT_String_Literal then
                Last.Data.Value := To_Unbounded_String (Slice (
                    Last.Data.Value, 1, Length (Last.Data.Value) - 1) & Slice (
                    Next.Data.Value, 2, Length (Next.Data.Value)));
            else
                Add_Last;
                Last := (TT_String_Literal, Next.Data);
            end if;
        end Concatenate_Last;

        procedure Append_Last is begin
            Last.Data.Value := Last.Data.Value & Next.Data.Value;
        end Append_Last;
    begin
        loop
            select
                accept Concatenate;
            or
                terminate;
            end select;

            Last := Initial_Last;
            loop
                Input.Remove (Next);

                exit when Next.Kind = PTT_EOF;

                case Next.Kind is
                    when PTT_Identifier =>
                        Add_Last;
                        if Last = Initial_Last then
                            Last := (TT_Identifier, Next.Data);
                        end if;
                    when PTT_Number | PTT_Character_Constant =>
                        Add_Last;
                        if Last = Initial_Last then
                            Last := (TT_Constant, Next.Data);
                        end if;
                    when PTT_String_Literal =>
                        Concatenate_Last;
                        if Last = Initial_Last then
                            Last := (TT_String_Literal, Next.Data);
                        end if;
                    when PTT_Operator =>
                        Add_Last;
                        if Last = Initial_Last then
                            Last := (TT_Operator, Next.Data);
                        end if;
                    when PTT_Whitespace | PTT_EOL =>
                        null;
                    when PTT_Continuation =>
                        Append_Last;
                    when others =>
                        null; -- Should never get here
                end case;
            end loop;

            Add_Last;
            Insert ((TT_EOF, Next.Data));
        end loop;
    end Concatenator;
end Concatenating;
