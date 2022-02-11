`define LSL 2'b00
`define LSR 2'b01
`define ASR 2'b10
`define ROR 2'b11

module value_two_generator(
    i_Rm,
    i_Shift_Operand,
    i_Immediate, 
    i_Sig_Memory_Instruction,
    o_Result
    );

    input [31:0] i_Rm;
    input [11:0] i_Shift_Operand;
    input i_Immediate; 
    input i_Sig_Memory_Instruction;
    output [31:0] o_Result;


    
    reg [31:0] r_Immediate_32_bit;
    reg [31:0] r_i_Rm_Rotate;

    integer i = 0;

    wire [4:0] w_Shift_Immediate;
    wire [3:0] w_Rotate_Immediate;
    wire [1:0] w_Shift;
    wire [7:0] w_Immediate_8;

    assign w_Shift_Immediate = i_Shift_Operand[11:7];
    assign w_Rotate_Immediate = i_Shift_Operand[11:8];
    assign w_Shift = i_Shift_Operand[6:5];
    assign w_Immediate_8 = i_Shift_Operand[7:0]; 
 
    assign o_Result = i_Sig_Memory_Instruction == 1'b1  ? { {20{i_Shift_Operand[11]}}, i_Shift_Operand} : 
                    i_Immediate == 1'b1           ? r_Immediate_32_bit : 
                    w_Shift == `LSL               ? i_Rm <<  {1'b0, w_Shift_Immediate} :
                    w_Shift == `LSR               ? i_Rm >>  {1'b0, w_Shift_Immediate} :
                    w_Shift == `ASR               ? i_Rm >>> {1'b0, w_Shift_Immediate} :
                    r_i_Rm_Rotate; // w_Shift == `ROR 

    always@(*) begin

        r_Immediate_32_bit = {24'b0, w_Immediate_8};

        for(i = 0; i < w_Rotate_Immediate; i = i+1) begin
            r_Immediate_32_bit = {r_Immediate_32_bit[1:0], r_Immediate_32_bit[31:2]};
        end    

        r_i_Rm_Rotate = i_Rm;

        for(i = 0; i <= i_Shift_Operand[11:7]; i = i+1) begin
            r_i_Rm_Rotate = {r_i_Rm_Rotate[0], r_i_Rm_Rotate[31:0]};
        end
    end
endmodule