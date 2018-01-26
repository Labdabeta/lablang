with Ada.Containers.Vectors;
with Ada.Unchecked_Deallocation;

package body String_Storage is
    type String_Access is access all String;
    package String_Vectors is new Ada.Containers.Vectors (
        Index_Type => String_Handle,
        Element_Type => String_Access);

    Contents : String_Vectors.Vector := String_Vectors.Empty_Vector;

    function Store (What : in String) return String_Handle is
        New_String : String_Access := new String (What'Range);
    begin
        New_String.all := What;
        String_Vectors.Append (Contents, New_String);
        return String_Handle (String_Vectors.Last_Index (Contents));
    end Store;

    function Get (What : in String_Handle) return String is
    begin
        return String_Vectors.Element (Contents, What).all;
    end Get;

    -- Deletes all the stored strings
    procedure Empty is
        procedure Free_String is new Ada.Unchecked_Deallocation (
            String, String_Access);
        Item : String_Access;
    begin
        while not String_Vectors.Is_Empty (Contents) loop
            Item := String_Vectors.First_Element (Contents);
            Free_String (Item);
            String_Vectors.Delete_First (Contents);
        end loop;
    end Empty;
end String_Storage;
