// Code your testbench here
// or browse Examples
module Q8_8_AddSub_TB;

  reg [16:0] operand1;
  reg [16:0] operand2;
  reg add_sub;
  reg sign1;
  reg sign2;
  wire [17:0] result;

  // Instantiate the unit under test
  Q8_8_AddSub dut (
    .operand1(operand1),
    .operand2(operand2),
    .add_sub(add_sub),
    .sign1(sign1),
    .sign2(sign2),
    .result(result)
  );

  // Stimulus generation
  initial begin
    // Test Case 1: Addition
    operand1 = 17'b10000000100001000;  // 1.031250 in Q8.8 format
    operand2 = 17'b10000001110000000;  // 3.500000 in Q8.8 format
    add_sub = 0;  // Addition
    #10;  // Allow time for computation
    $display("Addition Test Case:");
    $display("Operand 1: %f", operand1 / 256.0);
    $display("Operand 2: %f", operand2 / 256.0);
    $display("Result: %f", result);

    $finish;
  end

endmodule
