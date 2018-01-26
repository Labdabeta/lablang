with Ada.Text_IO;
with Lexer;
with Ada.Containers.Hashed_Maps;

with Character_Utils; use Character_Utils;

separate (Preprocessor) task body Preprocessor is
    File : Ada.Text_IO.File_Type;
    -- TODO: Probably need a map of macros

    In_Comment : Boolean;
    Hit_First : Boolean; -- Have we hit a non-blank character this line?
    Logged_Space : Boolean; -- Have we logged the current whitespace block?
    Line_Comment : Boolean; -- Are we in a line comment?

    procedure Process_Token (Token : in String) is
    begin
        -- TODO
        Output_Buffer.Insert ('!'); -- test to show token boundaries
        for I in Token'Range loop
            Output_Buffer.Insert (Token (I));
        end loop;
    end Process_Token;

    procedure Process_Line (Line : in String) is
        Token_End : Positive := Line'First;
        Token_Start : Positive := Line'First;
    begin
        while Token_Start <= Line'Last loop
            Token_End := Token_Start;
            if Is_Space (Line (Token_Start)) then
                while Is_Space (Line (Token_End)) and Token_End < Line'Last loop
                    Token_End := Token_End + 1;
                end loop;

                if not Is_Space (Line (Token_End)) then
                    Token_End := Token_End - 1;
                end if;
            else
                while not Is_Space (Line (Token_End)) and
                    Token_End < Line'Last
                loop
                    Token_End := Token_End + 1;
                end loop;

                if Is_Space (Line (Token_End)) then
                    Token_End := Token_End - 1;
                end if;
            end if;

            if Token_End < Token_Start then
                exit;
            end if;

            Process_Token (Line (Token_Start .. Token_End));

            Token_Start := Token_End + 1;
            Token_End := Token_Start;
        end loop;
    end Process_Line;

    -- Appends a newline unless ends with slash
    -- also processes comments, trigraphs, and digraphs
    function Global_Transform (Line : in String) return String is
        Result : String (Line'First .. Line'Last + 1);
        Last : Positive := Result'First;
        Index : Positive := Line'First;
    begin
        while Index <= Line'Last loop
            if In_Comment then
                if Index > 0 and then
                    (Line (Index) = '/' and Line (Index - 1) = '*')
                then
                    In_Comment := False;
                end if;
                Index := Index + 1;
            else
                -- TODO
                Result (Last) := Line (Index);
                Index := Index + 1;
                Last := Last + 1;
            end if;
        end loop;
        -- TODO: Deal with \newline
        return Result (Result'First .. Last - 1);
    end Global_Transform;
begin
    loop
        select
            accept Open (File_Name : String) do
                Ada.Text_IO.Open (File, Ada.Text_IO.In_File, File_Name);
            end Open;
        or
            terminate;
        end select;

        In_Comment := False;
        Hit_First := False;
        Logged_Space := False;
        Line_Comment := False;
        while not Ada.Text_IO.End_Of_File (File) loop
            declare
                Line : String := Ada.Text_IO.Get_Line (File);
            begin
                Process_Line (Global_Transform (Line));
            end;
        end loop;

        Output_Buffer.Insert (Character'First);

        Ada.Text_IO.Close (File);
    end loop;
end Preprocessor;
