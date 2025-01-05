// Code your design here
module ALU (
    input [3:0] A,    // 4-bit Input A
    input [3:0] B,    // 4-bit Input B
    input [2:0] ALUOp, // ALU Operation Selector
    output reg [3:0] Result, // 4-bit Output Result
    output reg Zero   // Zero flag
);

    always @(*) begin
        case (ALUOp)
            3'b000: Result = A + B;       // Addition
            3'b001: Result = A - B;       // Subtraction
            3'b010: Result = A & B;       // AND
            3'b011: Result = A | B;       // OR
            3'b100: Result = ~A;          // NOT (Unary operation on A)
            default: Result = 4'b0000;    // Default case
        endcase
        
        // Set Zero flag
        Zero = (Result == 4'b0000) ? 1'b1 : 1'b0;
    end
endmodule