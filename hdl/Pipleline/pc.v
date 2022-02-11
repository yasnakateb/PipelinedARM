module pc (
    clk, 
    reset,
    i_Load, 
    i_PC,
    o_PC
    );

    parameter DATA_WIDTH = 32;
    
    input clk;
    input reset;
    input i_Load;
    input [DATA_WIDTH - 1:0] i_PC;

    output reg [DATA_WIDTH - 1:0] o_PC;

    always @(posedge clk, posedge reset) begin
        if (reset) 
            o_PC <= 32'b0;

        else if (clk && i_Load) 
            o_PC <= i_PC;

        else 
            o_PC <= o_PC;
    end

endmodule