 `timescale 1ns / 1ps

module priority_cd_tb();
    parameter IN_WIDTH = 8;
    localparam OUT_WIDTH = $clog2(IN_WIDTH);
    reg  [ IN_WIDTH-1:0] in;
    wire [OUT_WIDTH-1:0] out;
    wire [IN_WIDTH-1:0] mask [OUT_WIDTH-1:0];

    priority_cd #(.IN_WIDTH(IN_WIDTH)) uut (
        .in(in),
        .out(out)
    );
    initial begin 
        $dumpfile("number7.vcd");
        $dumpvars(0, priority_cd_tb);
        //$dumpvars(1, priority_cd);
    end
    initial #800 $finish;
    initial in = 0;
    always #1 in = in + 1;
endmodule
