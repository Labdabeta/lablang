package String_Storage is
    type String_Handle is private;
    function Store (What : in String) return String_Handle;
    function Get (What : in String_Handle) return String;
    procedure Empty;
private
    type String_Handle is new Positive;
end String_Storage;
