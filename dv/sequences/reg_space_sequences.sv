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

class reg_space_random_sequence extends uvm_sequence #(reg_space_sequence_item);
  
  `uvm_object_utils(reg_space_random_sequence)

  function new(string name = "reg_space_random_sequence");
    super.new(name);
  endfunction

  virtual task body();
    
    req = reg_space_sequence_item::type_id::create("req");

    `uvm_info(get_type_name(), "----- Starting Sequence -----", UVM_MEDIUM)

    start_item(req);
    req.randomize();
    finish_item(req);

    `uvm_info(get_type_name(), "----- Ending Sequence -----", UVM_MEDIUM)

  endtask

endclass

class reg_space_random_write_sequence extends uvm_sequence #(reg_space_sequence_item);
  
  `uvm_object_utils(reg_space_random_write_sequence)

  function new(string name = "reg_space_random_write_sequence");
    super.new(name);
  endfunction

  virtual task body();
    
    req = reg_space_sequence_item::type_id::create("req");

    `uvm_info(get_type_name(), "----- Starting Sequence -----", UVM_MEDIUM)

    start_item(req);
    req.randomize() with {
      write_read == 'd0;
    };
    finish_item(req);

    `uvm_info(get_type_name(), "----- Ending Sequence -----", UVM_MEDIUM)

  endtask

endclass

class reg_space_directed_write_sequence extends uvm_sequence #(reg_space_sequence_item);
  
  `uvm_object_utils(reg_space_directed_write_sequence)

  bit [31:0] user_data;
  bit [31:0] user_address;

  function new(string name = "reg_space_directed_write_sequence");
    super.new(name);
  endfunction

  virtual task body();
    
    req = reg_space_sequence_item::type_id::create("req");

    `uvm_info(get_type_name(), "----- Starting Sequence -----", UVM_MEDIUM)

    start_item(req);
    req.randomize() with {
      write_read == 'd0;
      data == user_data;
      address == user_address;
    };
    finish_item(req);

    `uvm_info(get_type_name(), "----- Ending Sequence -----", UVM_MEDIUM)

  endtask

endclass

class reg_space_random_read_sequence extends uvm_sequence #(reg_space_sequence_item);
  
  `uvm_object_utils(reg_space_random_read_sequence)

  function new(string name = "reg_space_random_read_sequence");
    super.new(name);
  endfunction

  virtual task body();
    
    req = reg_space_sequence_item::type_id::create("req");

    `uvm_info(get_type_name(), "----- Starting Sequence -----", UVM_MEDIUM)

    start_item(req);
    req.randomize() with {
      write_read == 'd1;
    };
    finish_item(req);

    `uvm_info(get_type_name(), "----- Ending Sequence -----", UVM_MEDIUM)

  endtask

endclass

class reg_space_directed_read_sequence extends uvm_sequence #(reg_space_sequence_item);
  
  `uvm_object_utils(reg_space_directed_write_sequence)

  bit [31:0] user_address;

  function new(string name = "reg_space_directed_read_sequence");
    super.new(name);
  endfunction

  virtual task body();
    
    req = reg_space_sequence_item::type_id::create("req");

    `uvm_info(get_type_name(), "----- Starting Sequence -----", UVM_MEDIUM)

    start_item(req);
    req.randomize() with {
      write_read == 'd0;
      address == user_address;
    };
    finish_item(req);

    `uvm_info(get_type_name(), "----- Ending Sequence -----", UVM_MEDIUM)

  endtask

endclass