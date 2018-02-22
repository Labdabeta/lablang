-- Translation Phase 2: Lining
-- Converts backslash newline into nothing
with Source;
with Buffers;
with Mapping;

package Lining is
    package Lining_Buffers is new Buffers (Source.Character);

    task type Liner (
        Input : access Mapping.Mapping_Buffers.Buffer;
        Output : access Lining_Buffers.Buffer) is
        pragma Storage_Size (16#40000#);
        entry Line;
    end Liner;
end Lining;
