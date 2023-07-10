// Code your design here
module FixedPointSqrt
#(
  parameter INTEGER_WIDTH = 16,  // Integer part width
  parameter FRACTION_WIDTH = 16  // Fractional part width
)
(
  input clk,
  input  wire [INTEGER_WIDTH+FRACTION_WIDTH-1:0] num,  // Input number
  output wire [2*(INTEGER_WIDTH+FRACTION_WIDTH)-1:0] sqrt  //  root of the input number
);
  
  //reg [INTEGER_WIDTH+FRACTION_WIDTH-1:0] xn;  // Initial approximation
  //reg [2*(INTEGER_WIDTH+FRACTION_WIDTH)-1:0] temp_prv; // Difference between xn1 and xn2
  reg [(INTEGER_WIDTH+FRACTION_WIDTH)-1:0] temp; // Difference between xn1 and xn2
  reg [2*(INTEGER_WIDTH+FRACTION_WIDTH)-1:0] temp_full; // Difference between xn1 and xn2
  reg [(INTEGER_WIDTH+FRACTION_WIDTH)-1:0] temp_next; // Difference between xn1 and xn2
  
  // Initial approximation (start with half of the input number)
//  initial begin
//    xn = num >> 1; 
//  end
  
  always @(posedge clk) begin
	temp = num >> 1;
    repeat(10) begin 
      temp_full=(temp + (num / temp)) >> 1; 
      temp_next = temp_full;
      temp=temp_next;
      $display("temp: %b", temp);
    end
  end
  
  assign sqrt = temp;
  
endmodule
