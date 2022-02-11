module id_stage (
    clk, 
    reset,
    i_Pc,
    i_Instruction,
    i_Status,
    i_Sig_Write_Back, 
    i_Write_Back_Value,
    i_Write_Back_Destination,
    i_Sig_Hazard,
    o_Pc,
    o_Sig_Memory_Read_Enable, 
    o_Sig_Memory_Write_Enable, 
    o_Write_Back_Enable, 
    i_Status_Write_Enable, 
    o_Sig_Branch_Taken, 
    o_Immediate,
    o_Sigs_Control,
    o_Rm_Value, 
    o_Rn_Value,
    o_Signed_Immediate_24,
    o_Destination,
    o_Shift_Operand,
    o_Two_Src,
    o_Rn, 
    o_Src_2
    );

    parameter DATA_WIDTH = 32;
    
    input clk; 
    input reset;
    input [DATA_WIDTH - 1:0] i_Pc;
    input [DATA_WIDTH - 1:0] i_Instruction;
    input [3:0] i_Status;
    input i_Sig_Write_Back; 
    input [DATA_WIDTH - 1:0] i_Write_Back_Value;
    input [3:0] i_Write_Back_Destination;
    input i_Sig_Hazard;

    output [DATA_WIDTH - 1:0] o_Pc;
    output o_Sig_Memory_Read_Enable; 
    output o_Sig_Memory_Write_Enable; 
    output o_Write_Back_Enable; 
    output i_Status_Write_Enable; 
    output o_Sig_Branch_Taken; 
    output o_Immediate;
    output [3:0] o_Sigs_Control;
    output [DATA_WIDTH - 1:0] o_Rm_Value; 
    output [DATA_WIDTH - 1:0] o_Rn_Value;
    output [23:0] o_Signed_Immediate_24;
    output [3:0] o_Destination;
    output [11:0] o_Shift_Operand;
    output o_Two_Src;
    output [3:0] o_Rn; 
    output [3:0] o_Src_2;

    wire [3:0] w_Condition;
    wire [1:0] w_Mode;
    wire w_Immediate;
    wire [3:0] w_Opcode;
    wire w_Memory_Ins;
    wire[3:0] w_Rd;
    wire[3:0] w_Rm;

    wire w_Sig_Memory_Read_Enable;
    wire w_Sig_Memory_Write_Enable;
    wire w_Write_Back_Enable;
    wire w_Status_Write_Enable;
    wire w_Sig_Branch_Taken;
    wire w_Immediate_CU;
    wire[3:0] w_Sigs_Control;
    wire w_Conditionition_Check_Result;
    wire w_Mux_Selector;
    wire[9:0] w_Mux_Input;

    assign o_Pc = i_Pc; 
    assign o_Two_Src = ~o_Immediate | o_Sig_Memory_Write_Enable;
    assign w_Condition = i_Instruction[DATA_WIDTH - 1:28];
    assign w_Mode = i_Instruction[27:26];
    assign w_Immediate = i_Instruction[25];
    assign w_Opcode = i_Instruction[24:21];
    assign s = i_Instruction[20];
    assign o_Rn = i_Instruction[19:16];
    assign w_Rd = i_Instruction[15:12];
    assign o_Destination = w_Rd;
    assign w_Rm = i_Instruction[3:0];
    assign o_Shift_Operand = i_Instruction[11:0];
    assign o_Signed_Immediate_24 = i_Instruction[23:0];

    control_unit Control_Unit(
        .i_Opcode(w_Opcode),
        .i_Memory_Ins(w_Memory_Ins),
        .i_Immediate(w_Immediate),
        .i_Mode(w_Mode),
        .o_Sigs_Control(w_Sigs_Control),
        .o_Sig_Memory_Write_Enable(w_Sig_Memory_Write_Enable),
        .o_Sig_Memory_Read_Enable(w_Sig_Memory_Read_Enable),
        .o_Sig_Write_Back_Enable(w_Write_Back_Enable),
        .o_Sig_Status_Write_Enable(w_Status_Write_Enable),
        .o_Sig_Branch_Taken(w_Sig_Branch_Taken),
        .o_Immediate(w_Immediate_CU)
    );

    condition_check Condition_Check(
        .i_Condition(w_Condition),
        .i_Status(i_Status), 
        .o_Result(w_Conditionition_Check_Result)
    );

    assign w_Mux_Selector = ~w_Conditionition_Check_Result | i_Sig_Hazard; 
    assign w_Mux_Input = {w_Sig_Memory_Read_Enable, w_Sig_Memory_Write_Enable, w_Write_Back_Enable, i_Status_Write_Enable, w_Sig_Branch_Taken, w_Immediate, w_Sigs_Control};
    assign {o_Sig_Memory_Read_Enable, o_Sig_Memory_Write_Enable, o_Write_Back_Enable, i_Status_Write_Enable, o_Sig_Branch_Taken, o_Immediate, o_Sigs_Control} = w_Mux_Selector ?  10'b0 : w_Mux_Input;
    assign o_Src_2 = o_Sig_Memory_Write_Enable ? w_Rd : w_Rm ;

    register_file Register_File(
        .clk(clk), 
        .reset(reset), 
        .i_SRC_1(o_Rn), 
        .i_SRC_2(o_Src_2), 
        .i_Destination_Write_Back(i_Write_Back_Destination),
        .i_Write_Back_Data(i_Write_Back_Value),
        .i_Sig_Write_Back_Enable(i_Sig_Write_Back), 
        .o_A(o_Rn_Value), 
        .o_B(o_Rm_Value)
    );
   
endmodule
