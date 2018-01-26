with Buffers;

package body Lining is
    task body Liner is
        Last : Source.Character;
        Follow : Source.Character;
    begin
        loop
            select
                accept Line;
            or
                terminate;
            end select;
            loop
                Input.Remove (Last);

                if Last.Value = '\' then
                    Input.Remove (Follow);

                    if Follow.Value /= ASCII.LF then
                        Output.Insert (Last);
                        Output.Insert (Follow);
                    end if;
                else
                    Output.Insert (Last);
                end if;

                exit when Last.Value = Character'First;
            end loop;
        end loop;
    end Liner;
end Lining;
