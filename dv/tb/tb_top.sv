`include "uvm_macros.svh"
module tb_top;
    import uvm_pkg::*;
    import dut_uvm_package::*;

    reg clk;
    initial clk = 0;
    initial forever #5 clk = ~clk;

    fifo_interface fifo_if(clk);
    reg_space_interface rs_if(clk, fifo_if.rstn);

    top DUT(
        .clk(clk),
        .resetn(fifo_if.rstn),
        .axi_awaddr(rs_if.axi_awaddr),
        .axi_awprot(rs_if.axi_awprot),
        .axi_awvalid(rs_if.axi_awvalid),
        .axi_awready(rs_if.axi_awready),
        .axi_wdata(rs_if.axi_wdata),
        .axi_wstrb(rs_if.axi_wstrb),
        .axi_wvalid(rs_if.axi_wvalid),
        .axi_wready(rs_if.axi_wready),
        .axi_bresp(rs_if.axi_bresp),
        .axi_bvalid(rs_if.axi_bvalid),
        .axi_bready(rs_if.axi_bready),
        .axi_araddr(rs_if.axi_araddr),
        .axi_arprot(rs_if.axi_arprot),
        .axi_arvalid(rs_if.axi_arvalid),
        .axi_arready(rs_if.axi_arready),
        .axi_rdata(rs_if.axi_rdata),
        .axi_rresp(rs_if.axi_rresp),
        .axi_rvalid(rs_if.axi_rvalid),
        .axi_rready(rs_if.axi_rready),
        .s_axis_tready(fifo_if.S_AXIS_TREADY),
        .s_axis_tdata(fifo_if.S_AXIS_TDATA),
        .s_axis_tlast(fifo_if.S_AXIS_TLAST),
        .s_axis_tvalid(fifo_if.S_AXIS_TVALID),
        .m_axis_tvalid(fifo_if.M_AXIS_TVALID),
        .m_axis_tdata(fifo_if.M_AXIS_TDATA),
        .m_axis_tlast(fifo_if.M_AXIS_TLAST),
        .m_axis_tready(fifo_if.M_AXIS_TREADY)
    );

    initial begin
        uvm_config_db #(virtual fifo_interface)::set(null,"*","vif",fifo_if);
        uvm_config_db #(virtual reg_space_interface)::set(null,"*","vif",rs_if);
    end

    initial begin
        run_test();
    end

    initial begin
        $dumpfile ("wave.vcd");
        $dumpvars (0, tb_top);
    end

endmodule