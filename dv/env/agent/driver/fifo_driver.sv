///////////////////////////////////////////////////////////////////////////
//
// File name         : fifo_driver.sv
// Author            : MARS
// Creation Date     : October 18, 2023
//
// No portions of this material may be reproduced in any form without
// the written permission of Thundersoft
//
// No portions of this material may be reproduced in any form without
// the written permission of Thundersoft
//
// Description : fifo_driver to drive the signals on DUT using interface
//
///////////////////////////////////////////////////////////////////////////


class fifo_driver extends uvm_driver#(fifo_transaction);

  //Utility Macro (Factory Reagistration)
  `uvm_component_utils(fifo_driver)

  //Constructor
  function new(string name ="fifo_driver", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //Virtual Interface
  virtual fifo_if vif;

  //Sequence item handle
  fifo_transaction fifo_item;

  //Built Phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //`uvm_info("fifo_driver", "START BUILD PHASE", UVM_MEDIUM)
    fifo_item = fifo_transaction::type_id::create("fifo_item", this);
    if(!uvm_config_db#(virtual fifo_if)::get(this, "", "fifo_if", vif))
      `uvm_fatal("fifo_driver","Virtual Interface Failed")
    //`uvm_info("fifo_driver", "END BUILD PHASE", UVM_MEDIUM)

  endfunction : build_phase

  //Run Phase
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("fifo_driver", "START RUN PHASE", UVM_MEDIUM)
    forever begin
      seq_item_port.get_next_item(fifo_item);
      drive(fifo_item);
      seq_item_port.item_done();
      vif.wr_en <= 0;
    end
    `uvm_info("fifo_driver", "END RUN PHASE", UVM_MEDIUM)

  endtask : run_phase

  //Drive Task
  virtual task drive(fifo_transaction drv_fifo_item);
    vif.write_enable <= drv_fifo_item.wr_en;
    vif.data_in      <= drv_fifo_item.wr_data;
    @(posedge vif.clk);
    $display("INPUT INTERFACE-----data_in = %b write_enable = %0d\n\n\n",vif.wr_data, vif.wr_en);
  endtask : drive

endclass : fifo_driver