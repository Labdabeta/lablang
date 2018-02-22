-- Translation Phase 7a: Parsing
-- Tokens are syntactically analyzed
with Source;
with Buffers;
with Concatenating;
with Tokens;

package Parsing is
    package Parse_Tree_Buffers is new Buffers (Tokens.Parse_Tree_Node_Access);

    -- Spits out a forest of external declarations
    -- Based on the fact that Start -> Translation Unit
    -- Translation Unit -> External Declaration *
    task type Parser (
        Input : access Concatenating.Token_Buffers.Buffer;
        Output : access Parse_Tree_Buffers.Buffer) is
        pragma Storage_Size (16#40000#);
        entry Parse;
    end Parser;
end Parsing;
