-- Translation Phase 1: Mapping
-- Converts trigraphs and assigns each item a 'location' in a file
with Source;
with Buffers;

package Mapping is
    package Mapping_Buffers is new Buffers (
        Element => Source.Character, Size => 16#1000#);

    task type Mapper (Output : access Mapping_Buffers.Buffer) is
        entry Map (
            File_Name : in String;
            Trigraphs : in Boolean := True);
    end Mapper;
end Mapping;
