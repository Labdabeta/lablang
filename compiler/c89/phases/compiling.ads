-- Translation Phase 7: Compilation
-- Tokens are syntactically and semantically analyzed and translated
with Source;
with Buffers;
with Concatenating;
with Tokens;
with Assembly;

package Compiling is
    -- TODO: Protected Parse Tree type as output?
    package Instruction_Buffers is new Buffers (Assembly.Instruction);

    task type Compiler (
        Input : access Concatenating.Token_Buffers.Buffer;
        Output : access Instruction_Buffers.Buffer) is
        pragma Storage_Size (16#40000#);
        entry Compile;
    end Compiler;
end Compiling;
