module Mux4 (
sel_port,
port_in_0,
port_in_1,
port_in_2,
port_in_3,
port_out
);

/****************** Decleration ******************/
parameter WIDTH_DATA_LENGTH = 8;
input [1:0] sel_port;
input   [WIDTH_DATA_LENGTH - 1:0] port_in_0;
input   [WIDTH_DATA_LENGTH - 1:0] port_in_1;
input   [WIDTH_DATA_LENGTH - 1:0] port_in_2;
input   [WIDTH_DATA_LENGTH - 1:0] port_in_3;
output reg [WIDTH_DATA_LENGTH - 1:0] port_out;

/****************** Always function ******************/
always @(*) begin
    case (sel_port)
      2'd0: port_out <= port_in_0;
      2'd1: port_out <= port_in_1;
      2'd2: port_out <= port_in_2;
      2'd3: port_out <= port_in_3;
    endcase
end
endmodule