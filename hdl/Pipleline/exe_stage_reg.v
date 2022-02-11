module exe_stage_reg (
    clk, 
    reset, 
    i_Flush, 
    i_Freeze,
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
    o_Sig_Memory_Write_Enable,
    o_ALU_Result,
    o_Value_Rm,
    o_Destination
    );


    parameter DATA_WIDTH = 32;

    input clk; 
    input reset; 
    input i_Flush; 
    input i_Freeze;
    input [DATA_WIDTH - 1:0] i_Pc; 
    input i_Sig_Write_Back_Enable; 
    input i_Sig_Memory_Read_Enable; 
    input i_Sig_Memory_Write_Enable;
    input [DATA_WIDTH - 1:0] i_ALU_Result;
    input [DATA_WIDTH - 1:0] i_Value_Rm;
    input [3:0] i_Destination;

    output reg [DATA_WIDTH - 1:0] o_Pc;
    output reg o_Sig_Write_Back_Enable; 
    output reg o_Sig_Memory_Read_Enable; 
    output reg o_Sig_Memory_Write_Enable;
    output reg [DATA_WIDTH - 1:0] o_ALU_Result;
    output reg [DATA_WIDTH - 1:0] o_Value_Rm;
    output reg [3:0] o_Destination;
    
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            o_Pc <= 32'b0;
            o_Sig_Write_Back_Enable <= 1'b0;
            o_Sig_Memory_Read_Enable <= 1'b0;
            o_Sig_Memory_Write_Enable <= 1'b0;
            o_ALU_Result <= 32'b0;
            o_Value_Rm <= 32'b0;
            o_Destination <= 4'b0;
        end

        else if (clk && i_Flush) begin
            o_Pc <= 32'b0;
            o_Sig_Write_Back_Enable <= 1'b0;
            o_Sig_Memory_Read_Enable <= 1'b0;
            o_Sig_Memory_Write_Enable <= 1'b0;
            o_ALU_Result <= 32'b0;
            o_Value_Rm <= 32'b0;
            o_Destination <= 4'b0;
        end

        else if (clk && ~i_Freeze) begin
            o_Pc <= i_Pc;
            o_Sig_Write_Back_Enable <= i_Sig_Write_Back_Enable;
            o_Sig_Memory_Read_Enable <= i_Sig_Memory_Read_Enable;
            o_Sig_Memory_Write_Enable <= i_Sig_Memory_Write_Enable;
            o_ALU_Result <= i_ALU_Result;
            o_Value_Rm <= i_Value_Rm;
            o_Destination <= i_Destination;
        end 

        else begin
            o_Pc <= o_Pc;
            o_Sig_Write_Back_Enable <= o_Sig_Write_Back_Enable;
            o_Sig_Memory_Read_Enable <= o_Sig_Memory_Read_Enable;
            o_Sig_Memory_Write_Enable <= o_Sig_Memory_Write_Enable;
            o_ALU_Result <= o_ALU_Result;
            o_Value_Rm <= o_Value_Rm;
            o_Destination <= o_Destination;
        end
    end

endmodule