`include "uvm_macros.svh"
`include "env/uvc/fifo/fifo_uvc_package.sv"
`include "env/uvc/reg_space/reg_space_uvc_package.sv"
package dut_uvm_package;
  import uvm_pkg::*;
  import fifo_uvc_package::*;
  import reg_space_uvc_package::*;

  `include "env/environment.sv"
  //`inlcude "env/scoreboard.sv"
  `include "sequences/fifo_sequences.sv"
  `include "sequences/reg_space_sequences.sv"
  `include "tests/dut_tests.sv"
endpackage