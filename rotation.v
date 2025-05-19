module rotation_module (
    input clk100Mhz,
    input rst,
    input [15:0] bcd_step_count,
    input [15:0] bcd_distance,
    input [1:0]  bcd_mode,
    output reg [15:0] display_bcd,
    output reg dp
);

    parameter SHOW_STEP = 2'b00; // shows the step count
    parameter SHOW_DIST = 2'b01; // shows the distance
    parameter SHOW_MODE = 2'b10; // shows the mode

    reg [1:0] state;
    reg [27:0] counter;
    reg [15:0] new_dist;
  
    always @(posedge clk100Mhz) begin
        if (rst) begin //if its reset we make sure counter is 0 and that it goes back to showing the step
            counter <= 0;
            state <= SHOW_STEP;
        end else begin
            if (counter >= 200_000_000) begin  //if it reaches 2 seconds we decide to change states
                counter <= 0;
                case (state)
                    SHOW_STEP: state <= SHOW_DIST; 
                    SHOW_DIST: state <= SHOW_MODE;
                    SHOW_MODE: state <= SHOW_STEP;
                    default:   state <= SHOW_STEP;
                endcase
            end else begin
                counter <= counter + 1; //if it doesnt reach 2 seconds we increment counter
            end
        end
    end


    always @(*) begin
        case (state)
            SHOW_STEP: begin
                display_bcd = (bcd_step_count > 16'h270F) ? 16'h9999 : bcd_step_count; //we're displaying the step count but limiting to max of 9999 steps and the decimal point is off here
                dp = 0;
            end
            SHOW_DIST: begin
                display_bcd = bcd_distance; //we're displaying the distance count where decimal point is on, b/c distance will always have decimal point
                dp = 1;
            end
            SHOW_MODE: begin
                display_bcd = {12'b0, bcd_mode}; //we're displaying the mode here
                dp = 0;
            end
            default: begin
                display_bcd = 0;
                dp = 0;
            end
        endcase
    end

endmodule
