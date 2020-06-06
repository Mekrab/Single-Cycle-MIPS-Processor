module imem (input [5:0] a, output [31:0] rd);

//Set read in RAM
reg [31:0] RAM[63:0]; 

//read file
initial
begin
$readmemh ("memfile.dat",RAM);
end
assign rd = RAM[a]; 
endmodule