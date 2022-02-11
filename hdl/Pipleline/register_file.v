module register_file (
    clk, 
    reset, 
    i_SRC_1, 
    i_SRC_2, 
    i_Destination_Write_Back,
    i_Write_Back_Data,
    i_Sig_Write_Back_Enable, 
    o_A, 
    o_B
    );

    parameter DATA_WIDTH = 32;

    input clk; 
    input reset; 
    input [3:0] i_SRC_1; 
    input [3:0]i_SRC_2; 
    input [3:0] i_Destination_Write_Back;
    input [DATA_WIDTH - 1:0] i_Write_Back_Data;

    input i_Sig_Write_Back_Enable; 
    output [DATA_WIDTH - 1:0] o_A; 
    output [DATA_WIDTH - 1:0] o_B;


    reg[DATA_WIDTH - 1:0] r_registers [0:14];

    assign o_A = r_registers[i_SRC_1];
    assign o_B = r_registers[i_SRC_2];
    
    integer i = 0;

    always @(negedge clk, posedge reset) begin
        if(reset) begin
            for(i = 0; i < 15; i = i + 1) begin
                r_registers[i] <= i;
            end
        end

        else if(i_Sig_Write_Back_Enable) begin
            r_registers[i_Destination_Write_Back] <= i_Write_Back_Data;
        end
         
        else begin
            for(i = 0; i < 15; i = i + 1) begin
                r_registers[i] <= r_registers[i];
            end
        end 
    end

endmodule 