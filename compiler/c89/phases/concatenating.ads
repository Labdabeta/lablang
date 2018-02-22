-- Translation Phase 5: Conversion
-- Escape sequences are converted to their values in the execution character set
-- Translation Phase 6: Concatenation
-- Adjacent string literals are concatenated. concatenated tokens are unified
-- From here on, whitespace between tokens is irrelevant
with Source;
with Buffers;
with Preprocessing;
with Tokens;

package Concatenating is
    package Token_Buffers is new Buffers (Tokens.C_Token);

    task type Concatenator (
        Input : access Preprocessing.Preprocessing_Buffers.Buffer;
        Output : access Token_Buffers.Buffer) is
        pragma Storage_Size (16#40000#);
        entry Concatenate;
    end Concatenator;
end Concatenating;
