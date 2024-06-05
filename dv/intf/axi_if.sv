///////////////////////////////////////////////////////////////////////////
//
// File name         : 
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

interface reg_space_interface #(parameter WIDTH=32) (input clk, input resetn);
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


    covergroup write_address_cg @(posedge clk);
        valid : coverpoint axi_awvalid;
        ready : coverpoint axi_awready;
        address : coverpoint axi_awaddr;
    endgroup : write_address_cg

    covergroup write_data_cg @(posedge clk);
        valid : coverpoint axi_wvalid;
        ready : coverpoint axi_wready;
        data : coverpoint axi_wdata {
                        bins b1 = {0,2,7}; //increments for addr = 0,2 or 7
                        bins b2   = {[30:40],[50:60],77}; //increments for data = 30-40 or 50-60 or 77                  
                        bins b3[] = {[79:99],[110:130],140}; //creates three bins b3[0],b3[1] and b3[3] with values 79-99,110-130 and 140 respectively
                        bins b4[] = {160,170,180}; //creates three bins b4[0],b4[1] and b4[3] with values
                        bins b5   = (10=>20=>30); //transition from 10->20->30
                        }
    endgroup : write_data_cg

    write_address_cg aw_channel_cg = new();
    write_data_cg aw_data_cg = new();
endinterface