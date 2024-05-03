`timescale 1ns/1ps
module tb;

    logic a,b,clk;

    always #1 clk = ~clk;

    initial begin
        a=0; b=0; clk=0;
    end        

    initial #100 $finish;

    initial begin
        
    end

endmodule
