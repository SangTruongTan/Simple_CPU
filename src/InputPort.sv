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
reg [WIDTH_DATA_LENGTH - 1:0] TOutput;
output [WIDTH_DATA_LENGTH - 1:0] Output;

/****************** Always function ******************/
always @ (posedge Clk, negedge Rst) begin
    if (Rst == 1'b0) begin
        TOutput <= 8'b0;
    end else if(Write == 1'b1) begin
        TOutput <= Input;
    end
end

assign Output = TOutput;

endmodule