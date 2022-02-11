module hazard_detection_unit(
    clk, 
    reset,
    i_Sig_Memory_Write_Back_Enable,
    i_Memory_Destination,
    i_Sig_Exe_Write_Back_Enable,
    i_Exe_Destination,
    i_Src_1,
    i_Src_2,
    i_Two_Src,
    i_Sig_Forward_Enable, 
    i_Sig_Exe_Memory_Read_Enable,
    o_Sig_Hazard_Detected
    );


    input clk; 
    input reset;
    input i_Sig_Memory_Write_Back_Enable;
    input [3:0] i_Memory_Destination;
    input i_Sig_Exe_Write_Back_Enable;
    input [3:0] i_Exe_Destination;
    input [3:0] i_Src_1;
    input [3:0] i_Src_2;
    input i_Two_Src;
    input i_Sig_Forward_Enable; 
    input i_Sig_Exe_Memory_Read_Enable;

    output o_Sig_Hazard_Detected;

    wire w_Hazard_With_Forward;
    wire w_Hazard_Without_Forward;

    assign w_Hazard_Without_Forward = (i_Src_1 == i_Exe_Destination & i_Sig_Exe_Write_Back_Enable == 1'b1) | 
                                (i_Src_1 == i_Memory_Destination & i_Sig_Memory_Write_Back_Enable == 1'b1) | 
                                (i_Src_2 == i_Exe_Destination & i_Sig_Exe_Write_Back_Enable == 1'b1 & i_Two_Src == 1'b1) | 
                                (i_Src_2 == i_Memory_Destination & i_Sig_Memory_Write_Back_Enable == 1'b1 & i_Two_Src == 1'b1) ? 1'b1 : 1'b0;

    assign w_Hazard_With_Forward = (i_Src_1 == i_Exe_Destination & i_Sig_Exe_Write_Back_Enable == 1'b1) | 
                            (i_Src_2 == i_Exe_Destination & i_Sig_Exe_Write_Back_Enable == 1'b1 & i_Two_Src == 1'b1) ? 1'b1 : 1'b0; 

    assign o_Sig_Hazard_Detected = i_Sig_Forward_Enable ? w_Hazard_With_Forward & i_Sig_Exe_Memory_Read_Enable :  
                                    w_Hazard_Without_Forward;
    

endmodule