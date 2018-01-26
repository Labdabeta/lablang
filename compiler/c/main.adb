with Lexer;
with Preprocessor;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
    procedure Print_Token (T : Lexer.Token) is begin
        Ada.Text_IO.Put_Line (Lexer.Token_Type'Image (T.Kind) & ":" & T.Lexeme);
    end Print_Token;
    Next : Character;
begin
    Preprocessor.Open ("test.c");
    loop
        Next := Preprocessor.Extract;
        -- Lexer.Lex (Next);
        exit when Next = Character'First;
        Ada.Text_IO.Put_Line (":" & Next);
    end loop;
end Main;
