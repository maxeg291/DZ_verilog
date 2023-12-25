`timescale 1ns/1ns

module mult (
	input clk,
	input signed [7 : 0] num1,
	input signed [7 : 0] num2,

	output signed [7 : 0]res
);

integer i = 0;
reg signed [7 : 0] temp [0 : 7];
reg signed [7 : 0] res = 0;
reg num1_sign = 0, num2_sign = 0;

always @(posedge clk) begin
	for (i = 0; i < 7; i++) begin
		if (num1[7] == 1 && num2[7] == 0) 
			temp[i] <= (num2[i]) ? (~(num1 - 1)) << i : 0;
		else if (num1[7] == 0 && num2[7] == 1) 
			temp[i] <= (num1[i]) ? (~(num2 - 1)) << i : 0; 
		else if (num1[7] == 1 && num2[7] == 1) 
			temp[i] <= ((~(num1 - 1) & (1 << i))) ? (~(num2 - 1)) << i : 0;
		else 
			temp[i] <= (num1[i]) ? num2 << i : 0;
	end

	num1_sign <= num1[7]; 
	num2_sign <= num2[7];

	if (num1_sign == 1 ^ num2_sign == 1)
		res <= 1 + ~(temp[0] + temp[1] + temp[2] + temp[3] + temp[4] + temp[5] + temp[6]);
	else 
		res <= temp[0] + temp[1] + temp[2] + temp[3] + temp[4] + temp[5] + temp[6];
end

endmodule
