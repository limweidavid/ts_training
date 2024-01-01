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
  reg_space_random_write_sequence reg_space_seq;
  fifo_random_put_sequence fifo_put_sequence;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    reset_dut = reset_sequence::type_id::create("reset_dut", this);
    reg_space_seq = reg_space_random_write_sequence::type_id::create("reg_space_seq", this);
    fifo_put_sequence = fifo_random_put_sequence::type_id::create("fifo_put_sequence", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    reset_dut.start(my_env.fifo_agnt.seqr);
    reg_space_seq.start(my_env.reg_space_agnt.seqr);
    fifo_put_sequence.start(my_env.fifo_agnt.seqr);
    phase.drop_objection(this);
  endtask

endclass