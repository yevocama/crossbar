module crossbar #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(
    input                       clk,
    input                       areset_n,
    // Master 0 signals
    input                       master_0_req,
    input  [ADDR_WIDTH - 1 : 0] master_0_addr,
    input                       master_0_cmd,
    input  [DATA_WIDTH - 1 : 0] master_0_wdata,
    // Master 1 signals
    input                       master_1_req,
    input  [ADDR_WIDTH - 1 : 0] master_1_addr,
    input                       master_1_cmd,
    input  [DATA_WIDTH - 1 : 0] master_1_wdata,
    // Master 2 signals
    input                       master_2_req,
    input  [ADDR_WIDTH - 1 : 0] master_2_addr,
    input                       master_2_cmd,
    input  [DATA_WIDTH - 1 : 0] master_2_wdata,
    // Master 3 signals
    input                       master_3_req,
    input  [ADDR_WIDTH - 1 : 0] master_3_addr,
    input                       master_3_cmd,
    input  [DATA_WIDTH - 1 : 0] master_3_wdata,    
    // Slave 0 signals
    input                       slave_0_ack,
    input  [DATA_WIDTH - 1 : 0] slave_0_rdata,
    // Slave 1 signals
    input                       slave_1_ack,
    input  [DATA_WIDTH - 1 : 0] slave_1_rdata,
    // Slave 2 signals
    input                       slave_2_ack,
    input  [DATA_WIDTH - 1 : 0] slave_2_rdata,
    // Slave 3 signals
    input                       slave_3_ack,
    input  [DATA_WIDTH - 1 : 0] slave_3_rdata,    
    // Master 0  input signals
    output                      master_0_ack,
    output [DATA_WIDTH - 1 : 0] master_0_rdata,
    // Master 1 input signals
    output                      master_1_ack,
    output [DATA_WIDTH - 1 : 0] master_1_rdata,
    // Master 2 input signals
    output                      master_2_ack,
    output [DATA_WIDTH - 1 : 0] master_2_rdata,
    // Master 3 input signals
    output                      master_3_ack,
    output [DATA_WIDTH - 1 : 0] master_3_rdata,
    // Slave 0  input signals
    output                      slave_0_req,
    output [ADDR_WIDTH - 1 : 0] slave_0_addr,
    output                      slave_0_cmd,
    output [DATA_WIDTH - 1 : 0] slave_0_wdata,
    // Slave 1  input signals
    output                      slave_1_req,
    output [ADDR_WIDTH - 1 : 0] slave_1_addr,
    output                      slave_1_cmd,
    output [DATA_WIDTH - 1 : 0] slave_1_wdata,
    // Slave 2  input signals
    output                      slave_2_req,
    output [ADDR_WIDTH - 1 : 0] slave_2_addr,
    output                      slave_2_cmd,
    output [DATA_WIDTH - 1 : 0] slave_2_wdata,
    // Slave 3  input signals
    output                      slave_3_req,
    output [ADDR_WIDTH - 1 : 0] slave_3_addr,
    output                      slave_3_cmd,
    output [DATA_WIDTH - 1 : 0] slave_3_wdata   
);

    localparam MASTER_PACKET_WIDTH = 1'b1 + ADDR_WIDTH + DATA_WIDTH;

    wire request_master_0_slave[3:0];
    wire request_master_1_slave[3:0];
    wire request_master_2_slave[3:0];
    wire request_master_3_slave[3:0];

    wire [MASTER_PACKET_WIDTH - 1 : 0] packet_master_0;
    wire [MASTER_PACKET_WIDTH - 1 : 0] packet_master_1;
    wire [MASTER_PACKET_WIDTH - 1 : 0] packet_master_2;
    wire [MASTER_PACKET_WIDTH - 1 : 0] packet_master_3;

    wire [3:0] requests_for_arb_0;
    wire [3:0] requests_for_arb_1;
    wire [3:0] requests_for_arb_2;
    wire [3:0] requests_for_arb_3;

    assign request_master_0_slave[0] = (master_0_req && (master_0_addr[31:30] == 2'b00));
    assign request_master_0_slave[1] = (master_0_req && (master_0_addr[31:30] == 2'b01));
    assign request_master_0_slave[2] = (master_0_req && (master_0_addr[31:30] == 2'b10));
    assign request_master_0_slave[3] = (master_0_req && (master_0_addr[31:30] == 2'b11));

    assign request_master_1_slave[0] = (master_1_req && (master_1_addr[31:30] == 2'b00));
    assign request_master_1_slave[1] = (master_1_req && (master_1_addr[31:30] == 2'b01));
    assign request_master_1_slave[2] = (master_1_req && (master_1_addr[31:30] == 2'b10));
    assign request_master_1_slave[3] = (master_1_req && (master_1_addr[31:30] == 2'b11));

    assign request_master_2_slave[0] = (master_2_req && (master_2_addr[31:30] == 2'b00));
    assign request_master_2_slave[1] = (master_2_req && (master_2_addr[31:30] == 2'b01));
    assign request_master_2_slave[2] = (master_2_req && (master_2_addr[31:30] == 2'b10));
    assign request_master_2_slave[3] = (master_2_req && (master_2_addr[31:30] == 2'b11));

    assign request_master_3_slave[0] = (master_3_req && (master_3_addr[31:30] == 2'b00));
    assign request_master_3_slave[1] = (master_3_req && (master_3_addr[31:30] == 2'b01));
    assign request_master_3_slave[2] = (master_3_req && (master_3_addr[31:30] == 2'b10));
    assign request_master_3_slave[3] = (master_3_req && (master_3_addr[31:30] == 2'b11));

    assign packet_master_0 = {master_0_cmd, master_0_addr, master_0_wdata};
    assign packet_master_1 = {master_1_cmd, master_1_addr, master_1_wdata};
    assign packet_master_2 = {master_2_cmd, master_2_addr, master_2_wdata};
    assign packet_master_3 = {master_3_cmd, master_3_addr, master_3_wdata};

    assign requests_for_arb_0 = {request_master_3_slave[0], request_master_2_slave[0],
                                 request_master_1_slave[0], request_master_0_slave[0]};

    assign requests_for_arb_1 = {request_master_3_slave[1], request_master_2_slave[1],
                                 request_master_1_slave[1], request_master_0_slave[1]};

    assign requests_for_arb_2 = {request_master_3_slave[2], request_master_2_slave[2],
                                 request_master_1_slave[2], request_master_0_slave[2]};

    assign requests_for_arb_3 = {request_master_3_slave[3], request_master_2_slave[3],
                                 request_master_1_slave[3], request_master_0_slave[3]};

    wire [3:0] arbiter_0_grant;
    wire [3:0] arbiter_1_grant;
    wire [3:0] arbiter_2_grant;
    wire [3:0] arbiter_3_grant;

    round_robin_arb round_robin_arb_0 (
        .clk     (clk),
        .areset_n(areset_n),
        .req     (requests_for_arb_0),
        .grant   (arbiter_0_grant)
    );

    round_robin_arb round_robin_arb_1 (
        .clk     (clk),
        .areset_n(areset_n),
        .req     (requests_for_arb_1),
        .grant   (arbiter_1_grant)
    );

    round_robin_arb round_robin_arb_2 (
        .clk     (clk),
        .areset_n(areset_n),
        .req     (requests_for_arb_2),
        .grant   (arbiter_2_grant)
    );

    round_robin_arb round_robin_arb_3 (
        .clk     (clk),
        .areset_n(areset_n),
        .req     (requests_for_arb_3),
        .grant   (arbiter_3_grant)
    ); 
  
    wire [MASTER_PACKET_WIDTH - 1 : 0] packet_to_slave_0;
    wire [MASTER_PACKET_WIDTH - 1 : 0] packet_to_slave_1;
    wire [MASTER_PACKET_WIDTH - 1 : 0] packet_to_slave_2;
    wire [MASTER_PACKET_WIDTH - 1 : 0] packet_to_slave_3;

    selector_4_1 #(
        .DATA_WIDTH(MASTER_PACKET_WIDTH)
    ) selector_4_1_0 (
        .in_0  (packet_master_0),
        .in_1  (packet_master_1),
        .in_2  (packet_master_2),
        .in_3  (packet_master_3),
        .select(arbiter_0_grant),
        .out   (packet_to_slave_0)
    );

    selector_4_1 #(
        .DATA_WIDTH(MASTER_PACKET_WIDTH)
    ) selector_4_1_1 (
        .in_0  (packet_master_0),
        .in_1  (packet_master_1),
        .in_2  (packet_master_2),
        .in_3  (packet_master_3),
        .select(arbiter_1_grant),
        .out   (packet_to_slave_1)
    );

    selector_4_1 #(
        .DATA_WIDTH(MASTER_PACKET_WIDTH)
    ) selector_4_1_2 (
        .in_0  (packet_master_0),
        .in_1  (packet_master_1),
        .in_2  (packet_master_2),
        .in_3  (packet_master_3),
        .select(arbiter_2_grant),
        .out   (packet_to_slave_2)
    );

    selector_4_1 #(
        .DATA_WIDTH(MASTER_PACKET_WIDTH)
    ) selector_4_1_3 (
        .in_0  (packet_master_0),
        .in_1  (packet_master_1),
        .in_2  (packet_master_2),
        .in_3  (packet_master_3),
        .select(arbiter_3_grant),
        .out   (packet_to_slave_3)
    );

    // Output signals to Slaves
    assign slave_0_req   = |arbiter_0_grant;
    assign slave_0_cmd   = packet_to_slave_0[MASTER_PACKET_WIDTH - 1];
    assign slave_0_addr  = packet_to_slave_0[(MASTER_PACKET_WIDTH - 2) -: ADDR_WIDTH];
    assign slave_0_wdata = packet_to_slave_0[DATA_WIDTH - 1 : 0];

    assign slave_1_req   = |arbiter_1_grant;
    assign slave_1_cmd   = packet_to_slave_1[MASTER_PACKET_WIDTH - 1];
    assign slave_1_addr  = packet_to_slave_1[(MASTER_PACKET_WIDTH - 2) -: ADDR_WIDTH];
    assign slave_1_wdata = packet_to_slave_1[DATA_WIDTH - 1 : 0];

    assign slave_2_req   = |arbiter_2_grant;
    assign slave_2_cmd   = packet_to_slave_2[MASTER_PACKET_WIDTH - 1];
    assign slave_2_addr  = packet_to_slave_2[(MASTER_PACKET_WIDTH - 2) -: ADDR_WIDTH];
    assign slave_2_wdata = packet_to_slave_2[DATA_WIDTH - 1 : 0];

    assign slave_3_req   = |arbiter_3_grant;
    assign slave_3_cmd   = packet_to_slave_3[MASTER_PACKET_WIDTH - 1];
    assign slave_3_addr  = packet_to_slave_3[(MASTER_PACKET_WIDTH - 2) -: ADDR_WIDTH];
    assign slave_3_wdata = packet_to_slave_3[DATA_WIDTH - 1 : 0];
    
    wire slave_0_ack_to_master[3:0];
    wire slave_1_ack_to_master[3:0];
    wire slave_2_ack_to_master[3:0];
    wire slave_3_ack_to_master[3:0];

    assign slave_0_ack_to_master[0] = (slave_0_ack && (arbiter_0_grant == 4'b0001));
    assign slave_0_ack_to_master[1] = (slave_0_ack && (arbiter_0_grant == 4'b0010));
    assign slave_0_ack_to_master[2] = (slave_0_ack && (arbiter_0_grant == 4'b0100));
    assign slave_0_ack_to_master[3] = (slave_0_ack && (arbiter_0_grant == 4'b1000));

    assign slave_1_ack_to_master[0] = (slave_1_ack && (arbiter_1_grant == 4'b0001));
    assign slave_1_ack_to_master[1] = (slave_1_ack && (arbiter_1_grant == 4'b0010));
    assign slave_1_ack_to_master[2] = (slave_1_ack && (arbiter_1_grant == 4'b0100));
    assign slave_1_ack_to_master[3] = (slave_1_ack && (arbiter_1_grant == 4'b1000));

    assign slave_2_ack_to_master[0] = (slave_2_ack && (arbiter_2_grant == 4'b0001));
    assign slave_2_ack_to_master[1] = (slave_2_ack && (arbiter_2_grant == 4'b0010));
    assign slave_2_ack_to_master[2] = (slave_2_ack && (arbiter_2_grant == 4'b0100));
    assign slave_2_ack_to_master[3] = (slave_2_ack && (arbiter_2_grant == 4'b1000));

    assign slave_3_ack_to_master[0] = (slave_3_ack && (arbiter_3_grant == 4'b0001));
    assign slave_3_ack_to_master[1] = (slave_3_ack && (arbiter_3_grant == 4'b0010));
    assign slave_3_ack_to_master[2] = (slave_3_ack && (arbiter_3_grant == 4'b0100));
    assign slave_3_ack_to_master[3] = (slave_3_ack && (arbiter_3_grant == 4'b1000));

    // Output ACK from Slaves to Masters
    mux_4_1 #(
        .DATA_WIDTH(1)
    ) ack_mux_4_1_0 (
        .in_0  (slave_0_ack_to_master[0]),
        .in_1  (slave_1_ack_to_master[0]),
        .in_2  (slave_2_ack_to_master[0]),
        .in_3  (slave_3_ack_to_master[0]),
        .select(master_0_addr[31:30]),
        .out   (master_0_ack)
    );

    mux_4_1 #(
        .DATA_WIDTH(1)
    ) ack_mux_4_1_1 (
        .in_0  (slave_0_ack_to_master[1]),
        .in_1  (slave_1_ack_to_master[1]),
        .in_2  (slave_2_ack_to_master[1]),
        .in_3  (slave_3_ack_to_master[1]),
        .select(master_1_addr[31:30]),
        .out   (master_1_ack)
    );

    mux_4_1 #(
        .DATA_WIDTH(1)
    ) ack_mux_4_1_2 (
        .in_0  (slave_0_ack_to_master[2]),
        .in_1  (slave_1_ack_to_master[2]),
        .in_2  (slave_2_ack_to_master[2]),
        .in_3  (slave_3_ack_to_master[2]),
        .select(master_2_addr[31:30]),
        .out   (master_2_ack)
    );

    mux_4_1 #(
        .DATA_WIDTH(1)
    ) ack_mux_4_1_3 (
        .in_0  (slave_0_ack_to_master[3]),
        .in_1  (slave_1_ack_to_master[3]),
        .in_2  (slave_2_ack_to_master[3]),
        .in_3  (slave_3_ack_to_master[3]),
        .select(master_3_addr[31:30]),
        .out   (master_3_ack)
    );

    wire [DATA_WIDTH - 1 : 0] slave_0_rdata_to_master_0;
    wire [DATA_WIDTH - 1 : 0] slave_0_rdata_to_master_1;
    wire [DATA_WIDTH - 1 : 0] slave_0_rdata_to_master_2;
    wire [DATA_WIDTH - 1 : 0] slave_0_rdata_to_master_3;

    wire [DATA_WIDTH - 1 : 0] slave_1_rdata_to_master_0;
    wire [DATA_WIDTH - 1 : 0] slave_1_rdata_to_master_1;
    wire [DATA_WIDTH - 1 : 0] slave_1_rdata_to_master_2;
    wire [DATA_WIDTH - 1 : 0] slave_1_rdata_to_master_3;

    wire [DATA_WIDTH - 1 : 0] slave_2_rdata_to_master_0;
    wire [DATA_WIDTH - 1 : 0] slave_2_rdata_to_master_1;
    wire [DATA_WIDTH - 1 : 0] slave_2_rdata_to_master_2;
    wire [DATA_WIDTH - 1 : 0] slave_2_rdata_to_master_3;

    wire [DATA_WIDTH - 1 : 0] slave_3_rdata_to_master_0;
    wire [DATA_WIDTH - 1 : 0] slave_3_rdata_to_master_1;
    wire [DATA_WIDTH - 1 : 0] slave_3_rdata_to_master_2;
    wire [DATA_WIDTH - 1 : 0] slave_3_rdata_to_master_3;

    assign slave_0_rdata_to_master_0 = (arbiter_0_grant == 4'b0001) ? slave_0_rdata : {DATA_WIDTH{1'bx}};
    assign slave_0_rdata_to_master_1 = (arbiter_0_grant == 4'b0010) ? slave_0_rdata : {DATA_WIDTH{1'bx}};
    assign slave_0_rdata_to_master_2 = (arbiter_0_grant == 4'b0100) ? slave_0_rdata : {DATA_WIDTH{1'bx}};
    assign slave_0_rdata_to_master_3 = (arbiter_0_grant == 4'b1000) ? slave_0_rdata : {DATA_WIDTH{1'bx}};

    assign slave_1_rdata_to_master_0 = (arbiter_1_grant == 4'b0001) ? slave_1_rdata : {DATA_WIDTH{1'bx}};
    assign slave_1_rdata_to_master_1 = (arbiter_1_grant == 4'b0010) ? slave_1_rdata : {DATA_WIDTH{1'bx}};
    assign slave_1_rdata_to_master_2 = (arbiter_1_grant == 4'b0100) ? slave_1_rdata : {DATA_WIDTH{1'bx}};
    assign slave_1_rdata_to_master_3 = (arbiter_1_grant == 4'b1000) ? slave_1_rdata : {DATA_WIDTH{1'bx}};

    assign slave_2_rdata_to_master_0 = (arbiter_2_grant == 4'b0001) ? slave_2_rdata : {DATA_WIDTH{1'bx}};
    assign slave_2_rdata_to_master_1 = (arbiter_2_grant == 4'b0010) ? slave_2_rdata : {DATA_WIDTH{1'bx}};
    assign slave_2_rdata_to_master_2 = (arbiter_2_grant == 4'b0100) ? slave_2_rdata : {DATA_WIDTH{1'bx}};
    assign slave_2_rdata_to_master_3 = (arbiter_2_grant == 4'b1000) ? slave_2_rdata : {DATA_WIDTH{1'bx}};

    assign slave_3_rdata_to_master_0 = (arbiter_3_grant == 4'b0001) ? slave_3_rdata : {DATA_WIDTH{1'bx}};
    assign slave_3_rdata_to_master_1 = (arbiter_3_grant == 4'b0010) ? slave_3_rdata : {DATA_WIDTH{1'bx}};
    assign slave_3_rdata_to_master_2 = (arbiter_3_grant == 4'b0100) ? slave_3_rdata : {DATA_WIDTH{1'bx}};
    assign slave_3_rdata_to_master_3 = (arbiter_3_grant == 4'b1000) ? slave_3_rdata : {DATA_WIDTH{1'bx}};
    
    // Output RDATA from Slaves to Masters
    mux_4_1 #(
        .DATA_WIDTH(DATA_WIDTH)
    ) rdata_mux_4_1_0 (
        .in_0  (slave_0_rdata_to_master_0),
        .in_1  (slave_1_rdata_to_master_0),
        .in_2  (slave_2_rdata_to_master_0),
        .in_3  (slave_3_rdata_to_master_0),
        .select(master_0_addr[31:30]),
        .out   (master_0_rdata)
    );

    mux_4_1 #(
        .DATA_WIDTH(DATA_WIDTH)
    ) rdata_mux_4_1_1 (
        .in_0  (slave_0_rdata_to_master_1),
        .in_1  (slave_1_rdata_to_master_1),
        .in_2  (slave_2_rdata_to_master_1),
        .in_3  (slave_3_rdata_to_master_1),
        .select(master_1_addr[31:30]),
        .out   (master_1_rdata)
    );

    mux_4_1 #(
        .DATA_WIDTH(DATA_WIDTH)
    ) rdata_mux_4_1_2 (
        .in_0  (slave_0_rdata_to_master_2),
        .in_1  (slave_1_rdata_to_master_2),
        .in_2  (slave_2_rdata_to_master_2),
        .in_3  (slave_3_rdata_to_master_2),
        .select(master_2_addr[31:30]),
        .out   (master_2_rdata)
    );

    mux_4_1 #(
        .DATA_WIDTH(DATA_WIDTH)
    ) rdata_mux_4_1_3 (
        .in_0  (slave_0_rdata_to_master_3),
        .in_1  (slave_1_rdata_to_master_3),
        .in_2  (slave_2_rdata_to_master_3),
        .in_3  (slave_3_rdata_to_master_3),
        .select(master_3_addr[31:30]),
        .out   (master_3_rdata)
    );

endmodule
