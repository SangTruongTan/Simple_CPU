module Mux4_tb;

/****************** Decleration ******************/
parameter WIDTH_DATA_LENGTH = 8;
logic [1:0] sel_port;
logic   [WIDTH_DATA_LENGTH - 1:0] port_in_0;
logic   [WIDTH_DATA_LENGTH - 1:0] port_in_1;
logic   [WIDTH_DATA_LENGTH - 1:0] port_in_2;
logic   [WIDTH_DATA_LENGTH - 1:0] port_in_3;

wire [WIDTH_DATA_LENGTH - 1:0] port_out;
logic [WIDTH_DATA_LENGTH - 1:0] Eport_out;
logic [42: 0] testVector[0 : 1000];
logic clk;
logic [31: 0]i;

/****************** Assign Module ******************/
Mux4 MUX (.sel_port(sel_port),
          .port_in_0(port_in_0),
          .port_in_1(port_in_1),
          .port_in_2(port_in_2),
          .port_in_3(port_in_3),
          .port_out(port_out));

/****************** Initialize ******************/
    initial begin
        $readmemh("C:/Users/sangt/OneDrive/Project/Job/RMIT/Lab2/CPU/tb/Mux4_tb_vector.txt", testVector);
        i = 0;
        clk = 1'b0;
    end

/****************** Always function ******************/
always @ (posedge clk) begin
        {sel_port, port_in_0, port_in_1, port_in_2, port_in_3, Eport_out} = testVector[i];
    end

    always @ (negedge clk) begin
        if(Eport_out != port_out) begin
            $display("[time =%0t]Wrong Value: Sel:%h", $time, sel_port);
        end
        i = i + 1;
    end
    always begin
        clk = !clk;
        #20;
    end
endmodule
