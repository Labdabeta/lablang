-- Translation Phase 3: Decomposing
-- Converts characters into preprocessor tokens
-- Replaces comments and multiple spaces with a single space.
with Source;
with Buffers;
with Lining;
with Tokens;

package Decomposing is
    package Preprocessing_Buffers is new Buffers (
        Element => Tokens.Preprocessing_Token, Size => 16#10000#);

    task type Decomposer (
        Input : access Lining.Lining_Buffers.Buffer;
        Output : access Preprocessing_Buffers.Buffer) is
        entry Decompose;
    end Decomposer;
end Decomposing;
