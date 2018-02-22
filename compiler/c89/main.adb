with Ada.Text_IO;
with Source;
with Tokens; use Tokens;
with Mapping;
with Lining;
with Decomposing;
with Preprocessing;
with Concatenating;
with Parsing;

procedure Main is
    Map_Buffer : aliased Mapping.Mapping_Buffers.Buffer;
    Line_Buffer : aliased Lining.Lining_Buffers.Buffer;
    Decomp_Buffer : aliased Decomposing.Preprocessing_Buffers.Buffer;
    Preproc_Buffer : aliased Preprocessing.Preprocessing_Buffers.Buffer;
    Concat_Buffer : aliased Concatenating.Token_Buffers.Buffer;
    Parse_Buffer : aliased Parsing.Parse_Tree_Buffers.Buffer;
    Next : Parse_Tree_Node_Access;
    Mapper : Mapping.Mapper (Map_Buffer'Access);
    Liner : Lining.Liner (Map_Buffer'Access, Line_Buffer'Access);
    Decomposer : Decomposing.Decomposer (
        Line_Buffer'Access, Decomp_Buffer'Access);
    Preprocessor : Preprocessing.Preprocessor (
        Decomp_Buffer'Access, Preproc_Buffer'Access);
    Concatenator : Concatenating.Concatenator (
        Preproc_Buffer'Access, Concat_Buffer'Access);
    Parser : Parsing.Parser (Concat_Buffer'Access, Parse_Buffer'Access);
begin
    -- Preprocessing.Add_Search_Directory ("./");
    -- Preprocessing.Add_Search_Directory ("/usr/lib/");

    -- Ada.Text_IO.Put_Line (Preprocessing.List_Search_Directories);

    Mapper.Map ("test.c");
    Liner.Line;
    Decomposer.Decompose;
    Preprocessor.Preprocess;
    Concatenator.Concatenate;
    Parser.Parse;

    loop
        Parse_Buffer.Remove (Next);

        exit when Next = null;

        Ada.Text_IO.Put_Line (Image (Next.all));
        Free (Next);
    end loop;
end Main;
