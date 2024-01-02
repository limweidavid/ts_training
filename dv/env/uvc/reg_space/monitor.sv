///////////////////////////////////////////////////////////////////////////
//
// File name         : monitor.sv
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

class reg_space_write_channel_monitor extends uvm_monitor;
    
    `uvm_component_utils(reg_space_write_channel_monitor)

    virtual reg_space_interface reg_space_intf;
    
    uvm_analysis_port #(reg_space_sequence_item) mon2scb_port;

    reg_space_sequence_item seq_item;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        mon2scb_port = new("mon2scb_port", this);
        if(!uvm_config_db #(virtual reg_space_interface)::get(this,"","vif", reg_space_intf))
          `uvm_fatal(get_type_name(), "Interface not Found")
    endfunction

    virtual task run_phase (uvm_phase phase);
        seq_item = reg_space_sequence_item::type_id::create("seq_item", this);
        forever begin
          fork
            address_write_channel();
            data_write_channel();
            bresp_channel();
          join
        end
    endtask

    virtual task address_write_channel();
      @(posedge reg_space_intf.clk);
      if(reg_space_intf.axi_awvalid == 'd1 && reg_space_intf.axi_awready == 'd1) begin
        seq_item.address = reg_space_intf.axi_awaddr;
        `uvm_info(get_type_name(), $sformatf("[AW-Channel] Address: %0h", seq_item.address), UVM_MEDIUM)
      end
    endtask

    virtual task data_write_channel();
      @(posedge reg_space_intf.clk);
      if(reg_space_intf.axi_wvalid == 'd1 && reg_space_intf.axi_wready == 'd1) begin
        seq_item.data = reg_space_intf.axi_wdata;
        `uvm_info(get_type_name(), $sformatf("[W-Channel] Data: %0h", seq_item.data), UVM_MEDIUM)
      end
    endtask

    virtual task bresp_channel();
      @(posedge reg_space_intf.clk);
      if(reg_space_intf.axi_bvalid == 'd1 && reg_space_intf.axi_bready == 'd1) begin
        if(reg_space_intf.axi_bresp > 'd1) begin
        seq_item.slave_error = 'd1;
        `uvm_info(get_type_name(), $sformatf("[BRESP-Channel] BRESP: %0h", reg_space_intf.axi_bresp), UVM_MEDIUM)
        `uvm_info(get_type_name(), $sformatf("----- Write Access Failed -----"), UVM_MEDIUM)
        end else begin
        seq_item.slave_error = 'd0;
        `uvm_info(get_type_name(), $sformatf("----- Write Access Successful -----"), UVM_MEDIUM)
        end

        mon2scb_port.write(seq_item);
      end
    endtask
endclass

class reg_space_read_channel_monitor extends uvm_monitor;
    
    `uvm_component_utils(reg_space_read_channel_monitor)

    virtual reg_space_interface reg_space_intf;
    
    uvm_analysis_port #(reg_space_sequence_item) mon2scb_port;

    reg_space_sequence_item seq_item;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        mon2scb_port = new("mon2scb_port", this);
        if(!uvm_config_db #(virtual reg_space_interface)::get(this,"","vif", reg_space_intf))
          `uvm_fatal(get_type_name(), "Interface not Found")
    endfunction

    virtual task run_phase (uvm_phase phase);
        seq_item = reg_space_sequence_item::type_id::create("seq_item", this);
        forever begin
          fork
            address_read_channel();
            data_read_channel();
          join
        end
    endtask

    virtual task address_read_channel();
      @(posedge reg_space_intf.clk);
      if(reg_space_intf.axi_arvalid == 'd1 && reg_space_intf.axi_arready == 'd1) begin
        seq_item.address = reg_space_intf.axi_araddr;
        `uvm_info(get_type_name(), $sformatf("[AR-Channel] Address: %0h", seq_item.address), UVM_MEDIUM)
      end
    endtask

    virtual task data_read_channel();
      @(posedge reg_space_intf.clk);
      if(reg_space_intf.axi_rvalid == 'd1 && reg_space_intf.axi_rready == 'd1) begin
        seq_item.data = reg_space_intf.axi_rdata;
        `uvm_info(get_type_name(), $sformatf("[R-Channel] Data: %0h", seq_item.data), UVM_MEDIUM)
        if(reg_space_intf.axi_rresp > 'd1) begin
        seq_item.slave_error = 'd1;
        `uvm_info(get_type_name(), $sformatf("[R-Channel] BRESP: %0h", reg_space_intf.axi_rresp), UVM_MEDIUM)
        `uvm_info(get_type_name(), $sformatf("----- Read Access Failed -----"), UVM_MEDIUM)
        end else begin
        seq_item.slave_error = 'd0;
        `uvm_info(get_type_name(), $sformatf("----- Read Access Successful -----"), UVM_MEDIUM)
        end
        mon2scb_port.write(seq_item);
      end
    endtask

endclass