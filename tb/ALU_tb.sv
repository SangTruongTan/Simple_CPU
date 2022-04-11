module ALU_tb;

/****************** Decleration ******************/
    parameter WIDTH_DATA_LENGTH = 8;
    parameter WIDTH_ALUSEL_LENGTH = 4;
    reg [WIDTH_DATA_LENGTH - 1:0] DataA;
    reg [WIDTH_DATA_LENGTH - 1:0] DataB;
    reg [WIDTH_ALUSEL_LENGTH - 1:0] ALUSel;
    reg WriteCZ;
    wire [WIDTH_DATA_LENGTH - 1:0] DataOut;
    wire ZF;
    wire CF;

    logic [WIDTH_DATA_LENGTH - 1:0] EDataOut;
    logic EZF;
    logic ECF;
    logic [30: 0] testVector[0 : 1000];
    logic clk;
    logic [31: 0]i;

/****************** Assign Module ******************/
    ALU alu1 (.DataA(DataA),
              .DataB(DataB),
              .ALUSel(ALUSel),
              .WriteCZ(WriteCZ),
              .DataOut(DataOut),
              .CF(CF),
              .ZF(ZF));


/****************** Initialize ******************/
    initial begin
        $readmemb("C:/Users/sangt/OneDrive/Project/Job/RMIT/Lab2/CPU/tb/ALU_tb_vector.txt", testVector);
        i = 0;
        clk = 1'b0;
    end

/****************** Always function ******************/
    always @ (posedge clk) begin
        {DataA, DataB, ALUSel, WriteCZ, EDataOut, ECF, EZF} = testVector[i];
    end

    always @ (negedge clk) begin
        if(EDataOut != DataOut || ECF != CF || EZF != ZF) begin
            $display("[time =%0t]Wrong Value: Instruction:%h", $time, ALUSel);
        end
        i = i + 1;
    end
    always begin
        clk = !clk;
        #20;
    end
endmodule