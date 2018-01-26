package body Character_Utils is
    function Is_Space (X : Character) return Boolean is begin
        case X is
            when ' ' | ASCII.HT | ASCII.LF | ASCII.VT | ASCII.FF | ASCII.CR =>
                return True;
            when others =>
                return False;
        end case;
    end Is_Space;
end Character_Utils;
