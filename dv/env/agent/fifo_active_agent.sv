///////////////////////////////////////////////////////////////////////////
//
// File name         : fifo_active_agent.sv
// Author            : MARS
// Creation Date     : October 18, 2023
//
// No portions of this material may be reproduced in any form without
// the written permission of Thundersoft
//
// No portions of this material may be reproduced in any form without
// the written permission of Thundersoft
//
// Description : Active agent
//
///////////////////////////////////////////////////////////////////////////


class fifo_active_agent extends uvm_agent;

  //Utility Macro (Factory Reagistration)
  `uvm_component_utils(fifo_active_agent)

  //Constructor
  function new (string name = "fifo_active_agent", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //Declaring Agent Components
  fifo_driver        drv ;
  fifo_sequencer          seqr;
  fifo_inp_monitor   mon ;

  //Build Phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info("ACTIVE AGENT", "START BUILD PHASE", UVM_MEDIUM)
    seqr = fifo_sequencer::type_id::create("seqr", this);
    drv = fifo_driver::type_id::create("drv", this);
    mon = fifo_inp_monitor::type_id::create("mon", this);
    `uvm_info("ACTIVE AGENT", "END BUILD PHASE", UVM_MEDIUM)

  endfunction : build_phase

  //Connect Phase
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    `uvm_info("PASSIVE AGENT", "START CONNECT PHASE", UVM_MEDIUM)
    drv.seq_item_port.connect(seqr.seq_item_export);
    `uvm_info("PASSIVE AGENT", "END CONNECT PHASE", UVM_MEDIUM)

  endfunction : connect_phase

endclass : fifo_active_agent