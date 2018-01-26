with Source;
with Tokens; use Tokens;
with Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Decomposing is
    task body Decomposer is
        -- A Recursive descent parser for tokenization
        Next : Source.Character;
        Next_Next : Source.Character;
        Got_First : Boolean := False;

        procedure Next_Symbol is
            Just_Got_Star : Boolean := False;
        begin
            if not Got_First then
                Input.Remove (Next_Next);
                Got_First := True;
            end if;

            Next := Next_Next;
            if Next_Next.Value = Character'First then
                return; -- Don't go past end of file
            end if;

            Input.Remove (Next_Next);

            if Next_Next.Value = '*' and Next.Value = '/' then
                loop
                    Input.Remove (Next_Next);

                    if Just_Got_Star and Next_Next.Value = '/' then
                        Next.Value := ' ';
                        Input.Remove (Next_Next);
                        return;
                    end if;

                    Just_Got_Star := Next_Next.Value = '*';
                end loop;
            end if;
        end Next_Symbol;

        procedure Error (Message : in String) is begin
            Ada.Text_IO.Put_Line (
                "error at " & Source.Image (Next) & ": " & Message);
        end Error;

        function Accept_Character (What : in Character) return Boolean is
        begin
            if Next.Value = What then
                Next_Symbol;
                return True;
            end if;
            return False;
        end Accept_Character;

        function Expect_Character (What : in Character) return Boolean is begin
            if Accept_Character (What) then
                return True;
            end if;

            Error ("expected " & What);
            return False;
        end Expect_Character;

        procedure Parse_Whitespace is
            function Is_Space return Boolean is begin
                case Next.Value is
                    when ' ' | ASCII.HT | ASCII.VT |
                        ASCII.FF | ASCII.CR =>
                        return True;
                    when others =>
                        return False;
                end case;
            end Is_Space;

            Result : Preprocessing_Token;
        begin
            Result.Kind := PTT_Whitespace;
            Result.Data.File_Name := Next.File_Name;
            Result.Data.Row := Next.Row;
            Result.Data.Column := Next.Column;
            if Next.Value = ASCII.LF then
                Result.Kind := PTT_EOL;
                Result.Data.Value := To_Unbounded_String ("" & ASCII.LF);
                Output.Insert (Result);
                Next_Symbol;
            else
                Result.Data.Value := To_Unbounded_String (" ");
                while Is_Space loop
                    Next_Symbol;
                end loop;
                Output.Insert (Result);
            end if;
        end Parse_Whitespace;

        procedure Parse_Number is
            Just_Got_E : Boolean := False;
            function Is_PP_Number return Boolean is
                Result : Boolean;
            begin
                case Next.Value is
                    when '.' | '0' .. '9' | 'a' .. 'z' | 'A' .. 'Z' =>
                        Result := True;
                    when '+' | '-' =>
                        Result := Just_Got_E;
                    when others =>
                        Result := False;
                end case;
                if Next.Value = 'e' or Next.Value = 'E' then
                    Just_Got_E := True;
                else
                    Just_Got_E := False;
                end if;
                return Result;
            end Is_PP_Number;

            Result : Preprocessing_Token;
        begin
            Result.Kind := PTT_Number;
            Result.Data.File_Name := Next.File_Name;
            Result.Data.Row := Next.Row;
            Result.Data.Column := Next.Column;
            Result.Data.Value := To_Unbounded_String ("");

            -- Check for '.' not followed by digits
            if Next.Value = '.' then
                Append (Result.Data.Value, Next.Value);
                Next_Symbol;
                if Next.Value < '0' or Next.Value > '9' then
                    Result.Kind := PTT_Operator;
                    Output.Insert (Result);
                    return;
                end if;
            end if;

            while Is_PP_Number loop
                Append (Result.Data.Value, Next.Value);
                Next_Symbol;
            end loop;

            Output.Insert (Result);
        end Parse_Number;

        procedure Parse_Character_Constant is
            Just_Got_Escape : Boolean := False;
            function Is_PP_Character return Boolean is begin
                if Just_Got_Escape then
                    Just_Got_Escape := False;
                    return True;
                end if;

                if Next.Value = ''' then
                    return False;
                end if;

                return True;
            end Is_PP_Character;
            Result : Preprocessing_Token;
        begin
            Result.Kind := PTT_Character_Constant;
            Result.Data.File_Name := Next.File_Name;
            Result.Data.Row := Next.Row;
            Result.Data.Column := Next.Column;
            Result.Data.Value := To_Unbounded_String ("");

            while Is_PP_Character loop
                Append (Result.Data.Value, Next.Value);
                Next_Symbol;
            end loop;

            Output.Insert (Result);
        end Parse_Character_Constant;

        procedure Parse_String_Literal is
            Just_Got_Escape : Boolean := False;
            Started : Boolean := False;
            function Is_PP_String return Boolean is begin
                if Just_Got_Escape then
                    Just_Got_Escape := False;
                    return True;
                end if;

                if Next.Value = '"' then
                    if not Started then
                        Started := True;
                        return True;
                    end if;
                    return False;
                end if;

                return True;
            end Is_PP_String;
            Result : Preprocessing_Token;
        begin
            Result.Kind := PTT_String_Literal;
            Result.Data.File_Name := Next.File_Name;
            Result.Data.Row := Next.Row;
            Result.Data.Column := Next.Column;
            Result.Data.Value := To_Unbounded_String ("");

            while Is_PP_String loop
                Append (Result.Data.Value, Next.Value);
                Next_Symbol;
            end loop;

            -- Extra append for closing quote
            Append (Result.Data.Value, Next.Value);
            Next_Symbol;

            Output.Insert (Result);
        end Parse_String_Literal;

        procedure Parse_Identifier is
            function Is_PP_Identifier return Boolean is begin
                case Next.Value is
                    when '_' | 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' =>
                        return True;
                    when others =>
                        return False;
                end case;
            end Is_PP_Identifier;
            Result : Preprocessing_Token;
        begin
            Result.Kind := PTT_Identifier;
            Result.Data.File_Name := Next.File_Name;
            Result.Data.Row := Next.Row;
            Result.Data.Column := Next.Column;
            Result.Data.Value := To_Unbounded_String ("");

            while Is_PP_Identifier loop
                Append (Result.Data.Value, Next.Value);
                Next_Symbol;
            end loop;

            Output.Insert (Result);
        end Parse_Identifier;

        procedure Parse_Operator is
            Result : Preprocessing_Token;
        begin
            Result.Kind := PTT_Operator;
            Result.Data.File_Name := Next.File_Name;
            Result.Data.Row := Next.Row;
            Result.Data.Column := Next.Column;
            Result.Data.Value := To_Unbounded_String ("" & Next.Value);
            Output.Insert (Result);
            Next_Symbol;
        end Parse_Operator;

        procedure Parse_Preprocessing_Token is begin
            case Next.Value is
                when ' ' | ASCII.LF | ASCII.HT | ASCII.VT |
                    ASCII.FF | ASCII.CR =>
                    Parse_Whitespace;
                when '.' | '0' .. '9' =>
                    Parse_Number;
                when ''' =>
                    Parse_Character_Constant;
                when '"' =>
                    Parse_String_Literal;
                when '_' | 'a' .. 'z' | 'A' .. 'Z' =>
                    Parse_Identifier;
                when others =>
                    Parse_Operator;
            end case;
        end Parse_Preprocessing_Token;
    begin
        loop
            select
                accept Decompose;
            or
                terminate;
            end select;

            Next_Symbol;
            loop
                if Next.Value = Character'First then
                    Output.Insert ((PTT_EOF, (Next.File_Name, Next.Row,
                        Next.Column, Null_Unbounded_String)));
                    exit;
                end if;

                Parse_Preprocessing_Token;
            end loop;
        end loop;
    end Decomposer;

end Decomposing;
