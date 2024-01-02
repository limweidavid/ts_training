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

class fifo_random_sequence extends uvm_sequence #(fifo_sequence_item);
  
  `uvm_object_utils(fifo_random_sequence)

  function new(string name = "fifo_random_sequence");
    super.new(name);
  endfunction

  virtual task body();
    
    req = fifo_sequence_item::type_id::create("req");

    `uvm_info(get_type_name(), "----- Starting Sequence -----", UVM_MEDIUM)

    start_item(req);
    req.randomize();
    finish_item(req);

    `uvm_info(get_type_name(), "----- Ending Sequence -----", UVM_MEDIUM)

  endtask

endclass

class fifo_random_put_sequence extends uvm_sequence #(fifo_sequence_item);
  
  `uvm_object_utils(fifo_random_put_sequence)

  function new(string name = "fifo_random_put_sequence");
    super.new(name);
  endfunction

  virtual task body();
    
    req = fifo_sequence_item::type_id::create("req");

    `uvm_info(get_type_name(), "----- Starting Sequence -----", UVM_MEDIUM)


    start_item(req);
    req.randomize() with {put_get == 'd0;};
    finish_item(req);

    `uvm_info(get_type_name(), "----- Ending Sequence -----", UVM_MEDIUM)

  endtask
  
endclass

class fifo_random_bulk_put_sequence extends uvm_sequence #(fifo_sequence_item);
  
  `uvm_object_utils(fifo_random_bulk_put_sequence)

  function new(string name = "fifo_random_bulk_put_sequence");
    super.new(name);
  endfunction

  virtual task body();
    
    req = fifo_sequence_item::type_id::create("req");

    `uvm_info(get_type_name(), "----- Starting Sequence -----", UVM_MEDIUM)

    repeat(4) begin
      start_item(req);
      req.randomize() with {put_get == 'd0;};
      finish_item(req);
    end

    `uvm_info(get_type_name(), "----- Ending Sequence -----", UVM_MEDIUM)

  endtask
  
endclass

class fifo_directed_put_sequence extends uvm_sequence #(fifo_sequence_item);
  
  `uvm_object_utils(fifo_directed_put_sequence)

  bit [31:0] user_data;

  function new(string name = "fifo_directed_put_sequence");
    super.new(name);
  endfunction

  virtual task body();
    
    req = fifo_sequence_item::type_id::create("req");

    `uvm_info(get_type_name(), "----- Starting Sequence -----", UVM_MEDIUM)

    start_item(req);
    req.randomize() with {
      put_get == 'd0;
      data == user_data;
    };
    finish_item(req);

    `uvm_info(get_type_name(), "----- Ending Sequence -----", UVM_MEDIUM)

  endtask
  
endclass

class fifo_get_sequence extends uvm_sequence #(fifo_sequence_item);
  
  `uvm_object_utils(fifo_get_sequence)

  function new(string name = "fifo_get_sequence");
    super.new(name);
  endfunction

  virtual task body();
    
    req = fifo_sequence_item::type_id::create("req");

    `uvm_info(get_type_name(), "----- Starting Sequence -----", UVM_MEDIUM)

    start_item(req);
    req.randomize() with {put_get == 'd1;};
    finish_item(req);

    `uvm_info(get_type_name(), "----- Ending Sequence -----", UVM_MEDIUM)

  endtask
  
endclass

class fifo_random_bulk_get_sequence extends uvm_sequence #(fifo_sequence_item);
  
  `uvm_object_utils(fifo_random_bulk_get_sequence)

  function new(string name = "fifo_random_bulk_get_sequence");
    super.new(name);
  endfunction

  virtual task body();
    
    req = fifo_sequence_item::type_id::create("req");

    `uvm_info(get_type_name(), "----- Starting Sequence -----", UVM_MEDIUM)

    repeat(4) begin
      start_item(req);
      req.randomize() with {put_get == 'd1;};
      finish_item(req);
    end

    `uvm_info(get_type_name(), "----- Ending Sequence -----", UVM_MEDIUM)

  endtask
  
endclass

class reset_sequence extends uvm_sequence #(fifo_sequence_item);
  
  `uvm_object_utils(reset_sequence)

  function new(string name = "reset_sequence");
    super.new(name);
  endfunction

  virtual task body();
    
    req = fifo_sequence_item::type_id::create("req");
    
    `uvm_info(get_type_name(), "----- Starting Sequence -----", UVM_MEDIUM)

    `uvm_create(req);
    req.randomize();
    req.reset_dut = 'd1;
    `uvm_send(req);

    `uvm_info(get_type_name(), "----- Ending Sequence -----", UVM_MEDIUM)

  endtask
  
endclass
