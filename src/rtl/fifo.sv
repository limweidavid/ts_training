module fifo #(
    parameter  WIDTH    = 32            ,
    parameter  DEPTH    = 4            ,
    parameter C_M_AXIS_TDATA_WIDTH = 32,
    parameter C_S_AXIS_TDATA_WIDTH = 32,
    localparam PTRWIDTH = $clog2(DEPTH)
) (
    input  wire                            clk          ,
    input  wire                            rst_n        ,
    // SLAVE INTERFACE
    output wire                            S_AXIS_TREADY,
    input  wire [C_S_AXIS_TDATA_WIDTH-1:0] S_AXIS_TDATA ,
    input  wire                            S_AXIS_TLAST ,
    input  wire                            S_AXIS_TVALID,
    // MASTER INTERFACE
    output reg                            M_AXIS_TVALID,
    output reg [C_M_AXIS_TDATA_WIDTH-1:0] M_AXIS_TDATA ,
    output reg                            M_AXIS_TLAST ,
    input  wire                            M_AXIS_TREADY
);

    wire rd_en;
    wire full ;
    wire empty;
    wire writes_done;

    reg [ WIDTH-1:0] mem   [DEPTH];
    reg [PTRWIDTH:0] wr_ptr, rd_ptr;

    reg [1:0] Current_State,Next_State;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            wr_ptr <= 0;
        end else begin
            if (S_AXIS_TREADY) begin
                mem[wr_ptr] <= S_AXIS_TDATA;
                wr_ptr      <= wr_ptr + 1;
            end
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            rd_ptr        <= 0;
            M_AXIS_TVALID <= 'd0;
            M_AXIS_TLAST  <= 'd0;
        end else begin
            if (rd_en && !empty) begin
                M_AXIS_TDATA  <= mem[rd_ptr];
                rd_ptr        <= rd_ptr + 1;
                M_AXIS_TVALID <= 'd1;
                M_AXIS_TLAST  <= 'd1;
            end
        end
    end

    always@(posedge clk or negedge rst_n)
        begin
            if(~rst_n)begin
                Current_State <= 'd0;
            end
            else begin
                Current_State <= Next_State;
            end
        end
    always@(*)begin
        case (Current_State)
            2'b0 : begin
                Next_State = Current_State;
                if(S_AXIS_TVALID && ~full) begin
                    Next_State = 'd1;
                end
            end
            2'b01 : begin
                Next_State = Current_State;
                if(writes_done)begin
                    Next_State = 'd0;
                end
            end
            default :
                begin
                    Next_State = 'd0;
                end
        endcase
    end

    assign full          = (wr_ptr[PTRWIDTH] != rd_ptr[PTRWIDTH]) && (wr_ptr[PTRWIDTH-1:0] == rd_ptr[PTRWIDTH-1:0]);
    assign empty         = (wr_ptr[PTRWIDTH] == rd_ptr[PTRWIDTH]) && (wr_ptr[PTRWIDTH-1:0] == rd_ptr[PTRWIDTH-1:0]);
    assign writes_done   = (wr_ptr == DEPTH-1) || S_AXIS_TLAST;
    assign S_AXIS_TREADY = Current_State[0];

    assign rd_en = M_AXIS_TREADY;
    // assign wr_en         = S_AXIS_TREADY;

endmodule
