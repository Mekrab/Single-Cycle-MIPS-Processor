module dmem (input clk, we,input [31:0] a, wd,output [31:0] rd);

//Set read RAM
reg [31:0] RAM[63:0];

// put word into bus 
assign rd = RAM[a[31:2]]; 

//read data for and into ram 
always @ (posedge clk)
if (we)
RAM[a[31:2]] <= wd;
endmodule