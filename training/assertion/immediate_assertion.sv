`timescale 1ns/1ps
module tb;

    logic a,b,clk;

    always #1 clk = ~clk;

    initial begin
        a=0; b=0; clk=0;
    end        

    initial #100 $finish;

    initial begin
        #2 a = 1;
        #2 b = 1;
        assert (a == b);
        #2 b = 0;
        assert (a == b) else $display("failed on purpose");
        #2 a = 0;
    end

endmodule


