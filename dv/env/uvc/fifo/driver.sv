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

class fifo_driver extends uvm_driver #(fifo_sequence_item);

    `uvm_component_utils(fifo_driver)

    virtual fifo_interface fifo_intf;

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual fifo_interface)::get(this,"","vif",fifo_intf))
            `uvm_fatal(get_type_name(), "Interface not Found")
    endfunction

    virtual task run_phase (uvm_phase phase);
        forever begin
          seq_item_port.get_next_item(req);
          `uvm_info(get_full_name(), "Transaction Received", UVM_MEDIUM)
          req.print();
          if (req.reset_dut == 'd1) begin
              reset_dut();
          end else begin
            wait(fifo_intf.rstn == 'd1);
            fork
              put_to_dut();
              get_from_dut();
            join
          end
          seq_item_port.item_done();
        end
    endtask

    virtual task reset_dut();
        fifo_intf.rstn = 'd0;
        repeat(10)@(posedge fifo_intf.clk);
        fifo_intf.rstn = 'd1;
    endtask 

    virtual task put_to_dut();
        if(req.put_get == 'd0) begin
            @(posedge fifo_intf.clk);
            fifo_intf.S_AXIS_TDATA = req.data;
            fifo_intf.S_AXIS_TLAST = 'd1;
            fifo_intf.S_AXIS_TVALID = 'd1;
            wait(fifo_intf.S_AXIS_TREADY);
            @(posedge fifo_intf.clk);
            fifo_intf.S_AXIS_TLAST = 'd0;
            fifo_intf.S_AXIS_TVALID = 'd0;
        end
    endtask

    virtual task get_from_dut();
        if(req.put_get == 'd1) begin
            @(posedge fifo_intf.clk);
            fifo_intf.M_AXIS_TREADY = 'd1;
            wait(fifo_intf.M_AXIS_TVALID == 'd1);
            @(posedge fifo_intf.clk);
            fifo_intf.M_AXIS_TREADY = 'd0;
        end
    endtask

endclass : fifo_driver