module arm (
    clk,
    reset,
    i_Sig_Forwarding_Enable
    );

    input clk;
    input reset;
    input i_Sig_Forwarding_Enable;

    wire w_Flush;
    wire w_Freeze;

    wire w_ID_Branch_Taken_Out;
    wire [31:0] w_EXE_Branch_Address_In;
    wire hazard_detected;

    wire[31:0] if_pc_in;
    wire[31:0] if_instruction_in;
    wire[31:0] if_pc_out;
    wire[31:0] if_instruction_out;

    wire[31:0] id_pc_in;
    wire[31:0] id_pc_out;
    wire id_mem_r_en_in; 
    wire id_mem_w_en_in;
    wire id_wb_en_in;
    wire id_status_w_en_in;
    wire id_branch_taken_in;
    wire id_imm_in;
    wire[3:0] id_exec_cmd_in;
    wire[31:0] id_val_rm_in;
    wire[31:0] id_val_rn_in;
    wire[23:0] id_signed_immed_24_in;
    wire[3:0] id_dest_in; 
    wire[11:0] id_shift_operand_in;
    wire id_mem_r_en_out;
    wire id_mem_w_en_out;
    wire id_wb_en_out;
    wire id_status_w_en_out;
    wire id_imm_out;
    wire[3:0] id_exec_cmd_out;
    wire[31:0] id_val_rm_out;
    wire[31:0] id_val_rn_out;
    wire[23:0] id_signed_immed_24_out;
    wire[3:0] id_dest_out;
    wire[11:0] id_shift_operand_out;
    wire id_carry_out;
    wire [3:0] status_out;
    wire wb_wb_en;
    wire [31:0] wb_value;
    wire [3:0] wb_dest;
    wire hazard;
    wire two_src;
    wire [3:0] src_1;
    wire [3:0] src_2;
    wire [3:0] id_src_1_out; 
    wire [3:0] id_src_2_out;

    wire [3:0] exe_dest_out;
    wire exe_mem_w_en_out;
    wire exe_wb_en_out;

    wire[31:0] exe_pc_in;
    wire[31:0] exe_pc_out;
    wire [3:0] exe_alu_status_in;
    wire exe_wb_en_in;
    wire exe_mem_r_en_in;
    wire exe_mem_w_en_in;
    wire [31:0] exe_alu_res_in;
    wire [31:0] exe_val_rm_in;
    wire [3:0] exe_dest_in;
    wire exe_mem_r_en_out;
    wire [31:0] exe_alu_res_out;
    wire [31:0] exe_val_rm_out;
    wire [1:0] fwd_sel_src_1;
    wire [1:0] fwd_sel_src_2;

    wire[31:0] mem_pc_in;
    wire[31:0] mem_pc_out;
    wire mem_wb_en_in;
    wire mem_r_en_in;
    wire [31:0] mem_alu_res_in;
    wire [3:0] mem_dest_in;
    wire [31:0] mem_data_mem_in;
    wire mem_wb_en_out;
    wire mem_r_en_out;
    wire [31:0] mem_alu_res_out;
    wire [3:0] mem_dest_out;
    wire [31:0] mem_data_mem_out;

    wire[31:0] wb_pc_in;

    assign w_Flush       = 1'b0;
    assign w_Freeze      = 1'b0;
    
    // ################################# Instruction Fetch Stage: ###################################
    if_stage IF_Stage (
        .clk(clk), 
        .reset(reset), 
        .i_Freeze(hazard_detected), 
        .i_Branch_Taken(w_ID_Branch_Taken_Out), 
        .i_Branch_Address(w_EXE_Branch_Address_In),
        .o_Pc(if_pc_in), 
        .o_Instruction(if_instruction_in)
    );

    if_stage_reg IF_Stage_Reg (
        .clk(clk), 
        .reset(reset), 
        .i_Flush(w_ID_Branch_Taken_Out), 
        .i_Freeze(hazard_detected),
        .i_Pc(if_pc_in), 
        .i_Instruction(if_instruction_in),
        .o_Pc(if_pc_out), 
        .o_Instruction(if_instruction_out)
    );
    // ################################## Instruction Decode Stage #################################
    id_stage ID_Stage (
        .clk(clk), 
        .reset(reset),
        .i_Pc(if_pc_out),
        .i_Instruction(if_instruction_out),
        .i_Status(status_out),
        .i_Sig_Write_Back(wb_wb_en), 
        .i_Write_Back_Value(wb_value),
        .i_Write_Back_Destination(wb_dest),
        .i_Sig_Hazard(hazard_detected),
        .o_Pc(id_pc_in),
        .o_Sig_Memory_Read_Enable(id_mem_r_en_in), 
        .o_Sig_Memory_Write_Enable(id_mem_w_en_in), 
        .o_Write_Back_Enable(id_wb_en_in), 
        .i_Status_Write_Enable(id_status_w_en_in), 
        .o_Sig_Branch_Taken(id_branch_taken_in), 
        .o_Immediate(id_imm_in),
        .o_Sigs_Control(id_exec_cmd_in),
        .o_Rm_Value(id_val_rm_in), 
        .o_Rn_Value(id_val_rn_in),
        .o_Signed_Immediate_24(id_signed_immed_24_in),
        .o_Destination(id_dest_in),
        .o_Shift_Operand(id_shift_operand_in),
        .o_Two_Src(two_src),
        .o_Rn(src_1), 
        .o_Src_2(src_2)
    );

    id_stage_reg ID_Stage_Reg(
        .clk(clk), 
        .reset(reset), 
        .i_Flush(w_ID_Branch_Taken_Out), 
        .i_Freeze(w_Freeze),
        .i_Pc(id_pc_in), 
        .i_Sig_Memory_Read_Enable( id_mem_r_en_in), 
        .i_Sig_Memory_Write_Enable(id_mem_w_en_in), 
        .i_Sig_Write_Back_Enable(id_wb_en_in), 
        .i_Sig_Status_Write_Enable(id_status_w_en_in), 
        .i_Branch_Taken(id_branch_taken_in), 
        .i_Immediate(id_imm_in),
        .i_Sigs_Control(id_exec_cmd_in),
        .i_Value_Rm(id_val_rm_in), 
        .i_Value_Rn(id_val_rn_in),
        .i_Signed_Immediate_24(id_signed_immed_24_in),
        .i_Destination(id_dest_in),
        .i_Shift_Operand(id_shift_operand_in),
        .i_Carry_In(status_out[2]),
        .i_Src_1(src_1), 
        .i_Src_2(src_2),
        .o_Pc(id_pc_out),
        .o_Sig_Memory_Read_Enable(id_mem_r_en_out), 
        .o_Sig_Memory_Write_Enable(id_mem_w_en_out), 
        .o_Sig_Write_Back_Enable(id_wb_en_out), 
        .o_Sig_Status_Write_Enable(id_status_w_en_out), 
        .o_Branch_Taken(w_ID_Branch_Taken_Out), 
        .o_Immediate(id_imm_out),
        .o_Sigs_Control(id_exec_cmd_out),
        .o_Value_Rm(id_val_rm_out), 
        .o_Value_Rn(id_val_rn_out),
        .o_Signed_Immediate_24(id_signed_immed_24_out),
        .o_Destination(id_dest_out),
        .o_Shift_Operand(id_shift_operand_out),
        .o_Carry(id_carry_out),
        .o_Src_1(id_src_1_out), 
        .o_Src_2(id_src_2_out)
    );
    // ################################### Hazard ################################ 
    hazard_detection_unit Hazard_Detection_Unit(
        .clk(clk), 
        .reset(reset),
        .i_Sig_Memory_Write_Back_Enable(exe_wb_en_out),
        .i_Memory_Destination(exe_dest_out),
        .i_Sig_Exe_Write_Back_Enable(id_wb_en_out),
        .i_Exe_Destination(id_dest_out),
        .i_Src_1(src_1),
        .i_Src_2(src_2),
        .i_Two_Src(two_src),
        .i_Sig_Forward_Enable(i_Sig_Forwarding_Enable), 
        .i_Sig_Exe_Memory_Read_Enable(id_mem_r_en_out),
        .o_Sig_Hazard_Detected(hazard_detected)
    );
    // ################################### Executaion Stage ################################
    exe_stage EXE_Stage (
        .clk(clk), 
        .reset(reset),
        .i_Pc(id_pc_out),
        .i_Sig_Memory_Read_Enable(id_mem_r_en_out), 
        .i_Sig_Memory_Write_Enable(id_mem_w_en_out), 
        .i_Sig_Write_Back_Enable(id_wb_en_out), 
        .i_Immediate(id_imm_out),
        .i_Carry_In(id_carry_out),
        .i_Shift_Operand(id_shift_operand_out),
        .i_Sigs_Control(id_exec_cmd_out),
        .i_Val_Rm(id_val_rm_out), 
        .i_Val_Rn(id_val_rn_out),
        .i_Signed_Immediate_24(id_signed_immed_24_out),
        .i_Destination(id_dest_out),
        .i_Sel_Src_1(fwd_sel_src_1),
        .i_Sel_Src_2(fwd_sel_src_2),
        .i_Memory_Write_Back_Value(exe_alu_res_out),
        .i_Write_Back_Write_Back_Value(wb_value),
        .o_Branch_Address(w_EXE_Branch_Address_In),
        .o_ALU_Status(exe_alu_status_in),
        .o_Pc(exe_pc_in),
        .o_Sig_Write_Back_Enable(exe_wb_en_in), 
        .o_Sig_Memory_Read_Enable(exe_mem_r_en_in), 
        .o_Sig_Memory_Write_Enable(exe_mem_w_en_in),
        .o_ALU_Result(exe_alu_res_in),
        .o_Val_Rm(exe_val_rm_in),
        .o_Destination(exe_dest_in)
    );

    exe_stage_reg EXE_Stage_Reg (
        .clk(clk), 
        .reset(reset), 
        .i_Flush(w_Flush), 
        .i_Freeze(w_Freeze),
        .i_Pc(exe_pc_in), 
        .i_Sig_Write_Back_Enable(exe_wb_en_in),
        .i_Sig_Memory_Read_Enable(exe_mem_r_en_in), 
        .i_Sig_Memory_Write_Enable(exe_mem_w_en_in),
        .i_ALU_Result(exe_alu_res_in),
        .i_Value_Rm(exe_val_rm_in),
        .i_Destination(exe_dest_in),
        .o_Pc(exe_pc_out),
        .o_Sig_Write_Back_Enable(exe_wb_en_out), 
        .o_Sig_Memory_Read_Enable(exe_mem_r_en_out), 
        .o_Sig_Memory_Write_Enable(exe_mem_w_en_out),
        .o_ALU_Result(exe_alu_res_out),
        .o_Value_Rm(exe_val_rm_out),
        .o_Destination(exe_dest_out)
    );
    // ################################# Status Register ############################################
    status_register Status_Register (
        .clk(clk), 
        .reset(reset),
        .i_Memory_Ins(id_status_w_en_out),
        .i_Status(exe_alu_status_in),
        .o_Status(status_out)
    );
    // ################################# Memory Stage ############################################
    mem_stage MEM_Stage (
        .clk(clk), 
        .reset(reset), 
        .i_Pc(exe_pc_out), 
        .i_Sig_Write_Back_Enable(exe_wb_en_out), 
        .i_Sig_Memory_Read_Enable(exe_mem_r_en_out), 
        .i_Sig_Memory_Write_Enable(exe_mem_w_en_out),
        .i_ALU_Result(exe_alu_res_out),
        .i_Value_Rm(exe_val_rm_out),
        .i_Destination(exe_dest_out),
        .o_Pc(mem_pc_in),
        .o_Sig_Write_Back_Enable(mem_wb_en_in),
        .o_Sig_Memory_Read_Enable(mem_r_en_in),
        .o_Memory_Result(mem_alu_res_in),
        .o_Destination(mem_dest_in),
        .o_Data_Memory(mem_data_mem_in)
    );

    mem_stage_reg MEM_Stage_Reg (
        .clk(clk), 
        .reset(reset), 
        .i_Flush(w_Flush), 
        .i_Freeze(w_Freeze),
        .i_Pc(mem_pc_in), 
        .i_Sig_Write_Back_Enable(mem_wb_en_in), 
        .i_Sig_Memory_Read_Enable(mem_r_en_in), 
        .i_ALU_Result(mem_alu_res_in),
        .i_Destination(mem_dest_in),
        .i_Data_Memory(mem_data_mem_in),
        .o_Pc(mem_pc_out),
        .o_Sig_Write_Back_Enable(mem_wb_en_out), 
        .o_Sig_Memory_Read_Enable(mem_r_en_out),
        .o_ALU_Result(mem_alu_res_out),
        .o_Destination(mem_dest_out),
        .o_Data_Memory(mem_data_mem_out)
    );
    // ################################### Write Block Stage #######################################
    wb_stage WB_Stage(
        .clk(clk), 
        .reset(reset),
        .i_Pc(mem_pc_out),
        .i_Sig_Write_Back_Enable(mem_wb_en_out), 
        .i_Sig_Memory_Read_Enable(mem_r_en_out), 
        .i_ALU_Result(mem_alu_res_out),
        .i_Destination(mem_dest_out),
        .i_Data_Memory(mem_data_mem_out),
        .o_Pc(wb_pc_in),
        .o_Sig_Write_Back_Enable(wb_wb_en), 
        .o_Write_Back_Value(wb_value),
        .o_Destination(wb_dest)
    );
    // ################################### Forwarding Unit #######################################
    forwarding_unit Forwarding_Unit (
        .i_Forwarding_Enable(i_Sig_Forwarding_Enable),
        .i_Src_1(id_src_1_out), 
        .i_Src_2(id_src_2_out),
        .i_Write_Back_Destination(wb_dest), 
        .i_Memory_Destination(mem_dest_in),
        .i_Sig_Write_Back_Write_Back_Enable(wb_wb_en), 
        .i_Sig_Memory_Write_Back_Enable(mem_wb_en_in),
        .o_Sel_Src_1(fwd_sel_src_1), 
        .o_Sel_Src_2(fwd_sel_src_2)
    );

endmodule
