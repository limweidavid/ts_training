///////////////////////////////////////////////////////////////////////////
//
// File name         : fifo_passive_agent.sv
// Author            : MARS
// Creation Date     : October 18, 2023
//
// No portions of this material may be reproduced in any form without
// the written permission of Thundersoft
//
// No portions of this material may be reproduced in any form without
// the written permission of Thundersoft
//
// Description : Passive Agent
//
///////////////////////////////////////////////////////////////////////////


class fifo_passive_agent extends uvm_agent;

  //Utility Macro (Factory Reagistration)
  `uvm_component_utils(fifo_passive_agent)

  //Constructor
  function new (string name = "fifo_passive_agent", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //Declaring Agent Components
  fifo_out_monitor mon ;

  //Build Phase
  function void build_phase(uvm_phase phase);

    `uvm_info("PASSIVE AGENT", "START BUILD PHASE", UVM_MEDIUM)
    super.build_phase(phase);
    mon = fifo_out_monitor::type_id::create("fifo_out_monitor", this);
    `uvm_info("PASSIVE AGENT", "END BUILD PHASE", UVM_MEDIUM)

  endfunction : build_phase


endclass : fifo_passive_agent