`define FORWARD_FROM_ID_SEL 2'b00
`define FORWARD_FROM_WB_SEL 2'b01
`define FORWARD_FROM_MEM_SEL 2'b10

module forwarding_unit (
    i_Forwarding_Enable,
    i_Src_1,
    i_Src_2,
    i_Write_Back_Destination, 
    i_Memory_Destination,
    i_Sig_Write_Back_Write_Back_Enable, 
    i_Sig_Memory_Write_Back_Enable,
    o_Sel_Src_1, 
    o_Sel_Src_2
    );


    input i_Forwarding_Enable;
    input [3:0] i_Src_1;
    input [3:0] i_Src_2;
    input [3:0] i_Write_Back_Destination; 
    input [3:0] i_Memory_Destination;
    input i_Sig_Write_Back_Write_Back_Enable;
    input  i_Sig_Memory_Write_Back_Enable;

    output reg [1:0] o_Sel_Src_1;
    output reg [1:0] o_Sel_Src_2;
    

    always @(*) begin
        o_Sel_Src_1 = `FORWARD_FROM_ID_SEL;
        o_Sel_Src_2 = `FORWARD_FROM_ID_SEL;

        if(i_Forwarding_Enable == 1'b1) begin

            if(i_Sig_Memory_Write_Back_Enable == 1'b1) begin

                if(i_Memory_Destination == i_Src_1) begin
                    o_Sel_Src_1 = `FORWARD_FROM_MEM_SEL;
                end

                if(i_Memory_Destination == i_Src_2) begin
                    o_Sel_Src_2 = `FORWARD_FROM_MEM_SEL; 
                end

            end

            if(i_Sig_Write_Back_Write_Back_Enable == 1'b1) begin

                if(i_Write_Back_Destination == i_Src_1) begin
                    o_Sel_Src_1 = `FORWARD_FROM_WB_SEL;
                end

                if(i_Write_Back_Destination == i_Src_2) begin
                    o_Sel_Src_2 = `FORWARD_FROM_WB_SEL; 
                end 
            end

        end

    end
    
endmodule