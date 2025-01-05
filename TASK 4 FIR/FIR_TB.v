module tb_fir_filter();
    reg clk;
    reg reset;
    reg signed [15:0] x_in;
    wire signed [31:0] y_out;

    fir_filter uut (
        .clk(clk),
        .reset(reset),
        .x_in(x_in),
        .y_out(y_out)
    );

    initial begin
      // Enable VCD file generation
$dumpfile("fir_filter_dump.vcd");    // Name of the VCD file
$dumpvars(0, tb_fir_filter);         // Dump all signals in the FIR filter testbench

        clk = 0;
        forever #10 clk = ~clk; // 50 MHz clock
    end

    initial begin
        reset = 1; x_in = 0;
        #20 reset = 0;

        // Apply input samples
        #20 x_in = 16'd100;
        #20 x_in = 16'd200;
        #20 x_in = 16'd300;
        #20 x_in = 16'd400;
        #20 x_in = 16'd0;

        #5000 $finish; // Ends the simulation at 5000 ticks


    end
endmodule
