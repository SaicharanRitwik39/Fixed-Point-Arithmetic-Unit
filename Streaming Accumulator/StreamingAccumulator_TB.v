module StreamingAccumulator_TB;

  reg clk;
  reg reset;
  reg [15:0] data_in;
  wire [31:0] sum_out;

  // Instantiate the module to be tested
  StreamingAccumulator dut (
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .sum_out(sum_out)
  );

  // Clock generator
  always #5 clk = ~clk;

  // Test stimulus
  initial begin
    // Initialize inputs
    reset = 1;
    data_in = 0;

    // Apply reset
    #10 reset = 0;

    // Add 16 integers
    #5 data_in = 1;
    #5 data_in = 2;
    #5 data_in = 3;
    #5 data_in = 4;
    #5 data_in = 5;
    #5 data_in = 6;
    #5 data_in = 7;
    #5 data_in = 8;
    #5 data_in = 9;
    #5 data_in = 10;
    #5 data_in = 11;
    #5 data_in = 12;
    #5 data_in = 13;
    #5 data_in = 14;
    #5 data_in = 15;
    #5 data_in = 16;

    // Wait for the sum to stabilize
    #10;

    // Check the accumulated sum
    if (sum_out === 16'b1000100110010110) begin
      $display("Test passed: Accumulated sum is correct: %b", sum_out);
    end else begin
      $display("Test failed: Accumulated sum is incorrect: %b", sum_out);
    end

    // End the simulation
    $finish;
  end

endmodule
