module InputPort_tb;

/****************** Decleration ******************/
parameter WIDTH_DATA_LENGTH = 8;
parameter TEST_FILE_LENGTH = 18;
logic [WIDTH_DATA_LENGTH - 1: 0] Input;
logic Write;
logic Clk;
logic Rst;

wire [WIDTH_DATA_LENGTH - 1:0] Output;
logic [WIDTH_DATA_LENGTH - 1:0] EOutput;

logic [TEST_FILE_LENGTH - 1: 0] testVector[0 : 1000];
logic [31: 0]i;

/****************** Assign Module ******************/
InputPort Inport (.Input(Input),
                  .Write(Write),
                  .Clk(Clk),
                  .Rst(Rst),
                  .Output(Output));

/****************** Initialize ******************/
    initial begin
        $readmemb("C:/Users/sangt/OneDrive/Project/Job/RMIT/Lab2/CPU/tb/InputPort_tb_vector.txt", testVector);
        i = -1;
        Clk = 1'b0;
    end

/****************** Always function ******************/
always @ (i) begin
        {Write, Rst, Input, EOutput} = testVector[i];
    end

    always @ (negedge Clk) begin
        if(EOutput != Output) begin
            $display("[time =%0t]Wrong Value: Output:%h", $time, Output);
        end
        i = i + 1;
    end
    always begin
        Clk = 1'b0;
        #5;
        Clk = 1'b1;
        #5;
    end
endmodule
