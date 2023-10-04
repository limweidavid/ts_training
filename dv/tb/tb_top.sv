module tb_top;

    localparam WIDTH=8;
    localparam DEPTH=4;

    logic clk;
    initial clk = 0;
    initial forever #5 clk = ~clk;

    // for scoreboard check
    logic [WIDTH-1:0] sb_wr_data;
    logic [WIDTH-1:0] sb_rd_data;

    fifo_if fifo_if0(clk);

    fifo #(
        .WIDTH(WIDTH),
        .DEPTH(DEPTH)
    )fifo1 (
        .clk(fifo_if0.clk),
        .rstn(fifo_if0.rstn),
        .wr_en(fifo_if0.wr_en),
        .rd_en(fifo_if0.rd_en),
        .wr_data(fifo_if0.wr_data),
        .rd_data(fifo_if0.rd_data),
        .full(fifo_if0.full),
        .empty(fifo_if0.empty)
    );

    task transmit_data;
        input [WIDTH-1:0] data;
        begin
            fifo_if0.wr_en = 1;
            fifo_if0.wr_data = data;
            @(posedge clk);
            fifo_if0.wr_en = 0;
        end
    endtask

    task receive_data;
        output [WIDTH-1:0] data;
        begin
            fifo_if0.rd_en = 1;
            @(posedge clk);
            fifo_if0.rd_en = 0;
            data = fifo_if0.rd_data;
        end
    endtask


    initial begin
        $vcdpluson;
        $vcdplusmemon;

        fifo_if0.rstn <= 0;
        fifo_if0.wr_en <= 0;
        fifo_if0.rd_en <= 0;
        fifo_if0.wr_data <= '0;

        repeat(5)@(posedge clk);
        fifo_if0.rstn <= 1;

        repeat(1)@(posedge clk);
        while(~fifo_if0.full) begin
            sb_wr_data = $urandom;
            transmit_data(sb_wr_data);
            $display("writing data = %h", sb_wr_data);
        end

        repeat(1)@(posedge clk);
        while(~fifo_if0.empty) begin
            receive_data(sb_rd_data);
            $display("reading data = %h", sb_rd_data);
        end

        repeat(5)@(posedge clk);
        $finish;
    end



endmodule