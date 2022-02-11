`define MOV_ALU 4'b0001
`define MVN_ALU 4'b1001
`define ADD_ALU 4'b0010
`define ADC_ALU 4'b0011
`define SUB_ALU 4'b0100
`define SBC_ALU 4'b0101
`define AND_ALU 4'b0110
`define ORR_ALU 4'b0111
`define EOR_ALU 4'b1000
`define CMP_ALU 4'b0100
`define TST_ALU 4'b0110
`define LDR_ALU 4'b0010
`define STR_ALU 4'b0010

`define MOV 4'b1101
`define MVN 4'b1111
`define ADD 4'b0100
`define ADC 4'b0101
`define SUB 4'b0010
`define SBC 4'b0110
`define AND 4'b0000
`define ORR 4'b1100
`define EOR 4'b0001
`define CMP 4'b1010
`define TST 4'b1000
`define LDR 4'b0100
`define STR 4'b0100

`define ARITHMATIC_INS_TYPE  2'b00
`define MEM_INS_TYPE  2'b01
`define BRANCH_INS_TYPE  2'b10
`define CO_PROC_INS_TYPE  2'b11


module control_unit (
    i_Opcode,
    i_Memory_Ins,
    i_Immediate,
    i_Mode,
    o_Sigs_Control,
    o_Sig_Memory_Write_Enable,
    o_Sig_Memory_Read_Enable,
    o_Sig_Write_Back_Enable,
    o_Sig_Status_Write_Enable,
    o_Sig_Branch_Taken,
    o_Immediate
    );


    input [3:0] i_Opcode;
    input i_Memory_Ins;
    input i_Immediate;
    input [1:0] i_Mode;
    
    output reg[3:0] o_Sigs_Control;
    output reg o_Sig_Memory_Write_Enable;
    output reg o_Sig_Memory_Read_Enable;
    output reg o_Sig_Write_Back_Enable;
    output reg o_Sig_Status_Write_Enable;
    output reg o_Sig_Branch_Taken;
    output reg o_Immediate;

    always @(i_Opcode, i_Mode, i_Memory_Ins) begin
       
        o_Sig_Status_Write_Enable = i_Memory_Ins;
        o_Immediate = i_Immediate;
        o_Sig_Memory_Read_Enable = 1'b0;
        o_Sig_Memory_Write_Enable = 1'b0;
        o_Sig_Write_Back_Enable = 1'b0;
        o_Sig_Branch_Taken = 1'b0;
        o_Sigs_Control = 4'b000;
        
        case (i_Mode)
            `ARITHMATIC_INS_TYPE: begin
                case (i_Opcode)
                    `MOV: begin
                        o_Sig_Write_Back_Enable = 1'b1;
                        o_Sigs_Control = `MOV_ALU;
                    end 
                    `MVN: begin
                        o_Sig_Write_Back_Enable = 1'b1;
                        o_Sigs_Control = `MVN_ALU;
                    end
                    `ADD: begin
                        o_Sig_Write_Back_Enable = 1'b1;
                        o_Sigs_Control = `ADD_ALU;
                    end
                    `ADC: begin
                        o_Sig_Write_Back_Enable = 1'b1;
                        o_Sigs_Control = `ADC_ALU;
                    end
                    `SUB: begin
                        o_Sig_Write_Back_Enable = 1'b1;
                        o_Sigs_Control = `SUB_ALU;
                    end
                    `SBC: begin
                        o_Sig_Write_Back_Enable = 1'b1;
                        o_Sigs_Control = `SBC_ALU;
                    end
                    `AND: begin
                        o_Sig_Write_Back_Enable = 1'b1;
                        o_Sigs_Control = `AND_ALU;
                    end
                    `ORR: begin
                        o_Sig_Write_Back_Enable = 1'b1;
                        o_Sigs_Control = `ORR_ALU;
                    end
                    `EOR: begin
                        o_Sig_Write_Back_Enable = 1'b1;
                        o_Sigs_Control = `EOR_ALU;
                    end
                    `CMP: begin
                        o_Sigs_Control = `CMP_ALU;
                    end
                    `TST: begin
                        o_Sigs_Control = `TST_ALU;
                    end 
                endcase
            end
            `MEM_INS_TYPE: begin
                case (i_Memory_Ins)
                    1'b1: begin
                        // LDR
                        o_Sig_Memory_Read_Enable = 1'b1;
                        o_Sigs_Control = `LDR_ALU;
                        o_Sig_Write_Back_Enable = 1'b1;
                    end
                    1'b0: begin
                        // STR
                        o_Sig_Memory_Write_Enable = 1'b1;
                        o_Sigs_Control = `STR_ALU;
                    end
                endcase
            end
            `BRANCH_INS_TYPE: begin
                o_Sig_Branch_Taken = 1'b1;
            end
        endcase

    end
    
endmodule