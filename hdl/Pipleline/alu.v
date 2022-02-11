module alu (
    i_A, 
    i_B,
    i_Sigs_Control,
    i_Sig_Carry_In,
    o_ALU_Result,
    o_Status
    );


    parameter DATA_WIDTH = 32;

    input [DATA_WIDTH - 1:0] i_A; 
    input [DATA_WIDTH - 1:0] i_B;
    input [3:0] i_Sigs_Control;
    input i_Sig_Carry_In;

    output reg[DATA_WIDTH - 1:0] o_ALU_Result;
    output [3:0] o_Status;

    reg r_C;
    reg r_V;
    wire w_Z;
    wire w_N;

    always @(*) begin

        r_C = 1'b0;
        r_V = 1'b0;

        case (i_Sigs_Control)
            4'b0001:
                o_ALU_Result = i_B;
            4'b1001:
                o_ALU_Result = ~i_B;
            4'b0010:
                {r_C, o_ALU_Result} = i_A + i_B;
            4'b0011:
                {r_C, o_ALU_Result} = i_A + i_B + i_Sig_Carry_In;
            4'b0100:
                {r_C, o_ALU_Result} = i_A - i_B;
            4'b0101:
                {r_C, o_ALU_Result} = i_A - i_B - i_Sig_Carry_In;
            4'b0110:
                o_ALU_Result = i_A & i_B;
            4'b0111:
                o_ALU_Result = i_A | i_B;
            4'b1000:
                o_ALU_Result = i_A ^ i_B;
            4'b0100:
                o_ALU_Result = i_A - i_B;
            4'b0110:
                o_ALU_Result = i_A & i_B;
            4'b0010:
                o_ALU_Result = i_A + i_B;
            4'b0010:
                o_ALU_Result = i_A + i_B;
        endcase
        
        if(i_Sigs_Control == 4'b0010 || i_Sigs_Control == 4'b0011)
            r_V = (i_A[DATA_WIDTH - 1] == i_B[DATA_WIDTH - 1]) & (i_A[DATA_WIDTH - 1] == ~o_ALU_Result[DATA_WIDTH - 1]);

        else if (i_Sigs_Control == 4'b0100 || i_Sigs_Control == 4'b0101)
            r_V = (i_A[DATA_WIDTH - 1] == ~i_B[DATA_WIDTH - 1]) & (i_A[DATA_WIDTH - 1] == ~o_ALU_Result[DATA_WIDTH - 1]);
    end

    assign w_N = o_ALU_Result[DATA_WIDTH - 1];
    assign w_Z = o_ALU_Result == 32'b0 ? 1'b1 : 1'b0;

    assign o_Status = {w_Z, r_C, w_N, r_V};
    
endmodule