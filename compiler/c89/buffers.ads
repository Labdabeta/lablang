generic
    type Element is private;
package Buffers is
    type Element_Node;
    type Element_Node_Access is access Element_Node;
    type Element_Node is
        record
            Value : Element;
            Next : Element_Node_Access;
        end record;
    protected type Buffer is
        entry Insert (Item : in Element);
        entry Remove (Item : out Element);
        entry Replace (Item : in Element);
    private
        Head : Element_Node_Access := null;
        Tail : Element_Node_Access := null;
        Next_Node : Element_Node_Access := new Element_Node;
    end Buffer;
end Buffers;
