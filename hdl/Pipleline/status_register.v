module status_register (
    clk, 
    reset,
    i_Memory_Ins,
    i_Status,
    o_Status
    );

    input clk; 
    input reset;
    input i_Memory_Ins;
    input [3:0] i_Status;

    output reg [3:0] o_Status;
    
    always@(negedge clk, posedge reset)  begin
        if (reset) 
            o_Status <= 0;

        else if (i_Memory_Ins) 
            o_Status <= i_Status;

        else 
            o_Status <= o_Status;
    end
    
endmodule