///////////////////////////////////////////////////////////////////////////
//
// File name         : sequence_item.sv
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

class fifo_sequence_item extends uvm_sequence_item;

    rand bit [31:0] data;
    rand bit put_get;

    bit reset_dut;

    function new (string name = "fifo_sequence_item");
        super.new(name);
        reset_dut = 'd0;
    endfunction

    `uvm_object_utils_begin(fifo_sequence_item)
        `uvm_field_int(data, UVM_ALL_ON)
        `uvm_field_int(put_get, UVM_NOCOMPARE)
        `uvm_field_int(reset_dut, UVM_NOCOMPARE)
    `uvm_object_utils_end

endclass : fifo_sequence_item