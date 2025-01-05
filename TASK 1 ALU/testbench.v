// Code your testbench here
// or browse Examples
module ALU_tb;
    reg [3:0] A;
    reg [3:0] B;
    reg [2:0] ALUOp;
    wire [3:0] Result;
    wire Zero;

    // Instantiate the ALU
    ALU uut (
        .A(A),
        .B(B),
        .ALUOp(ALUOp),
        .Result(Result),
        .Zero(Zero)
    );

    initial begin
      // Enable VCD file generation
        $dumpfile("dump.vcd");    // Name of the VCD file
        $dumpvars(0, ALU_tb);     // Dump all signals in the testbench
        // Monitor the outputs
        $monitor("Time: %0d | A: %b | B: %b | ALUOp: %b | Result: %b | Zero: %b", $time, A, B, ALUOp, Result, Zero);
        
        // Test cases
        A = 4'b0101; B = 4'b0011; ALUOp = 3'b000; #10; // Addition
        A = 4'b0101; B = 4'b0011; ALUOp = 3'b001; #10; // Subtraction
        A = 4'b0101; B = 4'b0011; ALUOp = 3'b010; #10; // AND
        A = 4'b0101; B = 4'b0011; ALUOp = 3'b011; #10; // OR
        A = 4'b0101; ALUOp = 3'b100; #10;              // NOT
        
        // End simulation
        $finish;
    end
endmodule
