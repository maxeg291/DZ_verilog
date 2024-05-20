`timescale 1ns / 1ps

module number10_tb();
    localparam WIDTH = 8, NUM = 4;
    reg clk_in = 'b0;
    reg [WIDTH-1:0] data_in = 'h0;
    wire [NUM-1:0][WIDTH-1:0] out;
    wire [NUM-1:0] out_valid;

    number10 #(.WIDTH(WIDTH), .NUM(NUM)) test_module (
        .clk_in(clk_in),
        .data_in(data_in),
        .out(out),
        .out_valid(out_valid)
    );
    integer i;
    always #5 clk_in = ~clk_in;

//заканчиваем симуляцию в момент времени "400"
    initial begin
        data_in = 'b0;
        for (i = 0; i < 3; i = i + 1)
            #10 data_in = data_in + 1;
        data_in = 'b1;
        for (i = 0; i < 40-3; i = i + 1)
            #10 data_in = ((data_in) % 4) + 1;
        $finish;
    end

    //создаем файл VCD для последующего анализа сигналов
    initial begin
        $dumpfile("number10.vcd");
        $dumpvars(0, number10_tb);
    end
    
endmodule