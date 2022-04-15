module OutputPort_tb;

/****************** Decleration ******************/
parameter WIDTH_DATA_LENGTH = 8;
parameter WIDTH_OUTPUT_LENGTH = 7;

reg [WIDTH_DATA_LENGTH - 1: 0] Input;
reg Write;
reg Clk;
reg Rst;

wire [WIDTH_OUTPUT_LENGTH - 1:0] OutputHundreds;
wire [WIDTH_OUTPUT_LENGTH - 1:0] OutputDozens;
wire [WIDTH_OUTPUT_LENGTH - 1:0] OutputUnits;

/****************** Assign Module ******************/
OutputPort out (.Input(Input),
                   .Write(Write),
                   .Clk(Clk),
                   .Rst(Rst),
                   .OutputHundreds(OutputHundreds),
                   .OutputDozens(OutputDozens),
                   .OutputUnits(OutputUnits));

/****************** Initialize ******************/
initial begin
    #0 Clk = 1'b0;
    Write = 1'b0;
    Rst = 1'b1;
    Input = 8'd123;
    #50 Write = 1'b1;
    #50 Rst = 1'b0;
end

always begin
    Clk = !Clk;
    #20;
end

endmodule