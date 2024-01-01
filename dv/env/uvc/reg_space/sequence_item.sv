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

class reg_space_sequence_item extends uvm_sequence_item;

    rand bit [31:0] data;
    rand bit [31:0] address;
    rand bit write_read;
    
    bit slave_error;

    function new (string name = "reg_space_sequence_item");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(reg_space_sequence_item)
        `uvm_field_int(data, UVM_ALL_ON)
        `uvm_field_int(address, UVM_ALL_ON)
        `uvm_field_int(write_read, UVM_NOCOMPARE)
        `uvm_field_int(slave_error, UVM_NOCOMPARE)
    `uvm_object_utils_end

endclass : reg_space_sequence_item