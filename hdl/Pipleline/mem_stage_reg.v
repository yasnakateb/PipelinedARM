module mem_stage_reg (
    clk, 
    reset, 
    i_Flush, 
    i_Freeze,
    i_Pc, 
    i_Sig_Write_Back_Enable, 
    i_Sig_Memory_Read_Enable, 
    i_ALU_Result,
    i_Destination,
    i_Data_Memory,
    o_Pc,
    o_Sig_Write_Back_Enable, 
    o_Sig_Memory_Read_Enable, 
    o_ALU_Result,
    o_Destination,
    o_Data_Memory
    );


    parameter DATA_WIDTH = 32;

    input clk; 
    input reset; 
    input i_Flush; 
    input i_Freeze;
    input [DATA_WIDTH - 1:0] i_Pc; 
    input i_Sig_Write_Back_Enable; 
    input i_Sig_Memory_Read_Enable; 
    input [DATA_WIDTH - 1:0] i_ALU_Result;
    input [3:0] i_Destination;
    input [DATA_WIDTH - 1:0] i_Data_Memory;

    output reg [DATA_WIDTH - 1:0] o_Pc;
    output reg o_Sig_Write_Back_Enable; 
    output reg o_Sig_Memory_Read_Enable; 
    output reg [DATA_WIDTH - 1:0] o_ALU_Result;
    output reg [3:0] o_Destination;
    output reg [DATA_WIDTH - 1:0] o_Data_Memory;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            o_Pc <= 32'b0;
            o_Sig_Write_Back_Enable <= 1'b0;
            o_Sig_Memory_Read_Enable <= 1'b0;
            o_ALU_Result <= 32'b0;
            o_Destination <= 4'b0;
            o_Data_Memory <= 32'b0;
        end

        else if (clk && i_Flush) begin
            o_Pc <= 32'b0;
            o_Sig_Write_Back_Enable <= 1'b0;
            o_Sig_Memory_Read_Enable <= 1'b0;
            o_ALU_Result <= 32'b0;
            o_Destination <= 4'b0;
            o_Data_Memory <= 32'b0;
        end

        else if (clk && ~i_Freeze) begin
            o_Pc <= i_Pc;
            o_Sig_Write_Back_Enable <= i_Sig_Write_Back_Enable;
            o_Sig_Memory_Read_Enable <= i_Sig_Memory_Read_Enable;
            o_ALU_Result <= i_ALU_Result;
            o_Destination <= i_Destination;
            o_Data_Memory <= i_Data_Memory;
        end 

        else begin
            o_Pc <= o_Pc;
            o_Sig_Write_Back_Enable <= o_Sig_Write_Back_Enable;
            o_Sig_Memory_Read_Enable <= o_Sig_Memory_Read_Enable;
            o_ALU_Result <= o_ALU_Result;
            o_Destination <= o_Destination;
            o_Data_Memory <= o_Data_Memory;
        end
    end
    
endmodule