`timescale 1ns / 1ps

module sync_ram_tb;
    // Testbench signals
    reg clk;
    reg we;
    reg [3:0] addr;
    reg [7:0] din;
    wire [7:0] dout;

    // Instantiate the RAM module
    sync_ram uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10ns clock period

    // Test procedure
    initial begin
      
    	$dumpfile("waveform.vcd"); // Specify the output file name
    	$dumpvars(0, sync_ram_tb); // Dump all variables in the testbench


        // Initialize signals
        we = 0;
        addr = 0;
        din = 0;

        // Test Write Operation
        #10 we = 1; addr = 4'd0; din = 8'hAA; // Write 0xAA to address 0
        #10 we = 1; addr = 4'd1; din = 8'hBB; // Write 0xBB to address 1

        // Test Read Operation
        #10 we = 0; addr = 4'd0; // Read from address 0
        #10 we = 0; addr = 4'd1; // Read from address 1

        // End simulation
        #20 $finish;
    end
endmodule
