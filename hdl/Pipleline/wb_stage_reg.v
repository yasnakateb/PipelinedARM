module wb_stage_reg (
    clk, 
    reset, 
    i_Flush, 
    i_Freeze,
    i_Pc, 
    o_Pc
    );


    parameter DATA_WIDTH = 32;

    input clk;
    input reset;
    input i_Flush;
    input i_Freeze;
    input [DATA_WIDTH - 1:0] i_Pc;

    output reg [DATA_WIDTH - 1:0] o_Pc;

    always @(posedge clk, posedge reset) begin

        if (reset) begin
            o_Pc <= 32'b0;
        end

        else if (clk && i_Flush) begin
            o_Pc <= 32'b0;
        end

        else if (clk && ~i_Freeze) begin
            o_Pc <= i_Pc;
        end 

        else begin
            o_Pc <= o_Pc;
        end
    end

endmodule