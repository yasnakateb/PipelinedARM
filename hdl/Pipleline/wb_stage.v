module wb_stage (
    clk, 
    reset,
    i_Pc,
    i_Sig_Write_Back_Enable, 
    i_Sig_Memory_Read_Enable, 
    i_ALU_Result,
    i_Destination,
    i_Data_Memory,
    o_Pc,
    o_Sig_Write_Back_Enable, 
    o_Write_Back_Value,
    o_Destination
    );


    parameter DATA_WIDTH = 32;

    input clk; 
    input reset;
    input[DATA_WIDTH - 1:0] i_Pc;
    input i_Sig_Write_Back_Enable; 
    input i_Sig_Memory_Read_Enable; 
    input [DATA_WIDTH - 1:0] i_ALU_Result;
    input [3:0] i_Destination;
    input [DATA_WIDTH - 1:0] i_Data_Memory;

    output[DATA_WIDTH - 1:0] o_Pc;
    output o_Sig_Write_Back_Enable; 
    output [DATA_WIDTH - 1:0] o_Write_Back_Value;
    output [3:0] o_Destination;

    assign o_Pc = i_Pc;
    assign o_Sig_Write_Back_Enable = i_Sig_Write_Back_Enable;
    assign o_Destination = i_Destination;

    assign o_Write_Back_Value = i_Sig_Memory_Read_Enable ? i_Data_Memory : i_ALU_Result;

endmodule