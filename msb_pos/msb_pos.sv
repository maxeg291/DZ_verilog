module priority_cd #(
    parameter IN_WIDTH = 32,
    localparam OUT_WIDTH = $clog2(IN_WIDTH)
)(
    input [IN_WIDTH-1:0] in,
    output [OUT_WIDTH-1:0] out
);
 
    wire [IN_WIDTH-1:0] reversed;
    wire [IN_WIDTH-1:0] procesed;
    wire [IN_WIDTH-1:0] inter;
    wire [IN_WIDTH-1:0] mask [OUT_WIDTH-1:0];

    assign procesed = (reversed & (reversed - 1'b1)) ^ reversed;

    genvar i, j;
    generate
        for (i = 0; i < IN_WIDTH; i = i + 1) begin 
            assign reversed[i] = in[IN_WIDTH-1-i];
            assign inter[i] = procesed[IN_WIDTH-1-i];
        end
        for (j = 0; j < OUT_WIDTH; j = j + 1) begin
            for (i = 0; i < IN_WIDTH; i = i + 1) 
                assign mask[j][i] = (i >> j) & 1;
            assign out[j] = |(inter & mask[j]);
        end
    endgenerate
endmodule