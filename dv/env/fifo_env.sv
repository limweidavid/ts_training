///////////////////////////////////////////////////////////////////////////
//
// File name         : fifo_env.sv
// Author            : MARS
// Creation Date     : October 18, 2023
//
// No portions of this material may be reproduced in any form without
// the written permission of Thundersoft
//
// No portions of this material may be reproduced in any form without
// the written permission of Thundersoft
//
// Description : Environment
//
///////////////////////////////////////////////////////////////////////////


class fifo_env extends uvm_env;

  //Utility Macro (Factory Reagistration)
  `uvm_component_utils(fifo_env)

  //Constructor
  function new(string name="fifo_env", uvm_component parent);
    super.new(name, parent);
  endfunction


  //Internal Signals and Handles Declaration
  active_agent  inp_agnt ;
  passive_agent out_agnt ;
  scoreboard    scb      ;

  //Sequence item handle
  fifo_sequence fifo_seq;
  common_config wrapper_config;


  //Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info("ENVIRONMENT", "START BUILD PHASE", UVM_LOW)
    // Creating Agents Scoreboard
    inp_agnt = active_agent::type_id::create("inp_agnt", this);
    out_agnt = passive_agent::type_id::create("out_agnt", this);
    scb      = scoreboard::type_id::create("scb", this);
    fifo_seq = fifo_sequence::type_id::create("fifo_sequence",this);
    scb_event = uvm_event_pool::get_global("scb_event");
    uvm_config_db #(common_config)::get(this, "*", "common_cfg", wrapper_config);
    `uvm_info("ENVIRONMENT", "END BUILD PHASE", UVM_LOW)

  endfunction : build_phase

  //Connect Phase
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    `uvm_info("ENVIRONMENT", "START CONNECT PHASE", UVM_LOW)
    inp_agnt.mon.inp_mon_analysis_port.connect(scb.inp_imp_export);
    out_agnt.mon.out_mon_analysis_port.connect(scb.out_imp_export);
    `uvm_info("ENVIRONMENT", "END CONNECT PHASE", UVM_LOW)

  endfunction : connect_phase

  //Run Phase
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    `uvm_info("ENVIRONMENT", $sformatf("START RUN PHASE"), UVM_LOW)
    phase.raise_objection(this);
    fifo_seq = new();
    fifo_seq.start(inp_agnt.seqr);

    fork
      begin
        #(wrapper_config.watchdog_timer);
        `uvm_error("ENVIRONMENT", $sformatf("TIMER TIMED OUT"))
      end
      begin
        scb_event.wait_trigger();
        #50000; // idle cycles
        `uvm_info("ENVIRONMENT", "SCOREBOARD VERIFICATION COMPLETE", UVM_LOW)
      end
    join_any

    phase.drop_objection(this);
    `uvm_info("ENVIRONMENT", $sformatf("END RUN PHASE"), UVM_LOW)

  endtask : run_phase

endclass