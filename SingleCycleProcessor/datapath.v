module datapath (

input clk, reset,
input memtoreg, pcsrc,
input alusrc, regdst,
input regwrite, jump,
input [2:0] alucontrol,
output zero,
output [31:0] pc,
input [31:0] instr,
output [31:0] aluout, writedata,
input [31:0] readdata);
/*****/

//assign wires out to direct the data
wire [4:0] write_reg;
wire [31:0] pc_next, pc_nextbr, pc_plus4, pc_branch;
wire [31:0] signimm, signimmsh;
wire [31:0] srca, srcb;
wire [31:0] result;

//This framework is to implement the NEXT PC command logic units 
mux2 #(32) pcbrmux(pc_plus4, pc_branch, pcsrc, pc_nextbr);
mux2 #(32) pcmux(pc_nextbr, {pc_plus4[31:28], instr[27:0], 2'b00},jump, pc_next);
flopr #(32) pcreg(clk, reset, pc_next, pc);
adder addpc1 (pc, 32'b100, pc_plus4);
sl2 shiftleft(signimm, signimmsh);
adder addpc2(pc_plus4, signimmsh, pc_branch);

//This framework is to implement the register file logic units 
regfile rf(clk, regwrite, instr[25:21],instr[20:16], write_reg, result, srca, writedata);
mux2 #(5) wrmux(instr[20:16], instr[15:11],regdst, write_reg);
mux2 #(32) resmux(aluout, readdata, memtoreg, result);
signext se(instr[15:0], signimm);

//This framework is to implement the ALU logic logic units 
mux2 #(32) srcbmux(writedata, signimm, alusrc, srcb);
alu alu(srca, srcb, alucontrol, aluout, zero);

//End the datapath FINALLY 
endmodule