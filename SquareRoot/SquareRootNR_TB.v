// Code your testbench here
// or browse Examples
module FixedPointSqrt_TB;

  // Parameters
  localparam INTEGER_WIDTH = 8;      // Integer part width
  localparam FRACTION_WIDTH = 8;     // Fractional part width

  // Inputs
  reg [INTEGER_WIDTH+FRACTION_WIDTH-1:0] num;

  // Outputs
  wire [2*(INTEGER_WIDTH+FRACTION_WIDTH)-1:0] sqrt;
  // Clock generation
  reg clk;
  always begin
    #5 clk = ~clk;
  end
  // Instantiate the module under test
  FixedPointSqrt #(INTEGER_WIDTH, FRACTION_WIDTH) dut (.clk(clk),
    .num(num),
    .sqrt(sqrt)
  );


  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,FixedPointSqrt_TB);
  end

  // Stimulus
  initial begin
    clk = 0;
    num = 12345;  // 48.2227 Example input number
    #10;
    num = 9876;   // Another input number
    #10;
    // Add more test cases as needed
    $finish;
  end

  // Display results
  always @(posedge clk) begin
    $display("Input: %d,  Root: %d.%02d%01d%01d", num, sqrt[INTEGER_WIDTH+FRACTION_WIDTH-1:INTEGER_WIDTH], sqrt[INTEGER_WIDTH-1:INTEGER_WIDTH-FRACTION_WIDTH+2], sqrt[INTEGER_WIDTH-FRACTION_WIDTH+1], sqrt[INTEGER_WIDTH-FRACTION_WIDTH]);
  end

endmodule
