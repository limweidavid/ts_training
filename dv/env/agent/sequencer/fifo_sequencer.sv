///////////////////////////////////////////////////////////////////////////
//
// File name         : sequencer.sv
// Author            : Syed Talha Tirmizi
// Creation Date     : November 07, 2022
//
// No portions of this material may be reproduced in any form without
// the written permission of Thundersoft
//
// No portions of this material may be reproduced in any form without
// the written permission of Thundersoft
//
// Description : Sequencer to send transactions generated by sequence 
// to the driver
//
///////////////////////////////////////////////////////////////////////////


class fifo_sequencer extends uvm_sequencer#(wrapper_item);

    //Utility Macro (Factory Reagistration)
    `uvm_component_utils(fifo_sequencer)

    //Constructor
    function new(string name ="fifo_sequencer", uvm_component parent);
      super.new(name, parent);
    endfunction : new

endclass : fifo_sequencer