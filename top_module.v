module activity_tracker_top (
    input clk100Mhz,
    input rst,
    input start,
    input stop,
    input [1:0] mode,
    output DP,
    output OFLOW,
    output [7:1] C,
    output [7:0] AN
);

    wire pulse;
    wire [15:0] step_count;
    wire [15:0] distance;
    wire [15:0] bcd_step_count;
    wire [15:0] bcd_distance;
    wire dp;
    
    wire debounced_start;
    wire debounced_stop;
    
    wire [15:0] display_bcd;

    debouncer debouncer_start (
        .clk100Mhz(clk100Mhz),
        .rst(rst),
        .i_sig(start),
        .o_sig_debounced(debounced_start)
    );

    debouncer debouncer_stop (
        .clk100Mhz(clk100Mhz),
        .rst(rst),
        .i_sig(stop),
        .o_sig_debounced(debounced_stop)
    );

    pulse_generator pulse_gen (
        .clk(clk100Mhz),
        .reset(rst),
        .START(debounced_start),
        .STOP(debounced_stop),
        .MODE(mode),
        .pulse_out(pulse)
    );

    fitbit_tracker tracker (
        .reset(rst),
        .pulseOut(pulse),
        .step_count(step_count),
        .dist(distance),
        .OFLOW(OFLOW)
    );

    bin2bcd_fsm bin2bcd_step_count (
        .clk100Mhz(clk100Mhz),
        .rst(rst),
        .start(debounced_start),
        .bin(step_count),
        .bcd(bcd_step_count)
    );

    bin2bcd_fsm bin2bcd_distance (
        .clk100Mhz(clk100Mhz),
        .rst(rst),
        .start(debounced_start),
        .bin(distance),
        .bcd(bcd_distance)
    );

    /*bin2bcd_fsm bin2bcd_mode (
        .bin(mode),
        .bcd(bcd_mode)
    );*/

    rotation_module rotation_inst (
        .clk100Mhz(clk100Mhz),
        .rst(rst),
        .bcd_step_count(bcd_step_count),
        .bcd_distance(bcd_distance),
        .bcd_mode(mode),
        .display_bcd(display_bcd),
        .dp(dp)
    );
    
    assign AN[7:4] = 4'b1111;
    
    bcd_4digit display_driver (
        .clk(clk100Mhz),
        .reset(rst),
        .dot(dp),
        .bcd(display_bcd),  
        .C(C),
        .AN(AN[3:0]), 
        .DP(DP)  
    );

endmodule
