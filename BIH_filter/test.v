`timescale 1ns/1ns

module test ();

reg clk = 0;

initial
	forever #5 clk = ~clk;

reg signed [15 : 0] x_vals[10 : 0];
reg signed [15 : 0] y_vals[10 : 0];

reg signed [15 : 0] y_check;
reg signed [15 : 0] out = 0;
wire signed [15 : 0] y_filter;

integer i;

initial begin
	x_vals[0] = 9;
	x_vals[1] = 14;
	x_vals[2] = 7;
	x_vals[3] = 10;
	x_vals[4] = 9;
	x_vals[5] = 14;
	x_vals[6] = 11;
	x_vals[7] = 9;
	x_vals[8] = 12;
	x_vals[9] = 13;

	y_vals[0] = x_vals[0] * 3;
	for (i = 1; i < 10; i++) begin
		y_vals[i] = - y_vals[i - 1] * 2 + 3 * x_vals[i];
	end

	i = 0;

end

filter filter(
	.clk 	(clk),
	.x_val 	(out),
	.y_val 	(y_filter)
);

always @(posedge clk) begin
	out <= x_vals[i];
	y_check <= y_vals[i];
	i = i + 1;
	if (i == 10) begin 
		i = 0;
	end

end

initial
begin
	$dumpfile("test.vcd");
	$dumpvars;
end

endmodule
