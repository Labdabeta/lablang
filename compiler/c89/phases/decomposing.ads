-- Translation Phase 3: Decomposing
-- Converts characters into preprocessor tokens
-- Replaces comments and multiple spaces with a single space.
with Source;
with Buffers;
with Lining;
with Tokens;

package Decomposing is
    package Preprocessing_Buffers is new Buffers (Tokens.Preprocessing_Token);

    task type Decomposer (
        Input : access Lining.Lining_Buffers.Buffer;
        Output : access Preprocessing_Buffers.Buffer) is
        pragma Storage_Size (16#40000#);
        entry Decompose;
    end Decomposer;
end Decomposing;
