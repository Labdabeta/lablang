with Source;
with Tokens; use Tokens;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Assembly; use Assembly;

package body Compiling is
    task body Compiler is
        Next : Token;
        Next_Next : Token;

        procedure Next_Symbol is begin
            Next := Next_Next;
            if Next_Next.Kind /= TT_EOF then
                Input.Remove (Next_Next);
            end if;
        end Next_Symbol;

        function Accept_Symbol (Symbol : in C_Token_Type) return Boolean is
        begin
            if Next.Kind = Symbol then
                Next_Symbol;
                return True;
            else
                return False;
            end if;
        end Accept_Symbol;

        -- Recursive Descent with Backtracking
        -- TODO: LAXLR(1)?

        procedure Parse_Translation_Unit is
        begin
            null;
        end Parse_Translation_Unit;

    begin
        loop
            select
                accept Compile;
            or
                terminate;
            end select;

            Input.Remove (Next_Next);
            -- TODO: LR(1) or similar (LALR(1) Recursive Ascent)

            Parse_Translation_Unit;
        end loop;
    end Compiler;
end Compiling;
