module sqrt_tb();
    parameter CLK_PERIOD = 10;
    parameter WIDTH = 16;
    parameter FBITS = 8;
    parameter SF = 2.0**-8.0;  // Q8.8 scaling factor is 2^-8

    reg clk;
    reg start;             // start signal
    wire busy;              // calculation in progress
    wire valid;             // root and rem are valid
    reg [WIDTH-1:0] rad;   // radicand
    wire [WIDTH-1:0] root;  // root
    wire [WIDTH-1:0] rem;   // remainder
  
    always begin
    #5 clk = ~clk;
    end

    sqrt #(WIDTH, FBITS) dut (
        .clk(clk),
        .start(start),
        .busy(busy),
        .valid(valid),
        .rad(rad),
        .root(root),
        .rem(rem)
    );
  
    initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,sqrt_tb);
    end

  //always @(negedge clk) #(CLK_PERIOD / 2) clk = ~clk;
    initial begin
        clk = 1;
        
        #100;
        rad = 232.5625;  // 232.56250000
        start = 1;
        #10;
        start = 0;

        #120;
        rad = 0.25;  // 0.25
        start = 1;
        #10;
        start = 0;

        #120;
        rad = 2;  // 2.0
        start = 1;
        #10;
        start = 0;
        #120;
        $finish;
    end
  
  always @(posedge clk) begin
        $display("\t%d:\tsqrt(%f) = %b (%f) (rem = %b) (V=%b)",
                 $time, $itor(rad*SF), root, $itor(root*SF), rem, valid);
  end
endmodule
