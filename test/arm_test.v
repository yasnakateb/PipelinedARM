module arm_test();
    reg clk = 0;
    reg rst = 0;

    arm Cpu(
        clk,
        rst, 
        1'b1 
    );

    integer i;

    initial begin
        $dumpfile("arm_test.vcd");
        $dumpvars(0,arm_test);

        for (i = 0; i < 8; i = i + 1)
      		$dumpvars(0,arm_test.Cpu.ID_Stage.Register_File.r_registers[i]);

        // for (i = 0; i < 1024; i = i + 1)
        	// $dumpvars(0,arm_test.Cpu.MEM_Stage.Data_Memory.memory[i]);

        #15 
            rst = 1;
        #2 
            rst = 0;
    end

    always begin
        clk = #10 !clk;
    end

    
endmodule