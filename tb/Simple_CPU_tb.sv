module Simple_CPU_tb;

/****************** Decleration ******************/
parameter WIDTH_OPCODE = 4;
parameter WIDTH_SWITCH_LENGTH = 6;
parameter WIDTH_OUTPUT_LENGTH = 7;

reg [WIDTH_OPCODE - 1:0] OpcodeInput;
reg [WIDTH_SWITCH_LENGTH - 1: 0] ExternalSwitch;
reg Execute;
reg Rstn;

logic [7:0] LED;
logic [7:0] ELED;
logic [WIDTH_OUTPUT_LENGTH - 1:0] OutputHundreds;
logic [WIDTH_OUTPUT_LENGTH - 1:0] OutputDozens;
logic [WIDTH_OUTPUT_LENGTH - 1:0] OutputUnits;

logic [20: 0] testVector[0 : 1000];
logic clk;
logic [31: 0]i;

/****************** Assign Module ******************/
Simple_CPU cpu (.OpcodeInput(OpcodeInput),
                .ExternalSwitch(ExternalSwitch),
                .Execute(Execute),
                .Rstn(Rstn),
                .LED(LED),
                .OutputHundreds(OutputHundreds),
                .OutputDozens(OutputDozens),
                .OutputUnits(OutputUnits));

/****************** Initialize ******************/
    initial begin
        $readmemb("C:/Users/sangt/OneDrive/Project/Job/RMIT/Lab2/CPU/tb/Simple_CPU_tb_vector.txt", testVector);
        i = 0;
        clk = 1'b0;
    end

/****************** Always function ******************/
    always @ (negedge clk) begin
        if(ELED != LED) begin
            $display("[time =%0t]Wrong Value: Opcode:%h", $time, OpcodeInput);
        end
        {OpcodeInput, ExternalSwitch, Execute, Rstn, ELED} = testVector[i];
        i = i + 1;
    end
    always begin
        clk = !clk;
        #20;
    end
endmodule