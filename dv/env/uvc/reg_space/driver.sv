///////////////////////////////////////////////////////////////////////////
//
// File name         : driver.sv
// Author            : Shamaim
// Creation Date     : December 29, 2023
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

class reg_space_driver extends uvm_driver #(reg_space_sequence_item);

    `uvm_component_utils(reg_space_driver)

    virtual reg_space_interface reg_space_intf;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual reg_space_interface)::get(this,"","vif",reg_space_intf))
            `uvm_fatal(get_type_name(), "Interface not Found")
    endfunction

    virtual task run_phase (uvm_phase phase);
        forever begin
          seq_item_port.get_next_item(req);
          `uvm_info(get_full_name(), "Transaction Received", UVM_MEDIUM)
          req.print();
          fork
            write_data();
            read_data();
          join
          seq_item_port.item_done();
        end
    endtask

    virtual task write_data();
        if(req.write_read == 'd0) begin
          fork
            address_write_channel();
            data_write_channel();
            bresp_channel();
          join
        end
    endtask

    virtual task read_data();
        if(req.write_read == 'd1) begin
          fork
            address_read_channel();
            data_read_channel();
          join
        end
    endtask

    virtual task address_write_channel();
      @(posedge reg_space_intf.clk);
      reg_space_intf.axi_awprot = 'd0;
      reg_space_intf.axi_awaddr = req.address;
      reg_space_intf.axi_awvalid = 'd1;
      wait(reg_space_intf.axi_awready == 'd1);
      @(posedge reg_space_intf.clk);
      reg_space_intf.axi_awvalid = 'd0;
      reg_space_intf.axi_awaddr = 'd0;
    endtask

    virtual task data_write_channel();
      @(posedge reg_space_intf.clk);
      reg_space_intf.axi_wdata = req.data;
      reg_space_intf.axi_wvalid = 'd1;
      wait(reg_space_intf.axi_wready == 'd1);
      @(posedge reg_space_intf.clk);
      reg_space_intf.axi_wvalid = 'd0;
      reg_space_intf.axi_wdata = 'd0;
    endtask

    virtual task bresp_channel();
      @(posedge reg_space_intf.clk);
      reg_space_intf.axi_bready = 'b1;
      wait(reg_space_intf.axi_bvalid == 'd1);
      if(reg_space_intf.axi_bresp > 'd1)
        req.slave_error = 'd1;
      else
        req.slave_error = 'd0;
      @(posedge reg_space_intf.clk);
      reg_space_intf.axi_bready = 'b0;
    endtask

    virtual task address_read_channel();
      @(posedge reg_space_intf.clk);
      reg_space_intf.axi_arprot = 'd0;
      reg_space_intf.axi_araddr = req.address;
      reg_space_intf.axi_arvalid = 'd1;
      wait(reg_space_intf.axi_arready == 'd1);
      @(posedge reg_space_intf.clk);
      reg_space_intf.axi_arvalid = 'd0;
      reg_space_intf.axi_araddr = 'd0;
    endtask

    virtual task data_read_channel();
      @(posedge reg_space_intf.clk);
      reg_space_intf.axi_rready = 'b1;
      wait(reg_space_intf.axi_rvalid == 'd1);
      req.data = reg_space_intf.axi_rdata;
      if(reg_space_intf.axi_rresp > 'd1)
        req.slave_error = 'd1;
      else
        req.slave_error = 'd0;
      @(posedge reg_space_intf.clk);
      reg_space_intf.axi_rready = 'b0;
    endtask

endclass : reg_space_driver