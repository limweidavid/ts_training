///////////////////////////////////////////////////////////////////////////
//
// File name         : sequencer.sv
// Author            : Shamaim
// Creation Date     : December 29, 2023
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

class fifo_sequencer extends uvm_sequencer #(fifo_sequence_item);

`uvm_component_utils(fifo_sequencer)
  
function new(string name, uvm_component parent);
  super.new(name,parent);
endfunction
  
endclass : fifo_sequencer