module  maindec (                
      input   [5:0]  op,                
      output  memtoreg, memwrite,                
      output  branch, alusrc,                
      output  regdst, regwrite,                
      output  jump,                
      output  [1:0] aluop ); 
//Outputs into reg & assing "wire" to branch them out 
reg [8:0] control_wire;
assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = control_wire;
//Control Unit: Main Decoder lect 8, slide 26 - This is where you get your values
//to put into the "wire"
//op is what the function call in MIPS is, this decides where to flow 
always @ (*)
case(op)
6'b000000 : control_wire <= 9'b110000010;//R-type
6'b100011 : control_wire <= 9'b101001000;//lw
6'b101011 : control_wire <= 9'b001010000;//sw
6'b000100 : control_wire <= 9'b000100001;//beq
6'b001000 : control_wire <= 9'b101000000;//addi
6'b000010 : control_wire <= 9'b000000100;//j

default: control_wire <= 9'bXXXXXXXXX;//I DONT KNOW
endcase
		
endmodule 

