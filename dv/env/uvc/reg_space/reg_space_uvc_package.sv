`include "uvm_macros.svh"
package reg_space_uvc_package;
  import uvm_pkg::*;

  `include "env/uvc/reg_space/sequence_item.sv"
  `include "env/uvc/reg_space/sequencer.sv"
  `include "env/uvc/reg_space/driver.sv"
  `include "env/uvc/reg_space/monitor.sv"
  `include "env/uvc/reg_space/agent.sv"
endpackage