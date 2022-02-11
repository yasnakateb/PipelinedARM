module if_stage (
    clk, 
    reset, 
    i_Freeze, 
    i_Branch_Taken, 
    i_Branch_Address,
    o_Pc, 
    o_Instruction
    );

    parameter DATA_WIDTH = 32;
    
    input clk;
    input reset;
    input i_Freeze;
    input i_Branch_Taken; 
    input [DATA_WIDTH - 1:0] i_Branch_Address;

    output [DATA_WIDTH - 1:0] o_Pc;
    output [DATA_WIDTH - 1:0] o_Instruction;

    wire [DATA_WIDTH - 1:0] w_Mux_In;
    wire [DATA_WIDTH - 1:0] w_Mux_Out;

    assign w_Mux_Out = i_Branch_Taken ? i_Branch_Address : w_Mux_In;

    wire [DATA_WIDTH - 1:0] w_Pc_In;
    wire [DATA_WIDTH - 1:0] w_Pc_Out;

    pc Pc(clk, reset, ~i_Freeze, w_Pc_In, w_Pc_Out);

    assign w_Pc_In = w_Mux_Out;

    wire[DATA_WIDTH - 1:0] w_Pc_Added;

    assign w_Pc_Added = w_Pc_Out + 4;
    assign w_Mux_In = w_Pc_Added;

    instruction_memory o_Instruction_Memory(clk, reset, w_Pc_Out, o_Instruction);
    assign o_Pc = w_Pc_Added;

endmodule