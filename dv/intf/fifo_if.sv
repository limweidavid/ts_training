///////////////////////////////////////////////////////////////////////////
//
// File name         : fifo_if.sv
// Author            : Shamaim
// Creation Date     : December 27, 2023
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

interface fifo_if #(parameter WIDTH=8) (input clk);
    
    logic             rstn;
    // SLAVE INTERFACE
    logic             S_AXIS_TREADY;
    logic [WIDTH-1:0] S_AXIS_TDATA ;
    logic             S_AXIS_TLAST ;
    logic             S_AXIS_TVALID;
    // MASTER INTERFACE
    logic             M_AXIS_TVALID;
    logic [WIDTH-1:0] M_AXIS_TDATA ;
    logic             M_AXIS_TLAST ;
    logic             M_AXIS_TREADY;

    clocking fifo_cb @(posedge clk);
        default input #(`INPUT_SKEW) output #(`OUTPUT_SKEW);
        input S_AXIS_TREADY, M_AXIS_TVALID, M_AXIS_TDATA, M_AXIS_TLAST;
        output S_AXIS_TDATA, S_AXIS_TLAST, S_AXIS_TVALID, M_AXIS_TREADY;
    endclocking

    modport uvc_driver (clocking fifo_cb);

endinterface