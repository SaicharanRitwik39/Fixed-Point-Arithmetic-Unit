module Q8_8_AddSub 
  //Parameters Section.
  # (parameter BUS_WIDTH = 16)
  
  //Ports Section.
  (input wire [BUS_WIDTH-1:0] operand1,
   input wire [BUS_WIDTH-1:0] operand2,
   input add_sub,  // 0 for Addition, 1 for Subtraction.
   output wire [BUS_WIDTH:0] result
);
  
  reg [(BUS_WIDTH/2)-1:0] integer_sum;
  reg [(BUS_WIDTH/2)-1:0] fraction_sum;

  always @* begin
    if (add_sub == 0) begin  // Addition
      integer_sum = operand1[15:8] + operand2[15:8];
      fraction_sum = operand1[7:0] + operand2[7:0];
    end
    else begin  // Subtraction
      integer_sum = operand1[15:8] - operand2[15:8];
      fraction_sum = operand1[7:0] - operand2[7:0];
    end

    if (fraction_sum >= 256) begin
      integer_sum = integer_sum + 1;
      fraction_sum = fraction_sum - 256;
    end
    else if (fraction_sum < 0) begin
      integer_sum = integer_sum - 1;
      fraction_sum = fraction_sum + 2556;
    end
  end
  assign result = {integer_sum, fraction_sum};

endmodule

