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

class reg_space_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils (reg_space_scoreboard)

  `uvm_analysis_imp_decl(_from_write_channel_monitor)
  `uvm_analysis_imp_decl(_from_read_channel_monitor)

  uvm_analysis_imp_from_write_channel_monitor #(reg_space_sequence_item, reg_space_scoreboard) write_channel_import;
  uvm_analysis_imp_from_read_channel_monitor #(reg_space_sequence_item, reg_space_scoreboard) read_channel_import;

  reg_space_sequence_item write_channel_data [$];
  reg_space_sequence_item read_channel_data [$];

  bit [31:0] reference_memory [0:7];

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);

    write_channel_import = new ("write_channel_import", this);
    read_channel_import = new ("read_channel_import", this);
  endfunction

  virtual function void write_from_write_channel_monitor (reg_space_sequence_item data);
    `uvm_info (get_type_name(), "Write Transaction Received from Write Monitor", UVM_MEDIUM)
    write_channel_data.push_back(data);
  endfunction

  virtual function void write_from_read_channel_monitor (reg_space_sequence_item data);
    `uvm_info (get_type_name(), "Read Transaction Received from Read Monitor", UVM_MEDIUM)
    read_channel_data.push_back(data);
  endfunction

  virtual task run_phase (uvm_phase phase);
    forever begin
      fork
        write_received ();
        read_check ();
      join_any
    end
  endtask

  virtual task read_check ();
    reg_space_sequence_item read_item;

    wait (read_channel_data.size > 0);
    if (read_channel_data.size > 0) begin
      read_item = read_channel_data.pop_front();
      
      if (read_item.data == reference_memory [read_item.address])
        `uvm_info (get_type_name(), $sformatf("Address: %0h, -> Expected Data: %0h, Received Data: %0h ----- DATA MATCHED", read_item.address, reference_memory [read_item.address], read_item.data), UVM_MEDIUM)
      else
        `uvm_fatal (get_type_name(), $sformatf("Address: %0h, -> Expected Data: %0h, Received Data: %0h ----- DATA ERROR", read_item.address, reference_memory [read_item.address], read_item.data))
    end
  endtask

  virtual task write_received ();
    reg_space_sequence_item write_item;

    wait (write_channel_data.size > 0);
    if (write_channel_data.size > 0) begin
      write_item = write_channel_data.pop_front();
      reference_memory [write_item.address] = write_item.data;

      `uvm_info (get_type_name(), $sformatf("REFERENCE MODEL UPDATED --- Address: %0h, Data: %0h", write_item.address, reference_memory [write_item.address]), UVM_MEDIUM)
    end
  endtask

endclass

`uvm_analysis_imp_decl(_from_master_monitor)
`uvm_analysis_imp_decl(_from_slave_monitor)

class fifo_scoreboard extends uvm_scoreboard;

  `uvm_component_utils (fifo_scoreboard)

  `uvm_analysis_imp_decl(_from_master_monitor)
  `uvm_analysis_imp_decl(_from_slave_monitor)

  uvm_analysis_imp_from_master_monitor #(fifo_sequence_item, fifo_scoreboard) master_import;
  uvm_analysis_imp_from_slave_monitor #(fifo_sequence_item, fifo_scoreboard) slave_import;

  fifo_sequence_item master_data [$];
  fifo_sequence_item slave_data [$];

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);

    master_import = new ("master_import", this);
    slave_import = new ("slave_import", this);
  endfunction

  virtual function void write_from_master_monitor (fifo_sequence_item data);
    `uvm_info (get_type_name(), $sformatf("FIFO TRANSACTION --- TYPE=GET: %0h", data.data), UVM_MEDIUM)
    master_data.push_back(data);
  endfunction

  virtual function void write_from_slave_monitor (fifo_sequence_item data);
    `uvm_info (get_type_name(), $sformatf("FIFO TRANSACTION --- TYPE=PUT: %0h", data.data), UVM_MEDIUM)
    slave_data.push_back(data);
  endfunction

  virtual task run_phase(uvm_phase phase);
    fifo_sequence_item master_pkt;
    fifo_sequence_item slave_pkt;

    forever begin

      wait (master_data.size() > 0 && slave_data.size() > 0);

      master_pkt = master_data.pop_front();
      slave_pkt = slave_data.pop_front();

      if(master_pkt.compare(slave_pkt)) begin
        `uvm_info (get_type_name(), $sformatf("FIFO VALID DATA RECEIVED --- PUT DATA: %0h, GET DATA: %0h", slave_pkt.data, master_pkt.data), UVM_MEDIUM)
      end else begin
        `uvm_fatal (get_type_name(), $sformatf("FIFO DATA INVALID --- PUT DATA: %0h, GET DATA: %0h", slave_pkt.data, master_pkt.data))
      end

    end

  endtask
endclass