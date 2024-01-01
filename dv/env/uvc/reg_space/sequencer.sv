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

class reg_space_sequencer extends uvm_sequencer #(reg_space_sequence_item);

`uvm_component_utils(reg_space_sequencer)
  
function new(string name, uvm_component parent);
  super.new(name,parent);
endfunction
  
endclass : reg_space_sequencer