`timescale 1ns / 1ps

module pulse_generator_tb;

    reg clk;
    reg reset;
    reg [1:0] MODE;
    reg START;
    reg STOP;

    wire pulse_out;

    pulse_generator uut (
        .clk(clk),
        .reset(reset),
        .MODE(MODE),
        .START(START),
        .STOP(STOP),
        .pulse_out(pulse_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        MODE = 2'b00;
        START = 0;
        STOP = 0;

        #20;
        reset = 0;

        #10;
        START = 1;
        #10;
        START = 0;

        #100000;
        MODE = 2'b01;

        #100000;
        MODE = 2'b10;

        #100000;
        STOP = 1;
        #10;
        STOP = 0;

        #50;
        $finish;
    end

endmodule
