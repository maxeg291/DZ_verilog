`timescale 1ns/1ns

module test ();

reg clk = 0;

initial
	forever #5 clk = ~clk;

reg signed [7 : 0] re1_out = 8'sh0;
reg signed [7 : 0] im1_out = 8'sh0;
reg signed [7 : 0] re2_out = 8'sh0;
reg signed [7 : 0] im2_out = 8'sh0;

reg signed [7 : 0] re1_in = 8'sh0;
reg signed [7 : 0] im1_in = 8'sh0;
reg signed [7 : 0] re2_in = 8'sh0;
reg signed [7 : 0] im2_in = 8'sh0;

wire signed [7 : 0] re_res = 0;
wire signed [7 : 0] im_res = 0;

reg [1 : 0] counter = 0;

initial begin
	re1_in = -23;
	re2_in = 43;
	im1_in = 24;
	im2_in = 36;
end

complex_mult complex_mult(
	.clk(clk),

	.re1(re1_out), 
	.im1(im1_out),
	.re2(re2_out),
	.im2(im2_out),

	.re_res(re_res),
	.im_res(im_res)
);

always @(posedge clk) begin
	if (counter == 2) begin
		re1_out <= re1_in;
		im1_out <= im1_in;
		re2_out <= re2_in;
		im2_out <= im2_in;
		counter <= 0;
	end
	else begin
		re1_out <= 0;
		im1_out <= 0;
		re2_out <= 0;
		im2_out <= 0;
		counter <= counter + 1;
	end
end

initial
begin
	$dumpfile("test.vcd");
	$dumpvars;
end

endmodule
