/*
 	input :
	output:
	function:
*/
module default_top_name(
	clk,
	rst_n,
	seq,
	posi_reg
);
input clk;
input rst_n;
input  [31:0] seq;
output reg [5:0] posi_reg;

always @(posedge clk or negedge rst_n)
begin
	if (!rst_n)
	begin

	end

	else
	begin

  end
end
endmodule
