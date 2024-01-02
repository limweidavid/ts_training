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

  fifo_agent fifo_agnt;
  reg_space_agent reg_space_agnt;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    fifo_agnt = fifo_agent::type_id::create("fifo_agnt", this);
    reg_space_agnt = reg_space_agent::type_id::create("reg_space_agnt", this);
  endfunction

endclass : dut_environment