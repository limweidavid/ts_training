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

class dut_base_test extends uvm_test;
  
  `uvm_component_utils (dut_base_test)

  dut_environment my_env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    my_env = dut_environment::type_id::create("my_env", this);
  endfunction

endclass

class fifo_random_put_test extends dut_base_test;

  `uvm_component_utils (fifo_random_put_test)

  reset_sequence reset_dut;
  fifo_random_bulk_put_sequence fifo_put_sequence;
  fifo_random_bulk_get_sequence fifo_get_sequence;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    reset_dut = reset_sequence::type_id::create("reset_dut", this);
    fifo_put_sequence = fifo_random_bulk_put_sequence::type_id::create("fifo_put_sequence", this);
    fifo_get_sequence = fifo_random_bulk_get_sequence::type_id::create("fifo_get_sequence", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    reset_dut.start(my_env.fifo_agnt.seqr);
    fifo_put_sequence.start(my_env.fifo_agnt.seqr);
    fifo_get_sequence.start(my_env.fifo_agnt.seqr);
    phase.drop_objection(this);
  endtask

endclass

class reg_space_directed_rw_test extends dut_base_test;

  `uvm_component_utils (reg_space_directed_rw_test)

  reset_sequence reset_dut;
  reg_space_directed_write_sequence reg_wr_sequence;
  reg_space_directed_read_sequence reg_rd_sequence;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    reset_dut = reset_sequence::type_id::create("reset_dut", this);
    reg_wr_sequence = reg_space_directed_write_sequence::type_id::create("reg_wr_sequence", this);
    reg_rd_sequence = reg_space_directed_read_sequence::type_id::create("reg_rd_sequence", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    reset_dut.start(my_env.fifo_agnt.seqr);

    reg_wr_sequence.user_data = 'h5A5A5A5A;
    reg_wr_sequence.user_address = 'h04;
    reg_wr_sequence.start(my_env.reg_space_agnt.seqr);

    reg_rd_sequence.user_address = 'h04;
    reg_rd_sequence.start(my_env.reg_space_agnt.seqr);
    phase.drop_objection(this);
  endtask

endclass

class reg_space_single_random_rw_test extends dut_base_test;

  `uvm_component_utils (reg_space_single_random_rw_test)

  reset_sequence reset_dut;
  reg_space_random_write_sequence reg_wr_sequence;
  reg_space_random_read_sequence reg_rd_sequence;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    reset_dut = reset_sequence::type_id::create("reset_dut", this);
    reg_wr_sequence = reg_space_random_write_sequence::type_id::create("reg_wr_sequence", this);
    reg_rd_sequence = reg_space_random_read_sequence::type_id::create("reg_rd_sequence", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    reset_dut.start(my_env.fifo_agnt.seqr);

    reg_wr_sequence.start(my_env.reg_space_agnt.seqr);

    reg_rd_sequence.start(my_env.reg_space_agnt.seqr);
    phase.drop_objection(this);
  endtask

endclass

class reg_space_mult_random_rw_test extends dut_base_test;

  `uvm_component_utils (reg_space_mult_random_rw_test)

  reset_sequence reset_dut;
  reg_space_random_write_sequence reg_wr_sequence;
  reg_space_random_read_sequence reg_rd_sequence;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    reset_dut = reset_sequence::type_id::create("reset_dut", this);
    reg_wr_sequence = reg_space_random_write_sequence::type_id::create("reg_wr_sequence", this);
    reg_rd_sequence = reg_space_random_read_sequence::type_id::create("reg_rd_sequence", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    reset_dut.start(my_env.fifo_agnt.seqr);

    reg_wr_sequence.repeat_transaction = 'd20;
    reg_wr_sequence.start(my_env.reg_space_agnt.seqr);
    
    reg_rd_sequence.repeat_transaction = 'd20;
    reg_rd_sequence.start(my_env.reg_space_agnt.seqr);

    phase.drop_objection(this);
  endtask

endclass