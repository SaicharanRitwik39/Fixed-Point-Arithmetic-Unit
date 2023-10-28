module cordic_axi_stream (
    input wire aclk,             // Clock input
    input wire aresetn,          // Reset input (active low)
    input wire [31:0] a_i,       // Input data
    output wire [31:0] a_o,      // Output data
    output wire tvalid,          // Data valid signal
    input wire tready            // Ready signal from the downstream module
);

// Parameters for CORDIC
parameter ANGLE_PRECISION = 16;  // Number of iterations (angular precision)
parameter DATA_WIDTH = 32;       // Data width (adjust as needed)
parameter ANGLE_WIDTH = 32;      // Angle width (adjust as needed)
parameter COORD_WIDTH = 64;      // Coordinate width (adjust as needed)

// Internal signals and registers
reg signed [DATA_WIDTH-1:0] x;
reg signed [DATA_WIDTH-1:0] y;
reg signed [ANGLE_WIDTH-1:0] z;
reg signed [COORD_WIDTH-1:0] x_out;
reg signed [COORD_WIDTH-1:0] y_out;
reg signed [ANGLE_WIDTH-1:0] angle;
reg [ANGLE_WIDTH-1:0] angle_next;
wire [ANGLE_WIDTH-1:0] angle_sign;
wire [DATA_WIDTH-1:0] a;

assign angle_sign = z[ANGLE_WIDTH-1];

// CORDIC iteration
always @(posedge aclk or negedge aresetn) begin
    if (!aresetn) begin
        x <= 0;
        y <= 0;
        z <= 0;
        angle <= 0;
    end else if (tvalid && tready) begin
        x <= x_out;
        y <= y_out;
        z <= angle_next;
    end
end

// CORDIC core
always @(posedge aclk or negedge aresetn) begin
    if (!aresetn) begin
        x_out <= 0;
        y_out <= 0;
        angle_next <= 0;
    end else if (tvalid && tready) begin
        // Calculate the next angle and coordinates
        angle_next <= angle - (angle_sign ? (1 << (ANGLE_WIDTH - 1)) : 0);
        x_out <= x - (y >> (ANGLE_PRECISION - 1));
        y_out <= y + (x >> (ANGLE_PRECISION - 1));
    end
end

// Output data assignment
assign a = tvalid ? {x_out, y_out} : 0;
assign a_o = a;

// AXI Stream interface signals
assign tvalid = tready ? tvalid : 0;

endmodule
