module cordic_axi_stream_tb;

reg aclk;
reg aresetn;
reg [31:0] a_i;
wire [31:0] a_o;
wire tvalid;
reg tready;

// Instantiate the CORDIC AXI Stream module
cordic_axi_stream dut (
    .aclk(aclk),
    .aresetn(aresetn),
    .a_i(a_i),
    .a_o(a_o),
    .tvalid(tvalid),
    .tready(tready)
);

// Clock generation
always begin
    #5 aclk = ~aclk;
end

// Testbench initialization
initial begin
    aclk = 0;
    aresetn = 0;
    a_i = 0;
    tready = 0;

    // Reset the CORDIC module
    aresetn = 0;
    #10 aresetn = 1;

    // Apply test data
    a_i = 32'h40000000; // Input angle (e.g., 45 degrees)

    // Wait for the CORDIC module to signal that it's ready to receive data
    wait (tready == 1);

    // Start the CORDIC operation
    tvalid = 1;

    // Monitor the output data and wait for valid output
    wait (tvalid == 1);

    // Check the result
    if (a_o === 32'h5a827999) begin
        $display("Test passed: Output is correct (cosine of 45 degrees).");
    end else begin
        $display("Test failed: Output is incorrect.");
    end

    // Finish simulation
    $finish;
end

endmodule
