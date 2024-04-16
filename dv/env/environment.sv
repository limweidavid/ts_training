///////////////////////////////////////////////////////////////////////////
//
// File name         : 
// Author            : Shamaim
// Creation Date     : January 1st, 2024
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

class dut_environment extends uvm_env;

  `uvm_component_utils(dut_environment)

  fifo_agent                fifo_agnt;
  reg_space_agent           reg_space_agnt;
  reg_space_scoreboard      reg_space_scb;
  fifo_scoreboard           fifo_scb;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    fifo_agnt = fifo_agent::type_id::create("fifo_agnt", this);
    reg_space_agnt = reg_space_agent::type_id::create("reg_space_agnt", this);
    reg_space_scb = reg_space_scoreboard::type_id::create("reg_space_scb", this);
    fifo_scb = fifo_scoreboard::type_id::create("fifo_scb", this);

  endfunction : build_phase

  function void connect_phase (uvm_phase phase); 
    reg_space_agnt.write_channel_port.connect(reg_space_scb.write_channel_import);
    reg_space_agnt.read_channel_port.connect(reg_space_scb.read_channel_import);

    fifo_agnt.master_port.connect(fifo_scb.master_import);
    fifo_agnt.slave_port.connect(fifo_scb.slave_import);
  endfunction : connect_phase

endclass : dut_environment