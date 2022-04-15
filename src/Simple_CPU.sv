module Simple_CPU(
    OpcodeInput,
    ExternalSwitch,
    Execute,
    Rstn,
    OutputHundreds,
    OutputDozens,
    OutputUnits,
    LED
);

/****************** Decleration ******************/
parameter WIDTH_OPCODE = 4;
parameter WIDTH_CONTROL_SIGNAL = 10;
parameter WIDTH_SWITCH_LENGTH = 6;
parameter WIDTH_DATA_LENGTH = 8;
parameter WIDTH_OUTPUT_LENGTH = 7;

input [WIDTH_OPCODE - 1:0] OpcodeInput;
input [WIDTH_SWITCH_LENGTH - 1: 0] ExternalSwitch;
input Execute;
input Rstn;

output reg [7:0] LED;
output [WIDTH_OUTPUT_LENGTH - 1:0] OutputHundreds;
output [WIDTH_OUTPUT_LENGTH - 1:0] OutputDozens;
output [WIDTH_OUTPUT_LENGTH - 1:0] OutputUnits;

reg CF;
reg ZF;

wire write_o;
wire write_b;
wire write_a;
wire [3:0] F;
wire [1:0] B_Sel;
wire WriteCZ;
wire [WIDTH_DATA_LENGTH - 1:0] C_Bus;
wire [WIDTH_DATA_LENGTH - 1:0] B_Out;
wire [WIDTH_DATA_LENGTH - 1:0] B_Bus;
wire [WIDTH_DATA_LENGTH - 1:0] A_Bus;
wire [WIDTH_CONTROL_SIGNAL - 1:0] ControlSignal;
wire Clk;

/****************** Assign Module ******************/
assign Clk = !Execute;
assign LED = C_Bus;

assign {write_o, write_b, write_a, B_Sel, F, WriteCZ} = ControlSignal;

Control ctrl (.Opcode(OpcodeInput),
              .ControlSignal(ControlSignal));

Mux4 mux (.sel_port(B_Sel),
          .port_in_0(B_Out),
          .port_in_1(8'b0),
          .port_in_2(8'b0),
          .port_in_3({2'b0, ExternalSwitch}),
          .port_out(B_Bus));

ALU alu (.DataA(A_Bus),
         .DataB(B_Bus),
         .ALUSel(F),
         .WriteCZ(WriteCZ),
         .DataOut(C_Bus),
         .CF(CF),
         .ZF(ZF));

InputPort PortA (.Input(C_Bus),
                 .Write(write_a),
                 .Clk(Clk),
                 .Rst(Rstn),
                 .Output(A_Bus));

InputPort PortB (.Input(C_Bus),
                 .Write(write_b),
                 .Clk(Clk),
                 .Rst(Rstn),
                 .Output(B_Out));

OutputPort out (.Input(C_Bus),
                   .Write(write_o),
                   .Clk(Clk),
                   .Rst(Rstn),
                   .OutputHundreds(OutputHundreds),
                   .OutputDozens(OutputDozens),
                   .OutputUnits(OutputUnits));
endmodule