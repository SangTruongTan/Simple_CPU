module InputPort (
    Input,
    Write,
    Clk,
    Rst,
    Output
);

/****************** Decleration ******************/
parameter WIDTH_DATA_LENGTH = 8;
input [WIDTH_DATA_LENGTH - 1: 0] Input;
input Write;
input Clk;
input Rst;
output reg [WIDTH_DATA_LENGTH - 1:0] Output;

/****************** Always function ******************/
always @ (posedge Clk) begin
    if(Write == 1'b1 && Rst != 1'b0) begin
        Output = Input;
    end
end

always @(negedge Rst) begin
    Output = 8'b0;
end

endmodule