
module ALU (
    DataA,
    DataB,
    ALUSel,
    WriteCZ,
    DataOut,
    CF,
    ZF
);
/****************** Decleration ******************/
    parameter WIDTH_DATA_LENGTH = 8;
    parameter WIDTH_ALUSEL_LENGTH = 4;
    input [WIDTH_DATA_LENGTH - 1:0] DataA;
    input [WIDTH_DATA_LENGTH - 1:0] DataB;
    input [WIDTH_ALUSEL_LENGTH - 1:0] ALUSel;
    input WriteCZ;
    reg Carry;
    output reg [WIDTH_DATA_LENGTH - 1:0] DataOut;
    output reg CF;
    output reg ZF;

/****************** Always function ******************/
    always @(*) begin
        case (ALUSel)
            4'b0000: {Carry, DataOut} = DataA;       //Sel A
            4'b0001: {Carry, DataOut} = DataB;       //Sel B
            4'b0010: {Carry, DataOut} = DataA + 1'b1;   //A + 1
            4'b0011: {Carry, DataOut} = DataB + 1'b1;   //B + 1
            4'b0100: {Carry, DataOut} = DataA + DataB;   //ADD
            4'b0101: {Carry, DataOut} = DataA - DataB;   //SUB
            4'b0110: {Carry, DataOut} = DataA & DataB;   //AND
            4'b0111: {Carry, DataOut} = DataA | DataB;   //OR
            4'b1000: {Carry, DataOut} = DataA >> 1;      //A >> 1
            4'b1001: {Carry, DataOut} = DataA << 1;      //A << 1
            default: {Carry, DataOut} = 9'b0;
        endcase
    end
    always @(*) begin
        if (WriteCZ == 1'b1) begin
            CF = Carry;
            ZF = !(|DataOut);
        end
    end
endmodule