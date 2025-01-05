`timescale 1ns / 1ps

module sync_ram (
    input wire clk,
    input wire we,                // Write enable
    input wire [3:0] addr,        // 4-bit address, supports 16 locations
    input wire [7:0] din,         // 8-bit data input
    output reg [7:0] dout         // 8-bit data output
);
    // Declare memory array (16 locations, 8 bits each)
    reg [7:0] mem [0:15];

    always @(posedge clk) begin
        if (we) begin
            // Write operation
            mem[addr] <= din;
        end else begin
            // Read operation
            dout <= mem[addr];
        end
    end
endmodule
