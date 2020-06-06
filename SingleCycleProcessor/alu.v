module alu (a, b, sel, out, zero);
input [31:0] a,b;input [2:0] sel;output reg [31:0] out;output reg zero;
//Begin with setting inital conditions
initial begin
out = 0;zero =1'b0;
end
always @ (*)begin
case(sel)		  
3'b000:out=a&b;
3'b001:out=a|b;
3'b010:out=a+b;
3'b100:out=a&~b;
3'b010:out=a|~b;
3'b110:out=a-b;
3'b111:
       if ( a < b)
       out = 1;
       else
       out=0;
default : out = 4'bxxx;  //Default
endcase
if (out == 0)
		zero = 1;
      else
      zero = 0;
end
endmodule