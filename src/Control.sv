module Control (
    Opcode,
    ControlSignal
);

/****************** Decleration ******************/
parameter WIDTH_OPCODE = 4;
parameter WIDTH_CONTROL_SIGNAL = 10;

input [WIDTH_OPCODE - 1:0] Opcode;
output reg [WIDTH_CONTROL_SIGNAL - 1:0] ControlSignal;

/****************** Always function ******************/
always @(Opcode) begin
    case (Opcode)
        4'd0: ControlSignal = 10'b0_0_0_00_0000_0;
        4'd1: ControlSignal = 10'b0_0_1_11_0001_1;
        4'd2: ControlSignal = 10'b1_0_0_00_0000_1;
        4'd3: ControlSignal = 10'b0_0_1_00_0010_1;
        4'd4: ControlSignal = 10'b0_1_0_00_0011_1;
        4'd5: ControlSignal = 10'b0_1_0_00_0000_1;
        4'd6: ControlSignal = 10'b0_0_1_00_0100_1;
        4'd7: ControlSignal = 10'b0_0_1_00_0101_1;
        4'd8: ControlSignal = 10'b0_0_1_00_0110_1;
        4'd9: ControlSignal = 10'b0_0_1_00_0111_1;
        4'd10:ControlSignal = 10'b0_0_1_00_1001_1;
        4'd11:ControlSignal = 10'b0_0_1_00_1000_1;
        default: ControlSignal = 10'b0_0_0_00_0000_0;
    endcase
end
endmodule