`include "uvm_macros.svh"
package fifo_uvc_package;
  import uvm_pkg::*;

  `include "env/uvc/fifo/sequence_item.sv"
  `include "env/uvc/fifo/sequencer.sv"
  `include "env/uvc/fifo/driver.sv"
  `include "env/uvc/fifo/monitor.sv"
  `include "env/uvc/fifo/agent.sv"
endpackage