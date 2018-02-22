-- Translation Phase 4: Preprocessing
-- Preprocessing directives are executed and macros expanded
-- Any #include'd sources are processed through phase 1-4 recursively
with Source;
with Buffers;
with Decomposing;
with Tokens;

package Preprocessing is
    package Preprocessing_Buffers is new Buffers (Tokens.Preprocessing_Token);

    procedure Add_Search_Directory (Directory : in String);
    procedure Remove_Search_Directory (Directory : in String);
    function List_Search_Directories return String;

    task type Preprocessor (
        Input : access Decomposing.Preprocessing_Buffers.Buffer;
        Output : access Preprocessing_Buffers.Buffer) is
        pragma Storage_Size (16#40000#);
        entry Preprocess;
    end Preprocessor;
end Preprocessing;
