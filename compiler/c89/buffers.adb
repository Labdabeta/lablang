with Ada.Unchecked_Deallocation;

package body Buffers is
    procedure Free_Node is new Ada.Unchecked_Deallocation (
        Element_Node, Element_Node_Access);
    protected body Buffer is
        entry Insert (Item : in Element) when Next_Node /= null is
        begin
            Next_Node.Value := Item;
            Next_Node.Next := null;
            if Head = null then
                Head := Next_Node;
                Tail := Next_Node;
            else
                Tail.Next := Next_Node;
                Tail := Next_Node;
            end if;

            Next_Node := new Element_Node;
        exception
            when Storage_Error =>
                Next_Node := null;
        end Insert;

        entry Remove (Item : out Element) when Head /= null is
            Removed : Element_Node_Access := Head;
        begin
            Item := Removed.Value;
            Head := Removed.Next;
            if Next_Node = null then
                Next_Node := Removed;
            else
                Free_Node (Removed);
            end if;
        end Remove;

        entry Replace (Item : in Element) when Next_Node /= null is
        begin
            Next_Node.Value := Item;
            Next_Node.Next := Head;
            if Head = null then
                Head := Next_Node;
                Tail := Next_Node;
            else
                Head := Next_Node;
            end if;

            Next_Node := new Element_Node;
        exception
            when Storage_Error =>
                Next_Node := null;
        end Replace;
    end Buffer;
end Buffers;
