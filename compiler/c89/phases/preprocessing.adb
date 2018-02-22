with Source;
with Mapping;
with Lining;
with Decomposing;
with Tokens; use Tokens;
with Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Ordered_Sets;
with Ada.Containers.Vectors;
with Ada.Containers.Hashed_Maps;
with Ada.Strings.Unbounded.Hash;
with Ada.Calendar;
with Ada.Calendar.Formatting;

package body Preprocessing is
    package String_Sets is new Ada.Containers.Ordered_Sets (Unbounded_String);

    package PP_Vectors is new Ada.Containers.Vectors (
        Index_Type => Positive, Element_Type => Preprocessing_Token);

    package Macro_Maps is new Ada.Containers.Hashed_Maps (
        Key_Type => Unbounded_String, Element_Type => PP_Vectors.Vector,
        Hash => Ada.Strings.Unbounded.Hash,
        Equivalent_Keys => "=",
        "=" => PP_Vectors."=");
    -- DEBUGGING PROCEDURE
    procedure Print_MM (M : in Macro_Maps.Map) is
        procedure Print_PPV (C : in Macro_Maps.Cursor) is
            procedure Print_PP (Cur : in PP_Vectors.Cursor) is
            begin
                Ada.Text_IO.Put_Line (ASCII.HT &
                    Image (PP_Vectors.Element (Cur)));
            end Print_PP;
        begin
            Ada.Text_IO.Put_Line (
                "KEY " & To_String (Macro_Maps.Key (C)) & ":");
            PP_Vectors.Iterate (Macro_Maps.Element (C), Print_PP'Access);
        end Print_PPV;
    begin
        Macro_Maps.Iterate (M, Print_PPV'Access);
    end Print_MM;

    Search_Directories : String_Sets.Set;

    procedure Add_Search_Directory (Directory : in String) is begin
        String_Sets.Insert (
            Search_Directories, To_Unbounded_String (Directory));
    end Add_Search_Directory;

    procedure Remove_Search_Directory (Directory : in String) is begin
        String_Sets.Delete (
            Search_Directories, To_Unbounded_String (Directory));
    end Remove_Search_Directory;

    function List_Search_Directories return String is
        Result : Unbounded_String;
        procedure Add_To_Result (Position : in String_Sets.Cursor) is begin
            Append (Result, String_Sets.Element (Position));
            Append (Result, "" & ASCII.LF);
        end Add_To_Result;
    begin
        String_Sets.Iterate (Search_Directories, Add_To_Result'Access);
        return To_String (Result);
    end List_Search_Directories;

    task body Preprocessor is
        Macros : Macro_Maps.Map;

        procedure Preload_Macros is
            procedure Add (What : in String) is begin
                Macro_Maps.Insert (
                    Macros,
                    To_Unbounded_String (What),
                    PP_Vectors.Empty_Vector);
            end Add;
        begin
            Add ("__FILE__");
            Add ("__LINE__");
            Add ("__DATE__");
            Add ("__STDC__");
        end Preload_Macros;

        -- 'Coloured' Macros, to prevent recursive expansion
        Expanded_Macros : String_Sets.Set;
        Map_Buffer : aliased Mapping.Mapping_Buffers.Buffer;
        Line_Buffer : aliased Lining.Lining_Buffers.Buffer;
        Deco_Buffer : aliased Decomposing.Preprocessing_Buffers.Buffer;

        Mapper : Mapping.Mapper (Map_Buffer'Access);
        Liner : Lining.Liner (Map_Buffer'Access, Line_Buffer'Access);
        Decomposer : Decomposing.Decomposer (
            Line_Buffer'Access, Deco_Buffer'Access);

        procedure Process_Decomposition (
            Decomp : access Decomposing.Preprocessing_Buffers.Buffer) is
            Next : Preprocessing_Token;
            New_Line : Boolean := True;
            Directive : Boolean := False;

            procedure Process_Define is
                Rest_Of_Line : PP_Vectors.Vector;
                Name : Unbounded_String;
            begin
                Decomp.Remove (Next);
                while Next.Kind /= PTT_Identifier loop
                    Decomp.Remove (Next);
                end loop;

                Name := Next.Data.Value;
                Decomp.Remove (Next);

                while Next.Kind /= PTT_EOL loop
                    PP_Vectors.Append (Rest_Of_Line, Next);
                    Decomp.Remove (Next);
                end loop;

                if Macro_Maps.Contains (Macros, Name) then
                    Macro_Maps.Replace (Macros, Name, Rest_Of_Line);
                else
                    Macro_Maps.Insert (Macros, Name, Rest_Of_Line);
                end if;
            end Process_Define;

            procedure Include_Local_File (File : in Unbounded_String) is
                -- TODO: Somehow use a 'bigger' one? or something?
                Deco_Copy_Buffer :
                    aliased Decomposing.Preprocessing_Buffers.Buffer;
                Copy_Next : Preprocessing_Token;
            begin
                Mapper.Map (Slice (File, 2, Length (File) - 1));
                Liner.Line;
                Decomposer.Decompose;

                loop
                    Deco_Buffer.Remove (Copy_Next);
                    Deco_Copy_Buffer.Insert (Copy_Next);

                    exit when Copy_Next.Kind = PTT_EOF;
                end loop;

                Process_Decomposition (Deco_Copy_Buffer'Access);
            end Include_Local_File;

            procedure Include_Builtin_File (File : in Unbounded_String) is
                function Does_File_Exist (Name : String) return Boolean is
                    The_File : Ada.Text_IO.File_Type;
                begin
                    Ada.Text_IO.Open (The_File, Ada.Text_IO.In_File, Name);
                    Ada.Text_IO.Close (The_File);
                    return True;
                exception
                    when Ada.Text_IO.Name_Error =>
                        return False;
                end Does_File_Exist;

                Opened_File : Boolean := False;

                procedure Check_Open (Cursor : in String_Sets.Cursor) is
                    Base : Unbounded_String := String_Sets.Element (Cursor);
                begin
                    if Opened_File then
                        return; -- Don't open ALL matches we find
                    end if;

                    if Does_File_Exist (To_String (Base & File)) then
                        Include_Local_File (Base & File);
                        Opened_File := True;
                    end if;
                end Check_Open;
            begin
                Ada.Text_IO.Put_Line ("<Including> " & To_String (File));

                String_Sets.Iterate (Search_Directories, Check_Open'Access);
            end Include_Builtin_File;

            procedure Process_Include is
                -- To concatenate the tokens in a <include>
                Include_String : Unbounded_String;
            begin
                loop
                    Decomp.Remove (Next);

                    case Next.Kind is
                        when PTT_String_Literal =>
                            Include_Local_File (Next.Data.Value);
                            return;
                        when PTT_Operator =>
                            if Next.Data.Value = "<" then
                                Include_String := To_Unbounded_String ("");
                                Decomp.Remove (Next);

                                while Next.Data.Value /= ">" loop
                                    Append (Include_String, Next.Data.Value);
                                    Decomp.Remove (Next);
                                end loop;

                                Include_Builtin_File (Include_String);
                            end if;
                            return;
                        when PTT_Whitespace =>
                            null;
                        -- TODO: Expand identifiers in-place, then try again
                        when others => return;
                    end case;
                end loop;
            end Process_Include;

            procedure Skip_To_Endif is
                Line_Start : Boolean := False;
                Is_Directive : Boolean := False;
                Depth : Natural := 0;
            begin
                loop
                    case Next.Kind is
                        when PTT_EOL =>
                            Line_Start := True;
                        when PTT_Whitespace =>
                            null;
                        when PTT_Identifier =>
                            if Is_Directive then
                                Is_Directive := False;
                                Line_Start := False;
                                if Slice (Next.Data.Value, 1, 2) = "if" then
                                    Depth := Depth + 1;
                                elsif Next.Data.Value = "endif" then
                                    if Depth = 0 then
                                        Decomp.Remove (Next);
                                        return;
                                    else
                                        Depth := Depth - 1;
                                    end if;
                                end if;
                            end if;
                        when PTT_Operator =>
                            if Next.Data.Value = "#" then
                                if Line_Start then
                                    Is_Directive := True;
                                end if;
                            else
                                Line_Start := False;
                            end if;
                        when others =>
                            Line_Start := False;
                    end case;

                    Decomp.Remove (Next);
                end loop;
            end Skip_To_Endif;

            procedure Process_Ifndef is begin
                Decomp.Remove (Next);

                while Next.Kind /= PTT_Identifier loop
                    Decomp.Remove (Next);
                end loop;

                if Macro_Maps.Contains (Macros, Next.Data.Value) then
                    Skip_To_Endif;
                else
                    Decomp.Remove (Next);
                end if;
            end Process_Ifndef;

            procedure Process_Ifdef is begin
                Decomp.Remove (Next);

                while Next.Kind /= PTT_Identifier loop
                    Decomp.Remove (Next);
                end loop;

                if not Macro_Maps.Contains (Macros, Next.Data.Value) then
                    Skip_To_Endif;
                else
                    Decomp.Remove (Next);
                end if;
            end Process_Ifdef;

            procedure Process_Undef is begin
                Decomp.Remove (Next);

                while Next.Kind /= PTT_Identifier loop
                    Decomp.Remove (Next);
                end loop;

                if Macro_Maps.Contains (Macros, Next.Data.Value) then
                    Macro_Maps.Delete (Macros, Next.Data.Value);
                end if;

                Decomp.Remove (Next);
            end Process_Undef;

            procedure Process_Directive is
                Identifier : Unbounded_String := Next.Data.Value;
            begin
                Directive := False;
                if Identifier = "define" then
                    Process_Define;
                elsif Identifier = "include" then
                    Process_Include;
                elsif Identifier = "ifndef" then
                    Process_Ifndef;
                elsif Identifier = "ifdef" then
                    Process_Ifdef;
                elsif Identifier = "undef" then
                    Process_Undef;
                elsif Identifier = "endif" then
                    null;
                else
                    Output.Insert (Next);
                end if;
            end Process_Directive;

            procedure Expand_Macro is
                Macro_Name : Unbounded_String := Next.Data.Value;
                Replacement : PP_Vectors.Vector :=
                    Macro_Maps.Element (Macros, Macro_Name);
                Rec_Buffer : aliased Decomposing.Preprocessing_Buffers.Buffer;
                Parameters : Macro_Maps.Map;
                Done_Args : Boolean := False;
                Got_Pound : Boolean := False;
                Got_Concat : Boolean := False;
                Got_Whitespace : Boolean := False;

                procedure Insert_Relative (PTT : in Preprocessing_Token) is
                    New_Element : Preprocessing_Token;
                begin
                    New_Element.Kind := PTT.Kind;
                    if Got_Concat and PTT.Kind /= PTT_Whitespace then
                        Got_Concat := False;
                        New_Element.Kind := PTT_Continuation;
                    end if;

                    New_Element.Data.Value := PTT.Data.Value;
                    if Got_Pound and PTT.Kind /= PTT_Whitespace then
                        Got_Pound := False;
                        New_Element.Kind := PTT_String_Literal;
                        New_Element.Data.Value := """" & PTT.Data.Value & """";
                    end if;

                    New_Element.Data.File_Name := Next.Data.File_Name;
                    New_Element.Data.Row := Next.Data.Row;
                    New_Element.Data.Column := Next.Data.Column;
                    Rec_Buffer.Insert (New_Element);
                end Insert_Relative;

                procedure Populate_Buffer_Raw (C : PP_Vectors.Cursor) is begin
                    -- Rec_Buffer.Insert (PP_Vectors.Element (C));
                    Insert_Relative (PP_Vectors.Element (C));
                end Populate_Buffer_Raw;

                procedure Populate_Buffer (C : PP_Vectors.Cursor) is
                    Done_Arg : Boolean := False;
                    P : Preprocessing_Token := PP_Vectors.Element (C);
                    Current_Param : PP_Vectors.Vector;
                    Open_Count : Natural := 0; -- Open bracket count

                    procedure Add_To_Result (Cur : PP_Vectors.Cursor) is begin
                        -- Rec_Buffer.Insert (PP_Vectors.Element (Cur));
                        Insert_Relative (PP_Vectors.Element (Cur));
                    end Add_To_Result;
                begin
                    if not Done_Args then
                        if P.Data.Value = ")" then
                            Done_Args := True;
                        elsif P.Kind = PTT_Identifier then
                            Current_Param := PP_Vectors.Empty_Vector;

                            loop
                                exit when
                                    Next.Data.Value = "," and Open_Count = 0;
                                if Next.Data.Value = "(" then
                                    PP_Vectors.Append (Current_Param, Next);
                                    Open_Count := Open_Count + 1;
                                elsif Next.Data.Value = ")" then
                                    if Open_Count = 0 then
                                        PP_Vectors.Append (Current_Param, Next);
                                        exit; -- End of args
                                    end if;
                                    Open_Count := Open_Count - 1;
                                    PP_Vectors.Append (Current_Param, Next);
                                else
                                    PP_Vectors.Append (Current_Param, Next);
                                end if;

                                Decomp.Remove (Next);
                            end loop;
                            Decomp.Remove (Next); -- Get past the comma

                            Macro_Maps.Insert (
                                Parameters, P.Data.Value, Current_Param);
                            -- NOTE: only other things should be WS and commas
                        end if;
                    else
                        if P.Kind = PTT_Identifier and Macro_Maps.Contains (
                            Parameters, P.Data.Value)
                        then
                            PP_Vectors.Iterate (Macro_Maps.Element (
                                Parameters, P.Data.Value),
                                Add_To_Result'Access);
                            Got_Pound := False;
                            Got_Concat := False;
                            Got_Whitespace := False;
                        elsif P.Data.Value = "#" then
                            if Got_Pound and not Got_Whitespace then
                                Got_Concat := True;
                                Got_Pound := False;
                            else
                                Got_Pound := True;
                                Got_Concat := False;
                            end if;
                            Got_Whitespace := False;
                        elsif P.Kind = PTT_Whitespace then
                            Got_Whitespace := True;
                            Insert_Relative (P);
                        else
                            Insert_Relative (P);
                            Got_Pound := False;
                            Got_Concat := False;
                            Got_Whitespace := False;
                        end if;
                    end if;
                end Populate_Buffer;

                function To_UBS (X : in Positive) return Unbounded_String is
                    Result : Unbounded_String;
                begin
                    Result := To_Unbounded_String (Positive'Image (X));
                    return Delete (Result, 1, 1);
                end To_UBS;

                -- Result looks like "Feb 1 1996"
                function Current_Date return String is
                    Now : Ada.Calendar.Time := Ada.Calendar.Clock;
                    Month_Names : array (Ada.Calendar.Month_Number) of
                        String (1 .. 3) := (
                            1 => "Jan", 2 => "Feb", 3 => "Mar", 4 => "Apr",
                            5 => "May", 6 => "Jun", 7 => "Jul", 8 => "Aug",
                            9 => "Sep", 10 => "Oct", 11 => "Nov", 12 => "Dec");
                begin
                    return Month_Names (Ada.Calendar.Month (Now)) &
                        Ada.Calendar.Day_Number'Image (Ada.Calendar.Day (Now)) &
                        Ada.Calendar.Year_Number'Image (
                            Ada.Calendar.Year (Now));
                end Current_Date;
            begin
                -- If we already expanded this macro, stop!
                if String_Sets.Contains (Expanded_Macros, Macro_Name) then
                    return;
                else
                    String_Sets.Insert (Expanded_Macros, Macro_Name);
                end if;

                -- Check if the macro has arguments
                if PP_Vectors.Is_Empty (Replacement) then
                    -- Check for built-ins, otherwise return 1
                    if Macro_Name = "__FILE__" then
                        Rec_Buffer.Insert ((PTT_String_Literal,
                        (Next.Data.File_Name, Next.Data.Row, Next.Data.Column,
                        """" & Next.Data.File_Name & """")));
                    elsif Macro_Name = "__LINE__" then
                        Rec_Buffer.Insert ((PTT_Number,
                            (Next.Data.File_Name, Next.Data.Row,
                            Next.Data.Column, To_UBS (Next.Data.Row))));
                    elsif Macro_Name = "__DATE__" then
                        Rec_Buffer.Insert ((PTT_String_Literal,
                            (Next.Data.File_Name, Next.Data.Row,
                            Next.Data.Column, To_Unbounded_String (
                                """" & Current_Date & """"))));
                    else
                        Rec_Buffer.Insert ((PTT_Number,
                            (Next.Data.File_Name, Next.Data.Row,
                            Next.Data.Column, To_Unbounded_String ("1"))));
                    end if;
                elsif
                    PP_Vectors.First_Element (Replacement).Kind = PTT_Whitespace
                then
                    -- No arguments
                    PP_Vectors.Iterate (
                        Replacement, Populate_Buffer_Raw'Access);
                else
                    Decomp.Remove (Next); -- Get past the identifier
                    -- Arguments
                    loop -- Get past the open brace
                        exit when Next.Data.Value = "(";
                        Decomp.Remove (Next);
                    end loop;
                    Decomp.Remove (Next);
                    PP_Vectors.Iterate (
                        Replacement, Populate_Buffer'Access);
                end if;

                Rec_Buffer.Insert ((PTT_EOF, (Next.Data.File_Name,
                    Next.Data.Row, Next.Data.Column, Null_Unbounded_String)));
                Process_Decomposition (Rec_Buffer'Access);
                String_Sets.Delete (Expanded_Macros, Macro_Name);
            end Expand_Macro;
        begin
            Decomp.Remove (Next);

            loop
                case Next.Kind is
                    when PTT_EOF =>
                        return;
                    when PTT_EOL =>
                        Output.Insert (Next);
                        New_Line := True;
                    when PTT_Whitespace =>
                        Output.Insert (Next);
                    when PTT_Operator =>
                        if Next.Data.Value = "#" then
                            if New_Line then
                                Directive := True;
                            else
                                Output.Insert (Next);
                            end if;
                        else
                            Output.Insert (Next);
                            New_Line := False;
                        end if;
                    when PTT_Identifier =>
                        if Directive then
                            Process_Directive;
                            New_Line := True;
                        elsif Macro_Maps.Contains (Macros, Next.Data.Value) then
                            Expand_Macro;
                            New_Line := False;
                        else
                            Output.Insert (Next);
                            New_Line := False;
                        end if;
                    when others =>
                        Output.Insert (Next);
                        New_Line := False;
                end case;

                Decomp.Remove (Next);
            end loop;
        end Process_Decomposition;
    begin
        Preload_Macros;
        loop
            select
                accept Preprocess;
            or
                terminate;
            end select;

            Process_Decomposition (Input);
            Output.Insert ((PTT_EOF, (
                To_Unbounded_String (""), 1, 1,
                To_Unbounded_String (""))));
        end loop;
    end Preprocessor;
end Preprocessing;
