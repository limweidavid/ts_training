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
        @(posedge clk) a ##2 b;
    endproperty

    assert property (p1);

    initial begin
        //$assertoff();
        #2 a = 1;
        #3 b = 1;
        #3 b = 0;
        #1 b = 1;
        #10 a = 0;
        #12 b = 0;
    end

endmodule
