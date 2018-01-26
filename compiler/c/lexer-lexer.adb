separate (Lexer) task body Lexer is
    Next : Character;
begin
    loop
        select
            accept Reset;
            or
            terminate;
        end select;
        loop
            -- Grab a lexeme
            Character_Buffer.Remove (Next);
            if Next = Character'First then
                exit;
            end if;
            Lexeme_Buffer.Insert (
                (TT_IDENTIFIER, Ada.Strings.Unbounded.To_Unbounded_String (
                     "" & Next)));
        end loop;

        Lexeme_Buffer.Insert (
            (TT_EOF, Ada.Strings.Unbounded.To_Unbounded_String ("")));
    end loop;
end Lexer;
