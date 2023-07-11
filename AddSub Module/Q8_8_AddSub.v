module Q8_8_AddSub 
  //Parameters Section.
  # (parameter BUS_WIDTH = 16)
  
  //Ports Section.
  (input wire [BUS_WIDTH-1:0] operand1,
   input wire [BUS_WIDTH-1:0] operand2,
   input add_sub,  // 0 for Addition, 1 for Subtraction.
   output reg [BUS_WIDTH:0] result
);

  always @* begin
    if (add_sub == 0) begin  // Addition.
      result = operand1+operand2;
    end
    else begin  // Subtraction.
      if (operand1 > operand2) begin
        result = operand1-operand2;
      end  
      else begin result = operand2-operand1;
      end
    end

  end
endmodule
