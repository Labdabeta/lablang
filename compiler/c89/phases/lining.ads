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
        -- I have never seen the liner go beyond ~2.5k stack
        pragma Storage_Size (16#20000#);
        entry Line;
    end Liner;
end Lining;
