with Tokens; use Tokens;

package body Parsing is
    task body Parser is
        Next : C_Token;
        Next_Next : C_Token;

        procedure Next_Symbol is begin
            Next := Next_Next;

            if Next_Next.Kind /= CT_EOF then
                Input.REmove (Next_Next);
            end if;

            -- TODO: If CT_IDENTIFIER check if needs to become CT_TYPE_NAME
        end Next_Symbol;

        -- LALR(1) - generated
        -- TODO: LAXLR(1)?
        Tree : Parse_Tree_Node_Access := null;
        type Parse_State is range 0 .. ???;

        Lookahead : constant array (Parse_State, C_Token_Type)
            of Transition := ();
        LHS_Goto : constant array (Parse_State, Parse_Node_Type)
            of Natural := ();
    begin
        loop
            select
                accept Parse;
            or
                terminate;
            end select;

            Input.Remove (Next);
            Result := new Parse_Tree_Node'(0, PT_DECLARATION_LIST, Next);
            Output.Insert (new Parse_Tree_Node'(1, PT_STATEMENT, (1 =>
                Result)));
            Output.Insert (null);
            -- TODO: Actually parse
        end loop;
    end Parser;
end Parsing;
