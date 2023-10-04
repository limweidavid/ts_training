module fifo #(
    parameter WIDTH = 8,
    parameter DEPTH = 4,
    localparam PTRWIDTH = $clog2(DEPTH)
)(
    input clk,
    input rstn,

    input wr_en,
    input rd_en,
    input      [WIDTH-1:0] wr_data,
    output reg [WIDTH-1:0] rd_data,

    output full,
    output empty
);
    reg [WIDTH-1:0] mem [DEPTH];
    reg [PTRWIDTH:0] wr_ptr, rd_ptr;

    always @(posedge clk or rstn) begin
        if (~rstn) begin
            wr_ptr <= 0;
        end else begin
            if (wr_en && !full) begin
                mem[wr_ptr] <= wr_data;
                wr_ptr <= wr_ptr + 1;
            end
        end
    end

    always @(posedge clk or rstn) begin
        if (~rstn) begin
            rd_ptr <= 0;
            rd_data <= 0;
        end else begin
            if (rd_en && !empty) begin
                rd_data <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
            end
        end
    end

    assign full  = (wr_ptr[PTRWIDTH] != rd_ptr[PTRWIDTH]) && (wr_ptr[PTRWIDTH-1:0] == rd_ptr[PTRWIDTH-1:0]);
    assign empty = (wr_ptr[PTRWIDTH] == rd_ptr[PTRWIDTH]) && (wr_ptr[PTRWIDTH-1:0] == rd_ptr[PTRWIDTH-1:0]);

endmodule
