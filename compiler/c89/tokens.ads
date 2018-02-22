with Source;

package Tokens is
    -- A continuation token is just more of the previous token. It occurs after
    -- use of the concatenation operator and is cleaned up in phase 5/6.
    type Preprocessing_Token_Type is (
        PTT_Header_Name, PTT_Identifier, PTT_Number, PTT_Character_Constant,
        PTT_String_Literal, PTT_Operator, PTT_Whitespace, PTT_EOL, PTT_EOF,
        PTT_Continuation);
    type Preprocessing_Token is
        record
            Kind : Preprocessing_Token_Type;
            Data : Source.String;
        end record;
    function "=" (Left, Right : in Preprocessing_Token) return Boolean;
    function Image (PT : in Preprocessing_Token) return String;

    -- (Parens) {Braces} [Brackets] Ptr->Op
    type C_Token_Type is (
        -- Error
        CT_ERROR,

        -- Operators
        CT_INC_OP, CT_DEC_OP, CT_LEFT_OP, CT_RIGHT_OP, CT_LE_OP, CT_GE_OP,
        CT_EQ_OP, CT_NE_OP, CT_AND_OP, CT_OR_OP, CT_MUL_ASSIGN, CT_DIV_ASSIGN,
        CT_MOD_ASSIGN, CT_ADD_ASSIGN, CT_SUB_ASSIGN, CT_LEFT_ASSIGN,
        CT_RIGHT_ASSIGN, CT_AND_ASSIGN, CT_XOR_ASSIGN, CT_OR_ASSIGN, CT_SIZEOF,
        CT_STAR, CT_DIV, CT_PERCENT, CT_LESS, CT_GREATER, CT_CARET, CT_BAR,
        CT_ASSIGN, CT_AMPERSAND, CT_EXCLAM, CT_TILDE, CT_SUB, CT_ADD, CT_PTR_OP,

        -- Punctuators
        CT_SEMICOLON, CT_OPEN_BRACE, CT_CLOSE_BRACE, CT_OPEN_PAREN,
        CT_CLOSE_PAREN, CT_OPEN_BRACKET, CT_CLOSE_BRACKET, CT_COMMA, CT_COLON,
        CT_QUESTION, CT_DOT,

        -- Keywords
        CT_TYPEDEF, CT_EXTERN, CT_STATIC, CT_AUTO, CT_REGISTER,
        CT_CHAR, CT_SHORT, CT_INT, CT_LONG, CT_SIGNED, CT_UNSIGNED, CT_FLOAT,
        CT_DOUBLE, CT_CONST, CT_VOLATILE, CT_VOID, CT_STRUCT, CT_UNION, CT_ENUM,
        CT_ELLIPSIS, CT_CASE, CT_DEFAULT, CT_IF, CT_ELSE, CT_SWITCH, CT_WHILE,
        CT_DO, CT_FOR, CT_GOTO, CT_CONTINUE, CT_BREAK, CT_RETURN, CT_EOF,

        -- Others
        CT_TYPE_NAME, CT_IDENTIFIER, CT_CONSTANT, CT_STRING_LITERAL);
    type C_Token is
        record
            Kind : C_Token_Type;
            Data : Source.String;
        end record;
    function "=" (Left, Right : in C_Token) return Boolean;
    function Image (PT : in C_Token) return String;

    -- Based on https://www.lysator.liu.se/c/ANSI-C-grammar-y.html
    type Parse_Node_Type is (
        PT_TERMINAL, -- Terminal nodes
        PT_PRIMARY_EXPRESSION,
        PT_POSTFIX_EXPRESSION,
        PT_ARGUMENT_EXPRESSION_LIST,
        PT_UNARY_EXPRESSION,
        PT_UNARY_OPERATOR,
        PT_CAST_EXPRESSION,
        PT_MULTIPLICATIVE_EXPRESSION,
        PT_ADDITIVE_EXPRESSION,
        PT_SHIFT_EXPRESSION,
        PT_RELATIONAL_EXPRESSION,
        PT_EQUALITY_EXPRESSION,
        PT_AND_EXPRESSION,
        PT_EXCLUSIVE_OR_EXPRESSION,
        PT_INCLUSIVE_OR_EXPRESSION,
        PT_LOGICAL_AND_EXPRESSION,
        PT_LOGICAL_OR_EXPRESSION,
        PT_CONDITIONAL_EXPRESSION,
        PT_ASSIGNMENT_EXPRESSION,
        PT_ASSIGNMENT_OPERATOR,
        PT_EXPRESSION,
        PT_CONSTANT_EXPRESSION,
        PT_DECLARATION,
        PT_DECLARATION_SPECIFIERS,
        PT_INIT_DECLARATOR_LIST,
        PT_INIT_DECLARATOR,
        PT_STORAGE_CLASS_SPECIFIER,
        PT_TYPE_SPECIFIER,
        PT_STRUCT_OR_UNION_SPECIFIER,
        PT_STRUCT_OR_UNION,
        PT_STRUCT_DECLARATION_LIST,
        PT_STRUCT_DECLARATION,
        PT_SPECIFIER_QUALIFIER_LIST,
        PT_STRUCT_DECLARATOR_LIST,
        PT_STRUCT_DECLARATOR,
        PT_ENUM_SPECIFIER,
        PT_ENUMERATOR_LIST,
        PT_ENUMERATOR,
        PT_TYPE_QUALIFIER,
        PT_DECLARATOR,
        PT_DIRECT_DECLARATOR,
        PT_POINTER,
        PT_TYPE_QUALIFIER_LIST,
        PT_PARAMETER_TYPE_LIST,
        PT_PARAMETER_LIST,
        PT_PARAMETER_DECLARATION,
        PT_IDENTIFIER_LIST,
        PT_TYPE_NAME,
        PT_ABSTRACT_DECLARATOR,
        PT_DIRECT_ABSTRACT_DECLARATOR,
        PT_INITIALIZER,
        PT_INITIALIZER_LIST,
        PT_STATEMENT,
        PT_LABELED_STATEMENT,
        PT_COMPOUND_STATEMENT,
        PT_DECLARATION_LIST,
        PT_STATEMENT_LIST,
        PT_EXPRESSION_STATEMENT,
        PT_SELECTION_STATEMENT,
        PT_ITERATION_STATEMENT,
        PT_JUMP_STATEMENT,
        PT_EXTERNAL_DECLARATION, -- Start
        PT_FUNCTION_DEFINITION);

    type Parse_Tree_Node (Size : Natural);
    type Parse_Tree_Node_Access is access all Parse_Tree_Node;
    type Parse_Tree_List is array (Positive range <>) of Parse_Tree_Node_Access;
    type Parse_Tree_Node (Size : Natural) is
        record
            Kind : Parse_Node_Type;
            case Size is
                when 0 => Contents : C_Token;
                when others => Children : Parse_Tree_List (1 .. Size);
            end case;
        end record;
    function Image (Item : in Parse_Tree_Node) return String;
    procedure Free (Item : in out Parse_Tree_Node_Access);
end Tokens;
