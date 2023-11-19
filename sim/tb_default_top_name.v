module tb_default_top_name();

parameter period 10
reg clk;
reg rst_n;
reg [31:0] seq;
wire [5:0] posi_reg;
default_top_nameu1(clk,rst_n,seq,posi_reg);


always #(period/2) clk = ~clk;

initial begin
	clk = 0;
	rst_n =1;
end

initial begin
#2  rst_n=0;
#period $display ("Simulation finish!!!");
$finish ; 
end


initial begin
	$fsdbDumpfile("tb_default_top_name.fsdb");
	$fsdbDumpvars;
end
endmodule

