-- Translation Phase 5: Conversion
-- Escape sequences are converted to their values in the execution character set
-- Translation Phase 6: Concatenation
-- Adjacent string literals are concatenated. concatenated tokens are unified
with Source;
with Buffers;
with Preprocessing;
with Tokens;

package Concatenating is
    package Preprocessing_Buffers is new Buffers (
        Element => Tokens.Preprocessing_Token, Size => 16#1000#);

    task type Concatenator (
        Input : access Preprocessing.Preprocessing_Buffers.Buffer;
        Output : access Preprocessing_Buffers.Buffer) is
        entry Concetanate;
    end Concatenator;
end Concatenating;
