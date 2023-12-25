`timescale 1ns/1ns

module filter (
	input clk, 
	input signed  [15 : 0] x_val,

	output signed [15 : 0] y_val
);

reg signed [15 : 0] a_cube = -27;
reg signed [15 : 0] a_square_b = 18;
reg signed [15 : 0] a_b = -6;
reg signed [15 : 0] b = 2;

reg [8 : 0] start_counter = 0;	

reg signed [15 : 0] x_val_old_1 = 0;
reg signed [15 : 0] x_val_old_2 = 0;
reg signed [15 : 0] y_calc_val = 0;

wire signed [15 : 0] x_mult_b; 	
wire signed [15 : 0] x_mult_a_b;	
wire signed [15 : 0] x_mult_a_square_b;
wire signed [15 : 0] y_mult_a_cube;

always @(posedge clk) begin
	x_val_old_1 <= x_val;	
	x_val_old_2 <= x_val_old_1;

	if (start_counter > 5)
		y_calc_val <= x_mult_b + x_mult_a_b + x_mult_a_square_b + y_mult_a_cube;
	else begin
		y_calc_val <= x_mult_b + x_mult_a_b + x_mult_a_square_b;
		start_counter <= start_counter + 1;
	end
end

mult m_x_mult_b(
	.clk 	(clk),
	.num1	(b),
	.num2	(x_val),
	.res 	(x_mult_b)
);

mult m_x_mult_a_b(
	.clk 	(clk),
	.num1	(a_b),
	.num2	(x_val_old_1),
	.res 	(x_mult_a_b)
);

mult m_x_mult_a_square_b(
	.clk 	(clk),
	.num1	(a_square_b),
	.num2	(x_val_old_2),
	.res 	(x_mult_a_square_b)
);

mult m_y_mult_a_cube(
	.clk 	(clk),
	.num1	(a_cube),
	.num2	(y_calc_val),
	.res 	(y_mult_a_cube)
);

assign y_val = y_calc_val;

endmodule 
