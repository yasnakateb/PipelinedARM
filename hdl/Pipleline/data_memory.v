module data_memory (
    clk, 
    reset, 
    i_Sig_Memory_Write_Enable, 
    i_Sig_Memory_Read_Enable, 
    i_Address, 
    i_Write_Data,
    o_Read_Data
    );


    parameter DATA_WIDTH = 32;

    input clk;
    input reset;
    input i_Sig_Memory_Write_Enable;
    input i_Sig_Memory_Read_Enable;
    input [DATA_WIDTH - 1:0] i_Address;
    input [DATA_WIDTH - 1:0] i_Write_Data;

    output [DATA_WIDTH - 1:0] o_Read_Data;

    reg[7:0] memory [0:255];

    wire [DATA_WIDTH - 1:0] w_Start_Address_0;
    wire [DATA_WIDTH - 1:0] w_Start_Address_1;
    wire [DATA_WIDTH - 1:0] w_Start_Address_2;
    wire [DATA_WIDTH - 1:0] w_Start_Address_3;
    
    assign w_Start_Address_0 = {i_Address[DATA_WIDTH - 1:2], 2'b00} - 32'd1024;
    assign w_Start_Address_1 = {w_Start_Address_0[DATA_WIDTH - 1:1], 1'b1};
    assign w_Start_Address_2 = {w_Start_Address_0[DATA_WIDTH - 1:2], 2'b10};
    assign w_Start_Address_3 = {w_Start_Address_0[DATA_WIDTH - 1:2], 2'b11};

    assign o_Read_Data = (i_Sig_Memory_Read_Enable == 1'b1 ? {memory[w_Start_Address_0], memory[w_Start_Address_1], memory[w_Start_Address_2], memory[w_Start_Address_3]} : 32'b0);

    always@(posedge clk) begin
        if(i_Sig_Memory_Write_Enable == 1'b1) begin
            memory[w_Start_Address_3] <= i_Write_Data[7:0];
            memory[w_Start_Address_2] <= i_Write_Data[15:8];
            memory[w_Start_Address_1] <= i_Write_Data[23:16];
            memory[w_Start_Address_0] <= i_Write_Data[DATA_WIDTH - 1:24];
        end
    end
    
endmodule