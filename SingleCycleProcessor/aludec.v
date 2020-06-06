module aludec (   
// declare two selects based off the call
input   [5:0] funct,               
input   [1:0] aluop,               
output reg [2:0] alucontrol );  

always @ (*)

case (aluop)
//first function select is bases not in R-Type
2'b00: alucontrol <= 3'b010; // add
2'b01: alucontrol <= 3'b110; // sub
//Secound function select IS based off R-Type 'op'
default: case(funct) 
6'b100000: alucontrol <= 3'b010; // add r-rypte
6'b100010: alucontrol <= 3'b110; // sub r-rypte
6'b100100: alucontrol <= 3'b000; // and
6'b100101: alucontrol <= 3'b001; // or
6'b101010: alucontrol <= 3'b111; // stl

default: alucontrol <= 3'bxxx; // I DONT KNOW
endcase
endcase

endmodule 