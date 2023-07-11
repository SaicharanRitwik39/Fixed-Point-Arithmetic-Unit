module StreamingAccumulator (
  input clk,
  input reset,
  input wire [15:0] data_in,
  output wire [31:0] sum_out
);

  reg [31:0] accumulator;

  always @(posedge clk or posedge reset) begin
    if (reset == 1) begin
      accumulator <= 0;
    end 
    else begin
      accumulator <= data_in + accumulator;
    end
  end

  assign sum_out = accumulator;
endmodule
