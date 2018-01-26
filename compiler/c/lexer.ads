package Lexer is
    type Token_Type is (
        TT_KW_AUTO, TT_KW_BREAK, TT_KW_CASE, TT_KW_CONST, TT_KW_CONTINUE,
        TT_KW_DEFAULT, TT_KW_DO, TT_KW_ELSE, TT_KW_ENUM, TT_KW_EXTERN,
        TT_KW_FLOAT, TT_KW_FOR, TT_KW_GOTO, TT_KW_IF, TT_KW_INT,
        TT_KW_REGISTER, TT_KW_RETURN, TT_KW_SIGNED, TT_KW_SIZEOF,
        TT_KW_STATIC, TT_KW_STRUCT, TT_KW_SWITCH, TT_KW_TYPEDEF,
        TT_KW_UNION, TT_KW_UNSIGNED, TT_KW_VOID, TT_KW_VOLATILE,
        TT_KW_WHILE,
        TT_IDENTIFIER, TT_CONSTANT, TT_STRING_LITERAL, TT_SEMICOLON,
        TT_OPEN_BRACE, TT_CLOSE_BRACE, TT_OPEN_PAREN, TT_CLOSE_PAREN,
        TT_OPEN_BRACKET, TT_CLOSE_BRACKET, TT_OP_ELLIPSIS,
        TT_OP_RIGHT_ASSIGN, TT_OP_LEFT_ASSIGN, TT_OP_ADD_ASSIGN,
        TT_OP_SUB_ASSIGN, TT_OP_MUL_ASSIGN, TT_OP_DIV_ASSIGN,
        TT_OP_MOD_ASSIGN, TT_OP_AND_ASSIGN, TT_OP_XOR_ASSIGN,
        TT_OP_OR_ASSIGN,
        TT_OP_RIGHT, TT_OP_LEFT, TT_OP_INC, TT_OP_DEC,
        TT_OP_ARROW, TT_OP_AND, TT_OP_OR,
        TT_OP_LESS_EQUAL, TT_OP_GREATER_EQUAL, TT_OP_EQUAL, TT_OP_NOT_EQUAL,
        TT_COMMA, TT_COLON, TT_ASSIGN, TT_DOT, TT_AND, TT_NEGATE, TT_NOT,
        TT_MINUS, TT_PLUS, TT_TIMES, TT_DIVIDE, TT_MODULO, TT_LESS,
        TT_GREATER, TT_XOR, TT_OR, TT_QUESTION, TT_COMMENT, TT_EOF);

    type Token (Size : Natural) is
        record
            Kind : Token_Type;
            Lexeme : String (1 .. Size);
        end record;

    -- You must reset the lexer before using it
    procedure Reset;

    -- Push characters in, this will block when it needs to wait
    -- Lex (ASCII.NUL) to 'end of file'
    procedure Lex (Next : in Character);

    function Next return Token;
end Lexer;
