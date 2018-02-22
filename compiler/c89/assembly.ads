with Source;

package Assembly is
    type Operation is (
        OP_ADD,OP_MUL,OP_DIV,OP_MOD,OP_ADU,OP_MLU,OP_DVU,OP_MDU,
        OP_AND,OP_ORR,OP_XOR,OP_IMP,OP_NAN,OP_NOR,OP_XNR,OP_LIE,
        OP_JGT,OP_JEQ,OP_CMP,OP_JAL,OP_JLT,OP_JNE,OP_CAS,OP_INT,
        OP_LDR,OP_STR,OP_GET,OP_PUT,OP_LDB,OP_STB,OP_GTB,OP_PTB,
        OP_CLZ,OP_PPZ,OP_SHR,OP_MOV,OP_CLO,OP_POP,OP_SHE,OP_MSR,
        OP_ITF,OP_FLR,OP_CEL,OP_RND,OP_UTF,OP_FLU,OP_CLU,OP_RDU,
        OP_FAD,OP_FMU,OP_FDV,OP_FMO,OP_EXP,OP_POW,OP_LOG,OP_HYP,
        OP_SIN,OP_COS,OP_TAN,OP_CMP,OP_ASN,OP_ACS,OP_ATN,OP_EXT);
    type Register_Index is mod 2 ** 5;
    type Instruction is
        record
            Op : Operation;
            Immediate : Integer;
            A, B : Register_Index;
            Root : Source.String;
        end record;
    function Image (I : in Instruction) return String;
end Assembly;