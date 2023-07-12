module Q8_8_AddSub 
  //Parameters Section.
  # (parameter BUS_WIDTH = 16)
  
  //Ports Section.
  (input wire [BUS_WIDTH:0] operand1,
   input wire [BUS_WIDTH:0] operand2,
   input add_sub,          // 0 for Addition, 1 for Subtraction.
   input sign1,       // Sign bit of operand 1.   
   input sign2,       // Sign bit of operand 2.
   output reg [BUS_WIDTH+1:0] result
);
  
  assign sign1 = operand1[BUS_WIDTH];
  assign sign2 = operand2[BUS_WIDTH];
  
  always @* begin
    if (add_sub == 0) begin  // Addition.
      if (sign1 == sign2 && sign1 == 1) begin
        result = operand1[BUS_WIDTH-1:0]+operand2[BUS_WIDTH-1:0];
        //result = {1'b1, result};
      end
      else if (sign1 == sign2 && sign1 == 0) begin
        result = operand1[BUS_WIDTH-1:0]+operand2[BUS_WIDTH-1:0];
        result[BUS_WIDTH+1] = 0;
      end  
    end
  end
    
endmodule
