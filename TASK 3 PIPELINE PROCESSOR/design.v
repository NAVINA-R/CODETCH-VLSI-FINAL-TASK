// 4-Stage Pipelined Processor
module PipelineProcessor(
    input clk, reset,
    input [31:0] instruction, // 32-bit instruction
    output [31:0] result
);

    // Pipeline Stage Registers
    reg [31:0] IF_ID_instr;
    reg [31:0] ID_EX_A, ID_EX_B, ID_EX_instr;
    reg [31:0] EX_MEM_result, EX_MEM_B;
    reg [31:0] MEM_WB_result;

    // Register File
    reg [31:0] registers[0:31];

    // Initialize Registers
    integer i;
    always @(posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= i; // Initialize registers with sample data
        end
    end

    // Instruction Fetch (IF) Stage
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            IF_ID_instr <= 0;
        end else begin
            IF_ID_instr <= instruction; // Fetch instruction
        end
    end

    // Instruction Decode (ID) Stage
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ID_EX_A <= 0;
            ID_EX_B <= 0;
            ID_EX_instr <= 0;
        end else begin
            ID_EX_A <= registers[IF_ID_instr[25:21]]; // Read rs
            ID_EX_B <= registers[IF_ID_instr[20:16]]; // Read rt
            ID_EX_instr <= IF_ID_instr;
        end
    end

    // Execute (EX) Stage
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            EX_MEM_result <= 0;
            EX_MEM_B <= 0;
        end else begin
            case (ID_EX_instr[31:26]) // Decode opcode
                6'b000000: // ADD
                    EX_MEM_result <= ID_EX_A + ID_EX_B;
                6'b000001: // SUB
                    EX_MEM_result <= ID_EX_A - ID_EX_B;
                6'b000010: // LOAD
                    EX_MEM_result <= ID_EX_A + ID_EX_instr[15:0]; // Address calculation
                default:
                    EX_MEM_result <= 0;
            endcase
            EX_MEM_B <= ID_EX_B;
        end
    end

    // Memory Access / Write Back (MEM/WB) Stage
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            MEM_WB_result <= 0;
        end else begin
            MEM_WB_result <= EX_MEM_result;
        end
    end

    // Output the result
    assign result = MEM_WB_result;

endmodule
