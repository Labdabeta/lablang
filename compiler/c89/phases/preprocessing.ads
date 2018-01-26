-- Translation Phase 4: Preprocessing
-- Preprocessing directives are executed and macros expanded
-- Any #include'd sources are processed through phase 1-4 recursively
with Source;
with Buffers;
with Decomposing;
with Tokens;

package Preprocessing is
    package Preprocessing_Buffers is new Buffers (
        Element => Tokens.Preprocessing_Token, Size => 16#1000#);

    procedure Add_Search_Directory (Directory : in String);
    procedure Remove_Search_Directory (Directory : in String);
    function List_Search_Directories return String;

    task type Preprocessor (
        Input : access Decomposing.Preprocessing_Buffers.Buffer;
        Output : access Preprocessing_Buffers.Buffer) is
        -- Extra space needed to support 3 child tasks
        -- 4x task size
        pragma Storage_Size (8388608);
        entry Preprocess;
    end Preprocessor;
end Preprocessing;
