`define EQ 4'b0000
`define NE 4'b0001
`define CS_HS 4'b0010
`define CC_LO 4'b0011
`define MI 4'b0100
`define PL 4'b0101
`define VS 4'b0110
`define VC 4'b0111
`define HI 4'b1000
`define LS 4'b1001
`define GE 4'b1010
`define LT 4'b1011
`define GT 4'b1100
`define LE 4'b1101
`define AL 4'b1110

module condition_check (
    i_Condition,
    i_Status,
    o_Result
    );


    input [3:0] i_Condition;
    input [3:0] i_Status;

    output reg o_Result;

    wire w_Z;
    wire w_C;
    wire w_N;
    wire w_V;
    
    assign {w_Z, w_C, w_N, w_V} = i_Status;

    always@(i_Condition, i_Status) begin
        o_Result = 1'b0;
        
        case(i_Condition)
            `EQ: begin
                if(w_Z == 1'b1)
                    o_Result = 1'b1;
            end

            `NE:begin
                if(w_Z == 1'b0)
                    o_Result = 1'b1;
            end

            `CS_HS:begin
                if(w_C == 1'b1)
                    o_Result = 1'b1;
            end

            `CC_LO:begin
                if(w_C == 1'b0)
                    o_Result = 1'b1;
            end
            
            `MI: begin
                if(w_N == 1'b1)
                    o_Result = 1'b1;
            end

            `PL:begin
                if(w_N == 1'b0)
                    o_Result = 1'b1;
            end

            `VS:begin
                if(w_V == 1'b1)
                    o_Result = 1'b1;
            end

            `VC:begin
                if(w_V == 1'b0)
                    o_Result = 1'b1;
            end

            `HI:begin
                if(w_C == 1'b1 & w_Z == 1'b0)
                    o_Result = 1'b1;
            end

            `LS:begin
                if(w_C == 1'b0 & w_Z == 1'b1)
                    o_Result = 1'b1;
            end
            
            `GE: begin
                if(w_N == w_V)
                    o_Result = 1'b1;
            end

            `LT:begin
                if(w_N != w_V)
                    o_Result = 1'b1;
            end

            `GT:begin
                if(w_Z == 1'b0 & w_N == w_V)
                    o_Result = 1'b1;
            end

            `LE:begin
                if(w_Z == 1'b1& w_N != w_V)
                    o_Result = 1'b1;
            end

            `AL:begin
                o_Result = 1'b1;
            end
        endcase
    end

endmodule