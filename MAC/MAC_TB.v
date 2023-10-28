module fixed_point_mac_tb;

reg clk;
reg rst;
reg [31:0] data_in_a;
reg [31:0] data_in_b;
wire [31:0] data_out;

// Instantiate the MAC module
fixed_point_mac dut (
    .clk(clk),
    .rst(rst),
    .data_in_a(data_in_a),
    .data_in_b(data_in_b),
    .data_out(data_out)
);

// Clock generation
always begin
    #5 clk = ~clk;
end

// Testbench initialization
initial begin
    clk = 0;
    rst = 0;
    data_in_a = 16'h4000;   // 0.25 in fixed-point format (16 fractional bits)
    data_in_b = 16'h8000;   // -1.0 in fixed-point format (16 fractional bits)

    // Reset the MAC module
    rst = 1;
    #10 rst = 0;

    // Apply input data
    data_in_a = 16'h4000;   // 0.25 in fixed-point format
    data_in_b = 16'h8000;   // -1.0 in fixed-point format

    // Wait for a few clock cycles
    #20;

    // Monitor the output data
    $display("Output Data: %d", data_out);

    // Check the result (expected result is -0.25 in fixed-point format)
    if (data_out === 16'hC000) begin
        $display("Test passed: Output is correct.");
    end else begin
        $display("Test failed: Output is incorrect.");
    end

    // Finish simulation
    $finish;
end

endmodule
