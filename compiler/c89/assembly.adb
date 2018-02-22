package body Assembly is
    Operation_Image : array (Operation) of String := (
        "add","mul","div","mod","adu","mlu","dvu","mdu",
        "and","orr","xor","imp","nan","nor","xnr","lie",
        "jgt","jeq","cmp","jal","jlt","jne","cas","int",
        "ldr","str","get","put","ldb","stb","gtb","ptb",
        "clz","ppz","shr","mov","clo","pop","she","msr",
        "itf","flr","cel","rnd","utf","flu","clu","rdu",
        "fad","fmu","fdv","fmo","exp","pow","log","hyp",
        "sin","cos","tan","cmp","asn","acs","atn","ext");

    function Image (I : in Instruction) return String is
        function Immediate_Image (V : Integer) return String is
            function Chop (S : String) return String is begin
                return S (S'First + 1 .. S'Last);
            end Chop;
        begin
            if V = 0 then
                return "";
            elsif V > 0 then
                return "(" & Chop (Integer'Image (V)) & ")";
            else
                return "(" & Integer'Image (V) & ")";
            end if;
        end Immediate_Image;
    begin
        return Operation_Image (I.Op) &
            Register_Index'Image (I.A) & "," &
            Register_Index'Image (I.B) &
            Immediate_Image (I.Immediate) & "; " &
            Source.String'Image (I.Root);
    end Image;
end Assembly;
