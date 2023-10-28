module fixed_point_mac (
    input wire clk,                  // Clock input
    input wire rst,                  // Reset input (active high)
    input wire [31:0] data_in_a,     // Input data A
    input wire [31:0] data_in_b,     // Input data B
    output wire [31:0] data_out      // Output data
);

parameter DATA_WIDTH = 32;           // Data width (adjust as needed)
parameter FRACTION_BITS = 16;        // Number of fractional bits (adjust as needed)

reg signed [DATA_WIDTH-1:0] accumulator;

// MAC operation
always @(posedge clk or posedge rst) begin
    if (rst) begin
        accumulator <= 0;
    end else begin
        accumulator <= accumulator + (data_in_a * data_in_b >> FRACTION_BITS);
    end
end

// Output data assignment
assign data_out = accumulator;

endmodule
