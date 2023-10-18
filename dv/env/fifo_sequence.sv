///////////////////////////////////////////////////////////////////////////
//
// File name         : fifo_sequence.sv
// Author            : MARS
// Creation Date     : October 18, 2023
//
// No portions of this material may be reproduced in any form without
// the written permission of Thundersoft
//
// No portions of this material may be reproduced in any form without
// the written permission of Thundersoft
//
// Description : Sequence to generate the transactions for sequence item
//
///////////////////////////////////////////////////////////////////////////


class fifo_sequence extends uvm_sequence#(fifo_transaction);

  //Utility Macro (Factory Reagistration)
  `uvm_object_utils(fifo_sequence)

  //FIFO item instance
  fifo_transaction  fifo_item ;

  //Constructor
  function new(string name ="fifo_sequence");
    super.new(name);
  endfunction : new

  //Body Task
  virtual task body();

    `uvm_info("FIFO SEQUENCE", $sformatf("START BODY TASK"), UVM_MEDIUM)
    fifo_item = fifo_transaction::type_id::create("fifo_item");
    repeat (10) begin
      start_item(fifo_item);
      fifo_item.my_random();
      finish_item(fifo_item);
    end
    `uvm_info("FIFO SEQUENCE", $sformatf("END BODY TASK"), UVM_MEDIUM)

  endtask : body

endclass : fifo_sequence