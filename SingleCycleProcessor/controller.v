module   controller  ( 
      input   [5:0] op, funct, 
      input   zero, 
      output  memtoreg, memwrite, 
      output  pcsrc, alusrc, 
      output  regdst, regwrite, 
      output  jump, 
      output  [2:0] alucontrol ); 
//Branch 
wire [1:0] aluop;
wire branch;

//Go into controller units

//maindec deals with what MIPS path we are taking based of op logic 
maindec md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop);
//aludec controls alu commnads based off op logic and regular logic
aludec ad (funct, aluop, alucontrol);

//and branch 
assign pcsrc = branch & zero;
 
endmodule