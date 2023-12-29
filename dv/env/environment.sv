class dut_environment extends uvm_environment;

  `uvm_component_utils(dut_environment)

  fifo_agent       fifo_agent;
  dut_scoreboard  scoreboard;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function build_phase(uvm_phase phase);
    super.build_phase(phase);

    tx_agent = fifo_agent::type_id::create("tx_agent", this);
    scoreboard = dut_scoreboard::type_id::create("scoreboard", this);
  endfunction

  function connect_phase(uvm_phase phase);
    tx_agent.master_port.connect(scoreboard.);
    tx_agent.slave_port.connect(scoreboard.);
  endfunction

endclass : dut_environment