package body Buffers is
    protected body Buffer is
        entry Insert (Item : in Element) when Count < Size is begin
            Contents (Index) := Item;
            Index := Index - 1;
            if Index < 1 then
                Index := Size;
            end if;
            Count := Count + 1;
        end Insert;

        entry Remove (Item : out Element) when Count > 0 is begin
            if Index + Count > Size then
                Item := Contents (Index + Count - Size);
            else
                Item := Contents (Index + Count);
            end if;
            Count := Count - 1;
        end Remove;
    end Buffer;
end Buffers;
