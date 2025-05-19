module pulse_generator (
    input wire clk,              
    input wire reset,            
    input wire [1:0] MODE,       
    input wire START,           
    input wire STOP,            
    output reg pulse_out   
);

    reg en;
    reg [27:0] counter;
    reg [1:0] check_mode;
    reg [27:0] threshold;

    always@(posedge clk) begin
         case (MODE)
                2'b00: threshold <= 28'd3125000;          // Walk mode 32 pulses/sec 3125000
                2'b01: threshold <= 28'd1562500;    // Jog mode 64
                2'b10: threshold <= 28'd781250;     // Run mode 128
                2'b11: threshold <= 0;              // Off mode
          endcase
    end
    always @(posedge clk) begin
        if (START)
            en <= 1;
        else if (STOP)
            en <= 0;
        else if (reset)
            en <= 0;
    end 

    // Pulse generation block
    always @(posedge clk) begin
        if (reset || (en && (check_mode != MODE))) begin
            check_mode <= MODE;
            counter <= 0; 
            pulse_out <= 0; 
        end  
        else if (en) begin
            if (check_mode == 2'b11) begin
                pulse_out <= 0;
            end
            else if (counter < threshold) begin //if counter is less than threshold we keep incrementing counter
                pulse_out <= 0;
                counter <= counter + 1;
            end
            else begin
                pulse_out <= 1; //if it is equal to threshold or higher than we make sure that it outputs a pulse
                counter <= 0;                
            end
        end
    end

endmodule
