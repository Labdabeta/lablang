-- Translation Phase 2: Lining
-- Converts backslash newline into nothing
with Source;
with Buffers;
with Mapping;

package Lining is
    package Lining_Buffers is new Buffers (
        Element => Source.Character, Size => 16#1000#);

    task type Liner (
        Input : access Mapping.Mapping_Buffers.Buffer;
        Output : access Lining_Buffers.Buffer) is
        entry Line;
    end Liner;
end Lining;
