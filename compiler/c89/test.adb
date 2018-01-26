package body Test is
    task body Hello is
        Text : String := "Hello";
    begin
        loop
            select
                accept Do_It;
            or
                terminate;
            end select;

            for I in Text'Range loop
                Output.Insert (Text (I));
            end loop;

            Output.Insert (Character'First);
        end loop;
    end Hello;
end Test;
