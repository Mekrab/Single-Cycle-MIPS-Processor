module top (input clk, reset,output [31:0] writedata, dataadr,output memwrite);

//Declare wires for path of control
wire [31:0] pc, instr, readdata;

// Start the MIPS processor and memory paths 
mips mips(clk, reset, pc, instr, memwrite, dataadr,writedata, readdata);

//goto read RAM 
imem imem(pc[7:2], instr);

//goto write RAM
dmem dmem(clk, memwrite, dataadr, writedata,readdata);

endmodule