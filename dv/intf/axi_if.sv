///////////////////////////////////////////////////////////////////////////
//
// File name         : fifo_if.sv
// Author            : Shamaim
// Creation Date     : December 27, 2023
//
// No portions of this material may be reproduced in any form without
// the written permission of Thundersoft
//
// No portions of this material may be reproduced in any form without
// the written permission of Thundersoft
//
// Description : 
//
///////////////////////////////////////////////////////////////////////////

interface axi_if #(parameter WIDTH=32) (input clk);
    logic          resetn       ;
    logic [WIDTH-1:0] axi_awaddr   ;
    logic [   2:0] axi_awprot   ;
    logic          axi_awvalid  ;
    logic          axi_awready  ;
    logic [WIDTH-1:0] axi_wdata    ;
    logic [   3:0] axi_wstrb    ;
    logic          axi_wvalid   ;
    logic          axi_wready   ;
    logic [   1:0] axi_bresp    ;
    logic          axi_bvalid   ;
    logic          axi_bready   ;
    logic [WIDTH-1:0] axi_araddr   ;
    logic [   2:0] axi_arprot   ;
    logic          axi_arvalid  ;
    logic          axi_arready  ;
    logic [WIDTH-1:0] axi_rdata    ;
    logic [   1:0] axi_rresp    ;
    logic          axi_rvalid   ;
    logic          axi_rready   ;
endinterface