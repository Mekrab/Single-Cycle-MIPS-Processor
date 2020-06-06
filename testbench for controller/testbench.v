module testbench();
	reg   [5:0] op, funct;
   reg         zero;
	reg         memtoregexpected, memwriteexpected;
   reg         pcsrcexpected, alusrcexpected;
   reg         regdstexpected, regwriteexpected;
   reg         jumpexpected;
	reg   [2:0] alucontrolexpected; 
   wire        memtoreg, memwrite;
   wire        pcsrc, alusrc;
   wire        regdst, regwrite;
   wire        jump;
   wire  [2:0] alucontrol;
	
	reg clk, reset;
	reg [3:0] vectornum, errors;
	reg [22:0] testvectors[9:0];

	controller dut(op, funct, zero, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

	always
	begin
		clk = 1; #5; clk = 0; #5;
	end
	
	initial
	begin
		$readmemb("example.tv", testvectors);
		vectornum = 0; errors = 0;
		reset = 1;
		#27;
		reset = 0;
	end
	
	always @(posedge clk)
	begin
		#1; {op, funct, zero, regwriteexpected, regdstexpected, alusrcexpected, pcsrcexpected, memwriteexpected, memtoregexpected, jumpexpected, alucontrolexpected} = testvectors[vectornum];
	end
	
	always @(negedge clk)
	begin
		if (~reset)
		begin 
			if (memtoreg !== memtoregexpected | memwrite !== memwriteexpected | pcsrc !== pcsrcexpected | alusrc !== alusrcexpected | regdst!== regdstexpected | regwrite !== regwriteexpected | jump !== jumpexpected | alucontrol !== alucontrolexpected) begin
				$display("Error: inputs = %b", {op, funct, zero});
				//$display(" outputs = %b (%b expected)", y, yexpected);
				errors = errors + 1;
			end

			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 23'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);
				$stop;
			end
		end
	end
	
endmodule