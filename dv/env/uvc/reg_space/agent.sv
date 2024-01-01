class reg_space_agent extends uvm_agent;
  `uvm_component_utils (reg_space_agent)

  reg_space_sequencer seqr;
  reg_space_driver drvr;
  reg_space_write_channel_monitor wr_mntr;
  reg_space_read_channel_monitor rd_mntr;

  uvm_analysis_port #(reg_space_sequence_item) write_channel_port;
  uvm_analysis_port #(reg_space_sequence_item) read_channel_port;

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);

    write_channel_port = new ("write_channel_port", this);
    read_channel_port = new ("read_channel_port", this);

    wr_mntr = reg_space_write_channel_monitor::type_id::create("wr_mntr", this);
    rd_mntr = reg_space_read_channel_monitor::type_id::create("rd_mntr", this);
  
    if (get_is_active()) begin
      seqr = reg_space_sequencer::type_id::create("seqr", this);
      drvr = reg_space_driver::type_id::create("drvr", this);
    end
  endfunction : build_phase

  function void connect_phase (uvm_phase phase); 
    wr_mntr.mon2scb_port.connect(write_channel_port);
    rd_mntr.mon2scb_port.connect(read_channel_port);

    if(get_is_active()) begin
      drvr.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction : connect_phase

endclass