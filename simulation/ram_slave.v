module ram_slave #(
    parameter BASE_ADDR  = 32'h00_00_00_00,
    parameter DEPTH      = 10,
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32
)(
    input                       clk,
    input  [ADDR_WIDTH - 1 : 0] addr,
    input  [DATA_WIDTH - 1 : 0] wdata,
    input                       cs,    // request from master
    input                       cmd,   // 0 - read, 1 - write
    output [DATA_WIDTH - 1 : 0] rdata,
    output                      slave_ack
);
    reg [DATA_WIDTH - 1 : 0] mem [BASE_ADDR + DEPTH - 1: BASE_ADDR];

    always @(posedge clk) begin
        if(cs & cmd) begin
            mem[addr] <= wdata;
        end
    end

    assign rdata    = (cs & !cmd) ? mem[addr] : {DATA_WIDTH{1'bx}};
    assign slave_ack = cs;
    
endmodule