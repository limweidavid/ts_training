interface fifo_if #(parameter WIDTH=8) (input bit clk);
    logic rstn;
    logic wr_en;
    logic rd_en;
    logic [WIDTH-1:0] wr_data;
    logic [WIDTH-1:0] rd_data;
    logic full;
    logic empty;
endinterface