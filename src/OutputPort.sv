module OutputPort (
    Input,
    Write,
    Clk,
    Rst,
    OutputHundreds,
    OutputDozens,
    OutputUnits
);

/****************** Decleration ******************/
parameter WIDTH_DATA_LENGTH = 8;
parameter WIDTH_OUTPUT_LENGTH = 7;

input [WIDTH_DATA_LENGTH - 1: 0] Input;
input Write;
input Clk;
input Rst;
reg [WIDTH_OUTPUT_LENGTH - 1:0] TOutputHundreds;
reg [WIDTH_OUTPUT_LENGTH - 1:0] TOutputDozens;
reg [WIDTH_OUTPUT_LENGTH - 1:0] TOutputUnits;
reg [7:0] Hundreds;
reg [7:0] Dozens;
reg [7:0] Units;
output [WIDTH_OUTPUT_LENGTH - 1:0] OutputHundreds;
output [WIDTH_OUTPUT_LENGTH - 1:0] OutputDozens;
output [WIDTH_OUTPUT_LENGTH - 1:0] OutputUnits;

/****************** Always function ******************/
always @ (posedge Clk, negedge Rst) begin
    if (Rst == 1'b0) begin
        TOutputHundreds <= 7'b000_0001;
        TOutputDozens <= 7'b000_0001;
        TOutputUnits <= 7'b000_0001;
    end else if(Write == 1'b1) begin
        Hundreds = Input/100;
        Dozens = Input/10%10;
        Units = Input%10;
        case(Hundreds)
            8'd0: TOutputHundreds = 7'b000_0001;
            8'd1: TOutputHundreds = 7'b100_1111;
            8'd2: TOutputHundreds = 7'b001_0010;
            8'd3: TOutputHundreds = 7'b000_0110;
            8'd4: TOutputHundreds = 7'b100_1100;
            8'd5: TOutputHundreds = 7'b010_0100;
            8'd6: TOutputHundreds = 7'b010_0000;
            8'd7: TOutputHundreds = 7'b000_1111;
            8'd8: TOutputHundreds = 7'b000_0000;
            8'd9: TOutputHundreds = 7'b000_1000;
            default: TOutputHundreds = 7'b000_0001;
        endcase
        case(Dozens)
            8'd0: TOutputDozens = 7'b000_0001;
            8'd1: TOutputDozens = 7'b100_1111;
            8'd2: TOutputDozens = 7'b001_0010;
            8'd3: TOutputDozens = 7'b000_0110;
            8'd4: TOutputDozens = 7'b100_1100;
            8'd5: TOutputDozens = 7'b010_0100;
            8'd6: TOutputDozens = 7'b010_0000;
            8'd7: TOutputDozens = 7'b000_1111;
            8'd8: TOutputDozens = 7'b000_0000;
            8'd9: TOutputDozens = 7'b000_1000;
            default: TOutputDozens = 7'b000_0001;
        endcase
        case(Units)
            8'd0: TOutputUnits = 7'b000_0001;
            8'd1: TOutputUnits = 7'b100_1111;
            8'd2: TOutputUnits = 7'b001_0010;
            8'd3: TOutputUnits = 7'b000_0110;
            8'd4: TOutputUnits = 7'b100_1100;
            8'd5: TOutputUnits = 7'b010_0100;
            8'd6: TOutputUnits = 7'b010_0000;
            8'd7: TOutputUnits = 7'b000_1111;
            8'd8: TOutputUnits = 7'b000_0000;
            8'd9: TOutputUnits = 7'b000_1000;
            default: TOutputUnits = 7'b000_0001;
        endcase
    end
end

assign OutputHundreds = TOutputHundreds;
assign OutputDozens = TOutputDozens;
assign OutputUnits = TOutputUnits;

endmodule