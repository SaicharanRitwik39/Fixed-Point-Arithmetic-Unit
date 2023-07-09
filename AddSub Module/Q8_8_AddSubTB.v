module Q8_8_AddSub_TB;

  reg [15:0] operand1;
  reg [15:0] operand2;
  reg add_sub;
  wire [15:0] result;

  // Instantiate the unit under test
  Q8_8_AddSub dut (
    .operand1(operand1),
    .operand2(operand2),
    .add_sub(add_sub),
    .result(result)
  );

  // Stimulus generation
  initial begin
    // Test Case 1: Addition
    operand1 = 16'b0000000100001000;  // 1.031250 in Q8.8 format
    operand2 = 16'b0000001110000000;  // 3.500000 in Q8.8 format
    add_sub = 0;  // Addition
    #10;  // Allow time for computation
    $display("Addition Test Case:");
    $display("Operand 1: %f", operand1 / 256.0);
    $display("Operand 2: %f", operand2 / 256.0);
    $display("Result: %f", result / 256.0);

    // Test Case 2: Subtraction
    operand1 = 16'b0000010000000010;  // 0.007812 in Q8.8 format
    operand2 = 16'b0000000000001000;  // 0.031250 in Q8.8 format
    add_sub = 1;  // Subtraction
    #10;  // Allow time for computation
    $display("Subtraction Test Case:");
    $display("Operand 1: %f", operand1 / 256.0);
    $display("Operand 2: %f", operand2 / 256.0);
    $display("Result: %f", result / 256.0);

    // Add more test cases as needed

    $finish;
  end

endmodule
