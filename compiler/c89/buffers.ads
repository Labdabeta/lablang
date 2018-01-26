generic
    type Element is private;
    Size : Positive;
package Buffers is
    type Element_List is array (1 .. Size) of Element;
    protected type Buffer is
        entry Insert (Item : in Element);
        entry Remove (Item : out Element);
    private
        Contents : Element_List;
        Index : Positive := Size; -- Index to put element into
        Count : Natural := 0; -- Number of elements
    end Buffer;
end Buffers;
