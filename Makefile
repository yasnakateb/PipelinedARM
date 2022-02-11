#TOOL INPUT
SRC = hdl/Pipleline/*.v hdl/arm.v
TESTBENCH = test/arm_test.v
TBOUTPUT = arm_test.vcd

COMPILER = iverilog
SIMULATOR = vvp
VIEWER = Scansion

#TOOL OPTIONS
COFLAGS = -v -o
SFLAGS = -v

#TOOL OUTPUT
COUTPUT = compiler.out         

###############################################################################
simulate: $(COUTPUT)
	$(SIMULATOR) $(SFLAGS) $(COUTPUT) 

display: 
	open -a $(VIEWER) $(TBOUTPUT) 

$(COUTPUT): $(TESTBENCH) $(SRC)
	$(COMPILER) $(COFLAGS) $(COUTPUT) $(TESTBENCH) $(SRC) 

clean:
	rm *.vcd
	rm *.out
