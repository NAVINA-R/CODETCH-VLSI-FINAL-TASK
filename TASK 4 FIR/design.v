module fir_filter(
    input clk,
    input reset,
    input signed [15:0] x_in, // Input sample
    output reg signed [31:0] y_out // Filtered output
);
    parameter N = 32; // Filter order
    reg signed [15:0] x[0:N-1]; // Input delay line
    reg signed [15:0] coeff[0:N-1]; // Filter coefficients
    integer i;

    // Initialize coefficients
    initial begin
        coeff[0] = 16'd32767; // Replace with calculated coefficients
        coeff[1] = 16'd29491;
        coeff[2] = 16'd23170;
        // ... add all coefficients here
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            y_out <= 0;
            for (i = 0; i < N; i = i + 1) x[i] <= 0;
        end else begin
            // Shift delay line
            for (i = N-1; i > 0; i = i - 1) x[i] <= x[i-1];
            x[0] <= x_in;

            // Compute filter output
            y_out <= 0;
            for (i = 0; i < N; i = i + 1) y_out <= y_out + x[i] * coeff[i];
        end
    end
endmodule
