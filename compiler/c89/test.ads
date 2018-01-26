with Buffers;
package Test is
    package Character_Buffers is new Buffers (
        Element => Character, Size => 100);

    task type Hello (Output : access Character_Buffers.Buffer) is
        entry Do_It;
    end Hello;
end Test;
