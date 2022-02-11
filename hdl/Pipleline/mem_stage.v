module mem_stage (
    clk, 
    reset,
    i_Pc,
    i_Sig_Write_Back_Enable, 
    i_Sig_Memory_Read_Enable, 
    i_Sig_Memory_Write_Enable, 
    i_ALU_Result,
    i_Value_Rm,
    i_Destination,
    o_Pc,
    o_Sig_Write_Back_Enable, 
    o_Sig_Memory_Read_Enable, 
    o_Memory_Result,
    o_Destination,
    o_Data_Memory
    );


    parameter DATA_WIDTH = 32;

    input clk; 
    input reset;
    input[DATA_WIDTH - 1:0] i_Pc;
    input i_Sig_Write_Back_Enable; 
    input i_Sig_Memory_Read_Enable; 
    input i_Sig_Memory_Write_Enable; 
    input [DATA_WIDTH - 1:0] i_ALU_Result;
    input [DATA_WIDTH - 1:0] i_Value_Rm;
    input [3:0] i_Destination;

    output[DATA_WIDTH - 1:0] o_Pc;
    output o_Sig_Write_Back_Enable; 
    output o_Sig_Memory_Read_Enable; 
    output [DATA_WIDTH - 1:0] o_Memory_Result;
    output [3:0] o_Destination;
    output [DATA_WIDTH - 1:0] o_Data_Memory;

    assign o_Pc = i_Pc;
    assign o_Memory_Result = i_ALU_Result;
    assign o_Sig_Write_Back_Enable = i_Sig_Write_Back_Enable;
    assign o_Sig_Memory_Read_Enable = i_Sig_Memory_Read_Enable;
    assign i_Sig_Memory_Write_Enable_out = i_Sig_Memory_Write_Enable;
    assign o_Destination = i_Destination;

    data_memory Data_Memory (
        .clk(clk),
        .reset(reset),
        .i_Sig_Memory_Write_Enable(i_Sig_Memory_Write_Enable),
        .i_Sig_Memory_Read_Enable(i_Sig_Memory_Read_Enable),
        .i_Address(i_ALU_Result),
        .i_Write_Data(i_Value_Rm),
        .o_Read_Data(o_Data_Memory)
    );

endmodule
