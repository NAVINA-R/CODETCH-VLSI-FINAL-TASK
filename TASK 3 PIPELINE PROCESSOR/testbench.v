// Testbench for 4-Stage Pipelined Processor
module TestPipelineProcessor;
    reg clk, reset;
    reg [31:0] instruction;
    wire [31:0] result;

    // Instantiate the Pipeline Processor
    PipelineProcessor uut(
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .result(result)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock period of 10 time units
    end

    // Test Sequence
    initial begin
        // Initialize
        reset = 1;
        instruction = 0;
        #10 reset = 0;

        // Test ADD Instruction: opcode = 000000, rs = 5, rt = 6
        instruction = 32'b000000_00101_00110_00000_00000_100000;
        #10;

        // Test SUB Instruction: opcode = 000001, rs = 7, rt = 8
        instruction = 32'b000001_00111_01000_00000_00000_100010;
        #10;

        // Test LOAD Instruction: opcode = 000010, rs = 9, immediate = 16
        instruction = 32'b000010_01001_00000_00000_00000_00010000;
        #10;

        $finish;
    end

    // Dump Waves
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, TestPipelineProcessor);
    end
endmodule
