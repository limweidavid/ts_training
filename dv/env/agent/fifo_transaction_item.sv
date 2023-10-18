///////////////////////////////////////////////////////////////////////////
//
// File name         : fifo_transaction_item.sv
// Author            : MARS
// Creation Date     : October 18, 2023
//
// No portions of this material may be reproduced in any form without
// the written permission of Thundersoft
//
// No portions of this material may be reproduced in any form without
// the written permission of Thundersoft
//
// Description : Sequence item for generating wrapper trasactions
//
///////////////////////////////////////////////////////////////////////////


class fifo_transaction extends uvm_sequence_item;

  //Constructor
  function new(string name ="fifo_transaction");
    super.new(name);
  endfunction : new

  //Data and Control Fields
  //Inputs
  bit          wr_en;
  bit          rd_en;
  bit [7:0]    wr_data;
  //Outputs
  bit [7:0]   rd_data;
  bit          empty,full;

  //Utility Macro (Factory Reagistration)
  `uvm_object_utils_begin(fifo_transaction)
  `uvm_field_int(wr_en, UVM_ALL_ON)
  `uvm_field_int(rd_en, UVM_ALL_ON)
  `uvm_field_int(wr_data, UVM_ALL_ON)
  `uvm_field_int(rd_data, UVM_ALL_ON)
  `uvm_field_int(empty, UVM_ALL_ON)
  `uvm_field_int(full, UVM_ALL_ON)
  `uvm_object_utils_end

  //Randomizee Function
  function void my_random();
    this.wr_data = $urandom_range(1,255);
  endfunction : my_random

  //Display Function
  function void print(string name = "FIFO TRANSACTION");
    `uvm_info(name,$sformatf("\nwr_data = %d, wr_en = %0d",wr_data, wr_en), UVM_MEDIUM)
    `uvm_info(name,$sformatf("\nrd_data = %0d, rd_en = %0d",rd_data, rd_en), UVM_MEDIUM)
  endfunction : print

endclass : fifo_transaction