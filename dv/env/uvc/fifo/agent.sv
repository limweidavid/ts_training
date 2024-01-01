class fifo_agent extends uvm_agent;
  `uvm_component_utils (fifo_agent)

  fifo_sequencer seqr;
  fifo_driver drvr;
  fifo_master_monitor m_mntr;
  fifo_slave_monitor s_mntr;

  uvm_analysis_port #(fifo_sequence_item) master_port;
  uvm_analysis_port #(fifo_sequence_item) slave_port;

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);

    master_port = new ("master_port", this);
    slave_port = new ("slave_port", this);

    m_mntr = fifo_master_monitor::type_id::create("m_mntr", this);
    s_mntr = fifo_slave_monitor::type_id::create("s_mntr", this);
  
    if (get_is_active()) begin
      seqr = fifo_sequencer::type_id::create("seqr", this);
      drvr = fifo_driver::type_id::create("drvr", this);
    end
  endfunction : build_phase

  function void connect_phase (uvm_phase phase); 
    m_mntr.mon2scb_port.connect(master_port);
    s_mntr.mon2scb_port.connect(slave_port);

    if(get_is_active()) begin
      drvr.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction : connect_phase

endclass