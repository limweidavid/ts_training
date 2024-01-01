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

class fifo_master_monitor extends uvm_monitor;
    
    `uvm_component_utils(fifo_master_monitor)

    virtual fifo_interface fifo_intf;
    
    uvm_analysis_port #(fifo_sequence_item) mon2scb_port;

    fifo_sequence_item seq_item;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        mon2scb_port = new("mon2scb_port", this);
        if(!uvm_config_db #(virtual fifo_interface)::get(this,"","vif", fifo_intf))
          `uvm_fatal(get_type_name(), "Interface not Found")
    endfunction

    virtual task run_phase (uvm_phase phase);
        forever begin
          monitor_data();
        end
    endtask

    virtual task monitor_data();
        @(posedge fifo_intf.clk);
        if(fifo_intf.M_AXIS_TVALID == 'd1 && fifo_intf.M_AXIS_TREADY == 'd1) begin
            seq_item.data = fifo_intf.M_AXIS_TDATA;
            mon2scb_port.write(seq_item);
        end
    endtask 
endclass

class fifo_slave_monitor extends uvm_monitor;
    
    `uvm_component_utils(fifo_slave_monitor)

    virtual fifo_interface fifo_intf;
    
    uvm_analysis_port #(fifo_sequence_item) mon2scb_port;

    fifo_sequence_item seq_item;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        mon2scb_port = new("mon2scb_port", this);
        if(!uvm_config_db #(virtual fifo_interface)::get(this,"","vif", fifo_intf))
          `uvm_fatal(get_type_name(), "Interface not Found")
    endfunction

    virtual task run_phase (uvm_phase phase);
        forever begin
          monitor_data();
        end
    endtask

    virtual task monitor_data();
        @(posedge fifo_intf.clk);
        if(fifo_intf.S_AXIS_TVALID == 'd1 && fifo_intf.S_AXIS_TREADY == 'd1) begin
            seq_item.data = fifo_intf.S_AXIS_TDATA;
            mon2scb_port.write(seq_item);
        end
    endtask 
endclass