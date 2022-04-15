module Control_tb;

/****************** Decleration ******************/
parameter WIDTH_OPCODE = 4;
parameter WIDTH_CONTROL_SIGNAL = 10;

reg [WIDTH_OPCODE - 1:0] Opcode;
wire [WIDTH_CONTROL_SIGNAL - 1:0] ControlSignal;
logic [WIDTH_CONTROL_SIGNAL - 1:0] EControlSignal;
logic [14: 0] testVector[0 : 1000];
logic clk;
logic [31: 0]i;

/****************** Assign Module ******************/
Control contrl (.Opcode(Opcode),
                .ControlSignal(ControlSignal));

/****************** Initialize ******************/
    initial begin
        $readmemb("C:/Users/sangt/OneDrive/Project/Job/RMIT/Lab2/CPU/tb/Control_tb_vector.txt", testVector);
        i = 0;
        clk = 1'b0;
    end

/****************** Always function ******************/
    always @ (negedge clk) begin
        if(EControlSignal != ControlSignal) begin
            $display("[time =%0t]Wrong Value: Opcode:%h", $time, Opcode);
        end
        {Opcode, EControlSignal} = testVector[i];
        i = i + 1;
    end
    always begin
        clk = !clk;
        #20;
    end
endmodule