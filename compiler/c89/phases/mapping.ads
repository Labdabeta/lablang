-- Translation Phase 1: Mapping
-- Converts trigraphs and assigns each item a 'location' in a file
with Source;
with Buffers;

package Mapping is
    package Mapping_Buffers is new Buffers (Source.Character);

    task type Mapper (Output : access Mapping_Buffers.Buffer) is
        pragma Storage_Size (16#40000#);
        entry Map (
            File_Name : in String;
            Trigraphs : in Boolean := True);
    end Mapper;
end Mapping;
