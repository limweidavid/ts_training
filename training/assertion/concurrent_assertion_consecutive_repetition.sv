`timescale 1ns/1ps

module tb;

    logic a,b,c,clk;

    always #1 clk = ~clk;

    initial begin
        $vcdpluson;
        $vcdplusmemon;
        a = 0; b = 0; c = 0; clk=0;
    end

    property p1;
        @(posedge clk) $rose(a) |-> ##1 b[*6] ##1 c;
    endproperty

    assert property (p1);

    initial begin
        repeat(2) @(posedge clk);
        a = 1;

        repeat(1) @(posedge clk);
        b = 1;

        repeat(6) @(posedge clk);
        b = 0;
        c = 1;

        repeat(1) @(posedge clk);
        c = 0;

        repeat(5) @(posedge clk);
        $finish;
    end

endmodule
