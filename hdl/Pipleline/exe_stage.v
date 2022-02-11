`define FORWARD_FROM_ID_SEL 2'b00
`define FORWARD_FROM_WB_SEL 2'b01
`define FORWARD_FROM_MEM_SEL 2'b10

module exe_stage (
    clk, 
    reset,
    i_Pc,
    i_Sig_Memory_Read_Enable, 
    i_Sig_Memory_Write_Enable, 
    i_Sig_Write_Back_Enable, 
    i_Immediate,
    i_Carry_In,
    i_Shift_Operand,
    i_Sigs_Control,
    i_Val_Rm, 
    i_Val_Rn,
    i_Signed_Immediate_24,
    i_Destination,
    i_Sel_Src_1, 
    i_Sel_Src_2,
    i_Memory_Write_Back_Value, 
    i_Write_Back_Write_Back_Value,
    o_Branch_Address,
    o_ALU_Status,
    o_Pc,
    o_Sig_Write_Back_Enable, 
    o_Sig_Memory_Read_Enable, 
    o_Sig_Memory_Write_Enable,
    o_ALU_Result,
    o_Val_Rm,
    o_Destination
    );


    parameter DATA_WIDTH = 32;

    input clk;
    input reset;
    input[DATA_WIDTH - 1:0] i_Pc;
    input i_Sig_Memory_Read_Enable; 
    input i_Sig_Memory_Write_Enable; 
    input i_Sig_Write_Back_Enable; 
    input i_Immediate;
    input i_Carry_In;
    input [11:0] i_Shift_Operand;
    input [3:0] i_Sigs_Control;
    input [DATA_WIDTH - 1:0] i_Val_Rm; 
    input [DATA_WIDTH - 1:0] i_Val_Rn;
    input [23:0] i_Signed_Immediate_24;
    input [3:0] i_Destination;
    input [1:0] i_Sel_Src_1;
    input [1:0] i_Sel_Src_2;
    input [DATA_WIDTH - 1:0] i_Memory_Write_Back_Value; 
    input [DATA_WIDTH - 1:0] i_Write_Back_Write_Back_Value;
    
    output[DATA_WIDTH - 1:0] o_Branch_Address;
    output [3:0] o_ALU_Status;
    output[DATA_WIDTH - 1:0] o_Pc;
    output o_Sig_Write_Back_Enable; 
    output o_Sig_Memory_Read_Enable; 
    output o_Sig_Memory_Write_Enable;
    output [DATA_WIDTH - 1:0] o_ALU_Result;
    output [DATA_WIDTH - 1:0] o_Val_Rm;
    output [3:0] o_Destination;

    assign o_Pc = i_Pc;
    assign o_Sig_Memory_Read_Enable = i_Sig_Memory_Read_Enable;
    assign o_Sig_Memory_Write_Enable = i_Sig_Memory_Write_Enable;
    assign o_Sig_Write_Back_Enable = i_Sig_Write_Back_Enable;
    assign o_Destination = i_Destination;

    
    wire w_Memory_Ins;
    assign w_Memory_Ins = i_Sig_Memory_Read_Enable | i_Sig_Memory_Write_Enable;

    
    assign o_Val_Rm = i_Sel_Src_2 == `FORWARD_FROM_ID_SEL ? i_Val_Rm :
                        i_Sel_Src_2 == `FORWARD_FROM_MEM_SEL ? i_Memory_Write_Back_Value :
                        i_Sel_Src_2 == `FORWARD_FROM_WB_SEL ? i_Write_Back_Write_Back_Value :
                        i_Val_Rm;

    wire [DATA_WIDTH - 1:0] w_Value_1;
    wire [DATA_WIDTH - 1:0] w_Value_2;
    
    value_two_generator Val_Two_Generator(
        .i_Rm(o_Val_Rm),
        .i_Shift_Operand(i_Shift_Operand),
        .i_Immediate(i_Immediate),
        .i_Sig_Memory_Instruction(w_Memory_Ins),
        .o_Result(w_Value_2)
    );

    assign w_Value_1 = i_Sel_Src_1 == `FORWARD_FROM_ID_SEL ? i_Val_Rn :
                        i_Sel_Src_1 == `FORWARD_FROM_MEM_SEL ? i_Memory_Write_Back_Value :
                        i_Sel_Src_1 == `FORWARD_FROM_WB_SEL ? i_Write_Back_Write_Back_Value :
                        i_Val_Rn;


    alu Alu(
        .i_A(w_Value_1), 
        .i_B(w_Value_2),
        .i_Sigs_Control(i_Sigs_Control),
        .i_Sig_Carry_In(i_Carry_In),
        .o_ALU_Result(o_ALU_Result),
        .o_Status(o_ALU_Status)
    );
    
    assign o_Branch_Address = i_Pc + {{6{i_Signed_Immediate_24[23]}}, i_Signed_Immediate_24, 2'b0};

endmodule
