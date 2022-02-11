module instruction_memory(
    clk,
    reset,
    i_Address, 
    o_Instruction
    );


    parameter DATA_WIDTH = 32;

    input clk;
    input reset;
    input [DATA_WIDTH - 1:0] i_Address;

    output reg [DATA_WIDTH - 1:0] o_Instruction;
    
    reg[7:0] memory [0:1023];

    always @(*) begin

        if (reset) begin
            o_Instruction <= 32'b0;
            {memory[0], memory[1], memory[2], memory[3]} = 32'b1110_00_1_1101_0_0000_0000_000000010100; //MOV R0 ,#20 //R0 = 20
        end

        else begin
            o_Instruction <= {memory[i_Address], memory[i_Address+1], memory[i_Address+2], memory[i_Address+3]};
        end
    end
    
endmodule