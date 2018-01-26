with Ada.Text_IO;
with Source;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Mapping is
    task body Mapper is
        Current : Unbounded_String;
        Tri : Boolean;
        File : Ada.Text_IO.File_Type;
        Row : Positive;
        Column : Positive;
    begin
        loop
            select
                accept Map (
                    File_Name : in String;
                    Trigraphs : in Boolean := True) do
                    Current := To_Unbounded_String (File_Name);
                    Tri := Trigraphs;
                end Map;
            or
                terminate;
            end select;

            Ada.Text_IO.Open (
                File, Ada.Text_IO.In_File, To_String (Current));
            Row := 1;
            Column := 1;

            while not Ada.Text_IO.End_Of_File (File) loop
                declare
                    Line : String := Ada.Text_IO.Get_Line (File);
                    I : Positive := Line'First;
                    Special : Character;
                begin
                    while I <= Line'Last loop
                        -- Replace trigraphs if necessary
                        if Tri then
                            if I < Line'Last - 1 and then
                                (Line (I) = '?' and Line (I + 1) = '?')
                            then
                                case Line (I + 2) is
                                    when '=' => Special := '#';
                                    when '(' => Special := '[';
                                    when '/' => Special := '\';
                                    when ')' => Special := ']';
                                    when ''' => Special := '^';
                                    when '<' => Special := '{';
                                    when '!' => Special := '|';
                                    when '>' => Special := '}';
                                    when '-' => Special := '~';
                                    when others => Special := '?';
                                end case;

                                Output.Insert ((Current, Row, Column, Special));
                                if Special = '?' then
                                    Output.Insert ((
                                        Current, Row, Column, Special));
                                    Output.Insert ((
                                        Current, Row, Column, Line (I + 2)));
                                end if;

                                Column := Column + 3;
                                I := I + 3;
                            else
                                Output.Insert ((
                                    Current, Row, Column, Line (I)));

                                Column := Column + 1;
                                I := I + 1;
                            end if;
                        else
                            Output.Insert ((Current, Row, Column, Line (I)));

                            Column := Column + 1;
                            I := I + 1;
                        end if;
                    end loop;

                    Output.Insert ((Current, Row, Column, ASCII.LF));
                    Column := 1;
                    Row := Row + 1;
                end;
            end loop;

            Output.Insert ((Current, Row, Column, Character'First));

            Ada.Text_IO.Close (File);
        end loop;
    end Mapper;
end Mapping;
