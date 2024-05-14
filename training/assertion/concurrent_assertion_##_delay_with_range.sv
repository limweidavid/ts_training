`timescale 1ns/1ps
module tb;

    logic a,b,clk;

    always #1 clk = ~clk;

    initial begin
        $vcdpluson;
        $vcdplusmemon;
        a=0; b=0; clk=0;
    end        

    initial #100 $finish;

    property p1;
        @(posedge clk) a |-> ##[1:5] b;
    endproperty

    assert property (p1);

    initial begin
        repeat(2)@ (posedge clk) 
        a = 1; repeat(3)@ (posedge clk); b = 1;

        repeat(2)@ (posedge clk)
        a = 0; b = 0;

        repeat(2)@ (posedge clk)
        a = 1; repeat(6)@ (posedge clk); b = 1;
        
        repeat(2)@ (posedge clk)
        a = 0; b = 0;
    end

endmodule
