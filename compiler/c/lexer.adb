with Ada.Strings.Unbounded;
with Ada.Unchecked_Deallocation;
with Buffers;

package body Lexer is
    type Internal_Token is
        record
            Kind : Token_Type;
            Lexeme : Ada.Strings.Unbounded.Unbounded_String;
        end record;

    package Character_Buffers is new Buffers (
        Element => Character, Size => 16#1000#);
    package Lexeme_Buffers is new Buffers (
        Element => Internal_Token, Size => 16#1000#);

    Character_Buffer : Character_Buffers.Buffer;
    Lexeme_Buffer : Lexeme_Buffers.Buffer;

    task Lexer is
        entry Reset; -- Otherwise terminates after reading EOF
    end Lexer;

    task body Lexer is separate;

    procedure Lex (Next : in Character) is begin
        Character_Buffer.Insert (Next);
    end Lex;

    function Next return Token is
        Internal : Internal_Token;
    begin
        Lexeme_Buffer.Remove (Internal);
        declare
            Result : Token (Ada.Strings.Unbounded.Length (Internal.Lexeme));
        begin
            Result.Kind := Internal.Kind;
            Result.Lexeme := Ada.Strings.Unbounded.To_String (Internal.Lexeme);
            return Result;
        end;
    end Next;

    procedure Reset is begin
        Lexer.Reset;
    end Reset;
end Lexer;
