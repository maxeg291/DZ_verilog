`timescale 1ns/1ns

module complex_mult (
	input clk,

	input signed [7 : 0] re1,
	input signed [7 : 0] im1,
	input signed [7 : 0] re2,
	input signed [7 : 0] im2,

	output signed [7 : 0] re_res,
	output signed [7 : 0] im_res 
);

wire signed [7 : 0] sub_res_re_1;
wire signed [7 : 0] sub_res_re_2;
wire signed [7 : 0] sub_res_im_1;
wire signed [7 : 0] sub_res_im_2;

reg signed [7 : 0] re_res = 0;
reg signed [7 : 0] im_res = 0;

mult mult_real1(
	.clk(clk),	
	.num1(re1),
	.num2(re2),	
	.res(sub_res_re_1)
);

mult mult_real2(
	.clk(clk),	
	.num1(im1),
	.num2(im2),	
	.res(sub_res_re_2)
);

mult mult_img1(
	.clk(clk),	
	.num1(re1),
	.num2(im2),	
	.res(sub_res_im_1)
);

mult mult_img2(
	.clk(clk),	
	.num1(re2),
	.num2(im1),	
	.res(sub_res_im_2)
);

always @(posedge clk) begin 
	re_res <= sub_res_re_1 - sub_res_re_2;
	im_res <= sub_res_im_1 + sub_res_im_2;
end

endmodule
