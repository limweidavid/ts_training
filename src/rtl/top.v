`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04.12.2023 12:03:57
// Design Name:
// Module Name: top
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module top (
    input                clk          ,
    input  wire          resetn       ,
    input  wire [32-1:0] axi_awaddr   ,
    input  wire [   2:0] axi_awprot   ,
    input  wire          axi_awvalid  ,
    output wire          axi_awready  ,
    input  wire [32-1:0] axi_wdata    ,
    input  wire [   3:0] axi_wstrb    ,
    input  wire          axi_wvalid   ,
    output wire          axi_wready   ,
    output wire [   1:0] axi_bresp    ,
    output wire          axi_bvalid   ,
    input  wire          axi_bready   ,
    input  wire [32-1:0] axi_araddr   ,
    input  wire [   2:0] axi_arprot   ,
    input  wire          axi_arvalid  ,
    output wire          axi_arready  ,
    output wire [32-1:0] axi_rdata    ,
    output wire [   1:0] axi_rresp    ,
    output wire          axi_rvalid   ,
    input  wire          axi_rready   ,
    output wire          s_axis_tready,
    input  wire [32-1:0] s_axis_tdata ,
    input  wire          s_axis_tlast ,
    input  wire          s_axis_tvalid,
    output wire          m_axis_tvalid,
    output wire [32-1:0] m_axis_tdata ,
    output wire          m_axis_tlast ,
    input  wire          m_axis_tready
);



    register_space #(
        .C_S00_AXI_DATA_WIDTH(32),
        .C_S00_AXI_ADDR_WIDTH(10)
    ) register_space_dut (
        .s00_axi_aclk   (clk        ), //input wire
        .s00_axi_aresetn(resetn     ), //input wire
        .s00_axi_awaddr (axi_awaddr ), //input wire [C_S00_AXI_ADDR_WIDTH-1 : 0]
        .s00_axi_awprot (axi_awprot ), //input wire [2 : 0]
        .s00_axi_awvalid(axi_awvalid), //input wire
        .s00_axi_awready(axi_awready), //output wire
        .s00_axi_wdata  (axi_wdata  ), //input wire [C_S00_AXI_DATA_WIDTH-1 : 0]
        .s00_axi_wstrb  (axi_wstrb  ), //input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0]
        .s00_axi_wvalid (axi_wvalid ), //input wire
        .s00_axi_wready (axi_wready ), //output wire
        .s00_axi_bresp  (axi_bresp  ), //output wire [1 : 0]
        .s00_axi_bvalid (axi_bvalid ), //output wire
        .s00_axi_bready (axi_bready ), //input wire
        .s00_axi_araddr (axi_araddr ), //input wire [C_S00_AXI_ADDR_WIDTH-1 : 0]
        .s00_axi_arprot (axi_arprot ), //input wire [2 : 0]
        .s00_axi_arvalid(axi_arvalid), //input wire
        .s00_axi_arready(axi_arready), //output wire
        .s00_axi_rdata  (axi_rdata  ), //output wire [C_S00_AXI_DATA_WIDTH-1 : 0]
        .s00_axi_rresp  (axi_rresp  ), //output wire [1 : 0]
        .s00_axi_rvalid (axi_rvalid ), //output wire
        .s00_axi_rready (axi_rready )  //input wire
    );


    fifo #(
        .WIDTH   (32            ),
        .DEPTH   (4            ),
	.C_M_AXIS_TDATA_WIDTH(32),
	.C_S_AXIS_TDATA_WIDTH(32),
        .PTRWIDTH($clog2(DEPTH))
    ) fifo_dut (
        .clk          (clk          ), //input  wire
        .rst_n        (resetn       ), //input  wire
        // SLAVE INTERFACE
        .S_AXIS_TREADY(s_axis_tready), //output wire
        .S_AXIS_TDATA (s_axis_tdata ), //input  wire [    C_S_AXIS_TDATA_WIDTH-1:0]
        .S_AXIS_TLAST (s_axis_tlast ), //input  wire
        .S_AXIS_TVALID(s_axis_tvalid), //input  wire
        // MASTER INTERFACE
        .M_AXIS_TVALID(m_axis_tvalid), // output wire
        .M_AXIS_TDATA (m_axis_tdata ), // output wire [    C_M_AXIS_TDATA_WIDTH-1:0]
        .M_AXIS_TLAST (m_axis_tlast ), // output wire
        .M_AXIS_TREADY(m_axis_tready)  // input  wire
    );
endmodule
