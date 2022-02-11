module id_stage_reg (
    clk, 
    reset, 
    i_Flush, 
    i_Freeze,
    i_Pc, 
    i_Sig_Memory_Read_Enable, 
    i_Sig_Memory_Write_Enable, 
    i_Sig_Write_Back_Enable, 
    i_Sig_Status_Write_Enable, 
    i_Branch_Taken, 
    i_Immediate,
    i_Sigs_Control,
    i_Value_Rm, 
    i_Value_Rn,
    i_Signed_Immediate_24,
    i_Destination,
    i_Shift_Operand,
    i_Carry_In,
    i_Src_1, 
    i_Src_2,
    o_Pc,
    o_Sig_Memory_Read_Enable, 
    o_Sig_Memory_Write_Enable, 
    o_Sig_Write_Back_Enable, 
    o_Sig_Status_Write_Enable, 
    o_Branch_Taken, 
    o_Immediate,
    o_Sigs_Control,
    o_Value_Rm, 
    o_Value_Rn,
    o_Signed_Immediate_24,
    o_Destination,
    o_Shift_Operand,
    o_Carry,
    o_Src_1, 
    o_Src_2
    );


    parameter DATA_WIDTH = 32;
    
    input clk; 
    input reset; 
    input i_Flush; 
    input i_Freeze;
    input [DATA_WIDTH - 1:0] i_Pc; 
    input i_Sig_Memory_Read_Enable; 
    input i_Sig_Memory_Write_Enable; 
    input i_Sig_Write_Back_Enable; 
    input i_Sig_Status_Write_Enable; 
    input i_Branch_Taken; 
    input i_Immediate;
    input [3:0] i_Sigs_Control;
    input [DATA_WIDTH - 1:0] i_Value_Rm; 
    input [DATA_WIDTH - 1:0] i_Value_Rn;
    input [23:0] i_Signed_Immediate_24;
    input [3:0] i_Destination;
    input [11:0] i_Shift_Operand;
    input i_Carry_In;
    input [3:0] i_Src_1; 
    input [3:0] i_Src_2;

    output reg [DATA_WIDTH - 1:0] o_Pc;
    output reg o_Sig_Memory_Read_Enable; 
    output reg o_Sig_Memory_Write_Enable; 
    output reg o_Sig_Write_Back_Enable; 
    output reg o_Sig_Status_Write_Enable; 
    output reg o_Branch_Taken; 
    output reg o_Immediate;
    output reg [3:0] o_Sigs_Control;
    output reg [DATA_WIDTH - 1:0] o_Value_Rm; 
    output reg [DATA_WIDTH - 1:0] o_Value_Rn;
    output reg [23:0] o_Signed_Immediate_24;
    output reg [3:0] o_Destination;
    output reg [11:0] o_Shift_Operand;
    output reg o_Carry;
    output reg [3:0] o_Src_1; 
    output reg [3:0] o_Src_2;

    always @(posedge clk, posedge reset) begin
         
        if (reset) begin
            o_Pc <= 32'b0;
            o_Sig_Memory_Read_Enable <= 1'b0;
            o_Sig_Memory_Write_Enable <= 1'b0;
            o_Sig_Write_Back_Enable <= 1'b0;
            o_Sig_Status_Write_Enable <= 1'b0;
            o_Branch_Taken <= 1'b0;
            o_Immediate <= 1'b0;
            o_Sigs_Control <= 4'b0;
            o_Value_Rm <= 32'b0;
            o_Value_Rn <= 32'b0;
            o_Signed_Immediate_24 <= 24'b0;
            o_Destination <= 4'b0; 
            o_Shift_Operand <= 12'b0;
            o_Carry <= 1'b0;
            o_Src_1 <= 4'b0;
            o_Src_2 <= 4'b0;
        end

        else if (clk && i_Flush) begin
            o_Pc <= 32'b0;
            o_Sig_Memory_Read_Enable <= 1'b0;
            o_Sig_Memory_Write_Enable <= 1'b0;
            o_Sig_Write_Back_Enable <= 1'b0;
            o_Sig_Status_Write_Enable <= 1'b0;
            o_Branch_Taken <= 1'b0;
            o_Immediate <= 1'b0;
            o_Sigs_Control <= 4'b0;
            o_Value_Rm <= 32'b0;
            o_Value_Rn <= 32'b0;
            o_Signed_Immediate_24 <= 24'b0;
            o_Destination <= 4'b0; 
            o_Shift_Operand <= 12'b0;
            o_Carry <= 1'b0;
            o_Src_1 <= 4'b0;
            o_Src_2 <= 4'b0;
        end
        
        else if (clk && ~i_Freeze) begin
            o_Pc <= i_Pc;
            o_Sig_Memory_Read_Enable <= i_Sig_Memory_Read_Enable;
            o_Sig_Memory_Write_Enable <= i_Sig_Memory_Write_Enable;
            o_Sig_Write_Back_Enable <= i_Sig_Write_Back_Enable;
            o_Sig_Status_Write_Enable <= i_Sig_Status_Write_Enable;
            o_Branch_Taken <= i_Branch_Taken;
            o_Immediate <= i_Immediate;
            o_Sigs_Control <= i_Sigs_Control;
            o_Value_Rm <= i_Value_Rm;
            o_Value_Rn <= i_Value_Rn;
            o_Signed_Immediate_24 <= i_Signed_Immediate_24;
            o_Destination <= i_Destination; 
            o_Shift_Operand <= i_Shift_Operand;
            o_Carry <= i_Carry_In;
            o_Src_1 <= i_Src_1;
            o_Src_2 <= i_Src_2;
        end

        else begin
            o_Pc <= o_Pc;
            o_Sig_Memory_Read_Enable <= o_Sig_Memory_Read_Enable;
            o_Sig_Memory_Write_Enable <= o_Sig_Memory_Write_Enable;
            o_Sig_Write_Back_Enable <= o_Sig_Write_Back_Enable;
            o_Sig_Status_Write_Enable <= o_Sig_Status_Write_Enable;
            o_Branch_Taken <= o_Branch_Taken;
            o_Immediate <= o_Immediate;
            o_Sigs_Control <= o_Sigs_Control;
            o_Value_Rm <= o_Value_Rm;
            o_Value_Rn <= o_Value_Rn;
            o_Signed_Immediate_24 <= o_Signed_Immediate_24;
            o_Destination <= o_Destination;
            o_Shift_Operand <= o_Shift_Operand;
            o_Carry <= o_Carry;
            o_Src_1 <= o_Src_1;
            o_Src_2 <= o_Src_2;
        end
    end
    
endmodule