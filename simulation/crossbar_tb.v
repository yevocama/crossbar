`timescale 1ns/1ns

`define ADDR_WIDTH 32
`define DATA_WIDTH 32
`define DEPTH      10

`define SLAVE_0_BASE_ADDR 32'h00_00_00_00
`define SLAVE_1_BASE_ADDR 32'h40_00_00_00
`define SLAVE_2_BASE_ADDR 32'h80_00_00_00
`define SLAVE_3_BASE_ADDR 32'hC0_00_00_00

`define MASTER_0 2'b00
`define MASTER_1 2'b01
`define MASTER_2 2'b10
`define MASTER_3 2'b11

`define CMD_READ  1'b0
`define CMD_WRITE 1'b1

module crossbar_tb;
    
    reg                        clk;
    reg                        areset_n;
    // Master 0 signals  
    reg                        master_0_req;
    reg [`ADDR_WIDTH - 1 : 0]  master_0_addr;
    reg                        master_0_cmd;
    reg [`DATA_WIDTH - 1 : 0]  master_0_wdata;
    // Master 1 signals
    reg                        master_1_req;
    reg [`ADDR_WIDTH - 1 : 0]  master_1_addr;
    reg                        master_1_cmd;
    reg [`DATA_WIDTH - 1 : 0]  master_1_wdata;
    // Master 2 signals
    reg                        master_2_req;
    reg [`ADDR_WIDTH - 1 : 0]  master_2_addr;
    reg                        master_2_cmd;
    reg [`DATA_WIDTH - 1 : 0]  master_2_wdata;
    // Master 3 signals
    reg                        master_3_req;
    reg [`ADDR_WIDTH - 1 : 0]  master_3_addr;
    reg                        master_3_cmd;
    reg [`DATA_WIDTH - 1 : 0]  master_3_wdata;
    // Slave 0 signals
    wire                       slave_0_ack;
    wire [`DATA_WIDTH - 1 : 0] slave_0_rdata;
    // Slave 1 signals
    wire                       slave_1_ack;
    wire [`DATA_WIDTH - 1 : 0] slave_1_rdata;
    // Slave 2 signals
    wire                       slave_2_ack;
    wire [`DATA_WIDTH - 1 : 0] slave_2_rdata;
    // Slave 3 signals
    wire                       slave_3_ack;
    wire [`DATA_WIDTH - 1 : 0] slave_3_rdata;
    // Master 0 input signals 
    wire                       master_0_ack;
    wire [`DATA_WIDTH - 1 : 0] master_0_rdata;
    // Master 1 input signals 
    wire                       master_1_ack;
    wire [`DATA_WIDTH - 1 : 0] master_1_rdata;
    // Master 2 input signals 
    wire                       master_2_ack;
    wire [`DATA_WIDTH - 1 : 0] master_2_rdata;
    // Master 3 input signals 
    wire                       master_3_ack;
    wire [`DATA_WIDTH - 1 : 0] master_3_rdata;
    // Slave 0 input signals
    wire                       slave_0_req;
    wire [`ADDR_WIDTH - 1 : 0] slave_0_addr;
    wire                       slave_0_cmd;
    wire [`DATA_WIDTH - 1 : 0] slave_0_wdata;
    // Slave 1 input signals
    wire                       slave_1_req;
    wire [`ADDR_WIDTH - 1 : 0] slave_1_addr;
    wire                       slave_1_cmd;
    wire [`DATA_WIDTH - 1 : 0] slave_1_wdata;
    // Slave 2 input signals
    wire                       slave_2_req;
    wire [`ADDR_WIDTH - 1 : 0] slave_2_addr;
    wire                       slave_2_cmd;
    wire [`DATA_WIDTH - 1 : 0] slave_2_wdata;
    // Slave 3 input signals
    wire                       slave_3_req;
    wire [`ADDR_WIDTH - 1 : 0] slave_3_addr;
    wire                       slave_3_cmd;
    wire [`DATA_WIDTH - 1 : 0] slave_3_wdata;

    crossbar #(
        .ADDR_WIDTH(`ADDR_WIDTH),
        .DATA_WIDTH(`DATA_WIDTH)
    ) crossbar_dut (
        .clk           (clk),
        .areset_n      (areset_n),

        .master_0_req  (master_0_req),
        .master_0_addr (master_0_addr),
        .master_0_cmd  (master_0_cmd),
        .master_0_wdata(master_0_wdata),

        .master_1_req  (master_1_req),
        .master_1_addr (master_1_addr),
        .master_1_cmd  (master_1_cmd),
        .master_1_wdata(master_1_wdata),

        .master_2_req  (master_2_req),
        .master_2_addr (master_2_addr),
        .master_2_cmd  (master_2_cmd),
        .master_2_wdata(master_2_wdata),

        .master_3_req  (master_3_req),
        .master_3_addr (master_3_addr),
        .master_3_cmd  (master_3_cmd),
        .master_3_wdata(master_3_wdata),

        .slave_0_ack   (slave_0_ack),
        .slave_0_rdata (slave_0_rdata),

        .slave_1_ack   (slave_1_ack),
        .slave_1_rdata (slave_1_rdata),

        .slave_2_ack   (slave_2_ack),
        .slave_2_rdata (slave_2_rdata),

        .slave_3_ack   (slave_3_ack),
        .slave_3_rdata (slave_3_rdata),

        .master_0_ack  (master_0_ack),
        .master_0_rdata(master_0_rdata),

        .master_1_ack  (master_1_ack),
        .master_1_rdata(master_1_rdata),

        .master_2_ack  (master_2_ack),
        .master_2_rdata(master_2_rdata),

        .master_3_ack  (master_3_ack),
        .master_3_rdata(master_3_rdata),

        .slave_0_req   (slave_0_req),
        .slave_0_addr  (slave_0_addr),
        .slave_0_cmd   (slave_0_cmd),
        .slave_0_wdata (slave_0_wdata),

        .slave_1_req   (slave_1_req),
        .slave_1_addr  (slave_1_addr),
        .slave_1_cmd   (slave_1_cmd),
        .slave_1_wdata (slave_1_wdata),

        .slave_2_req   (slave_2_req),
        .slave_2_addr  (slave_2_addr),
        .slave_2_cmd   (slave_2_cmd),
        .slave_2_wdata (slave_2_wdata),

        .slave_3_req   (slave_3_req),
        .slave_3_addr  (slave_3_addr),
        .slave_3_cmd   (slave_3_cmd),
        .slave_3_wdata (slave_3_wdata)
    );

    reg[`DATA_WIDTH - 1 : 0] slaves_data [3:0];
    reg[`ADDR_WIDTH - 1 : 0] slaves_addr [3:0];

    ram_slave #(
        .BASE_ADDR (`SLAVE_0_BASE_ADDR),
        .DEPTH     (`DEPTH),
        .DATA_WIDTH(`DATA_WIDTH),
        .ADDR_WIDTH(`ADDR_WIDTH)
    ) ram_slave_0 (
        .clk      (clk),
        .addr     (slave_0_addr),
        .wdata    (slave_0_wdata),
        .cs       (slave_0_req),
        .cmd      (slave_0_cmd),
        .rdata    (slave_0_rdata),
        .slave_ack(slave_0_ack)
    );

    ram_slave #(
        .BASE_ADDR (`SLAVE_1_BASE_ADDR),
        .DEPTH     (`DEPTH),
        .DATA_WIDTH(`DATA_WIDTH),
        .ADDR_WIDTH(`ADDR_WIDTH)
    ) ram_slave_1 (
        .clk      (clk),
        .addr     (slave_1_addr),
        .wdata    (slave_1_wdata),
        .cs       (slave_1_req),
        .cmd      (slave_1_cmd),
        .rdata    (slave_1_rdata),
        .slave_ack(slave_1_ack)
    );

    ram_slave #(
        .BASE_ADDR (`SLAVE_2_BASE_ADDR),
        .DEPTH     (`DEPTH),
        .DATA_WIDTH(`DATA_WIDTH),
        .ADDR_WIDTH(`ADDR_WIDTH)
    ) ram_slave_2 (
        .clk      (clk),
        .addr     (slave_2_addr),
        .wdata    (slave_2_wdata),
        .cs       (slave_2_req),
        .cmd      (slave_2_cmd),
        .rdata    (slave_2_rdata),
        .slave_ack(slave_2_ack)
    );

    ram_slave #(
        .BASE_ADDR (`SLAVE_3_BASE_ADDR),
        .DEPTH     (`DEPTH),
        .DATA_WIDTH(`DATA_WIDTH),
        .ADDR_WIDTH(`ADDR_WIDTH)
    ) ram_slave_3 (
        .clk      (clk),
        .addr     (slave_3_addr),
        .wdata    (slave_3_wdata),
        .cs       (slave_3_req),
        .cmd      (slave_3_cmd),
        .rdata    (slave_3_rdata),
        .slave_ack(slave_3_ack)
    );

    task async_reset;
        begin
            #100;
            areset_n = 1'b0;
            #100;
            areset_n = 1'b1;
        end
    endtask

    task init_input_signals;
        begin
            clk            = 1'b0;
            areset_n       = 1'b1;

            master_0_req   = 1'b0;
            master_0_addr  = {`ADDR_WIDTH{1'b0}};
            master_0_cmd   = 1'b0;
            master_0_wdata = {`DATA_WIDTH{1'b0}};

            master_1_req   = 1'b0;
            master_1_addr  = {`ADDR_WIDTH{1'b0}};
            master_1_cmd   = 1'b0;
            master_1_wdata = {`DATA_WIDTH{1'b0}};

            master_2_req   = 1'b0;
            master_2_addr  = {`ADDR_WIDTH{1'b0}};
            master_2_cmd   = 1'b0;
            master_2_wdata = {`DATA_WIDTH{1'b0}};

            master_3_req   = 1'b0;
            master_3_addr  = {`ADDR_WIDTH{1'b0}};
            master_3_cmd   = 1'b0;
            master_3_wdata = {`DATA_WIDTH{1'b0}};
            
        end
    endtask

    task reset_master_request(input [1:0] master_num);
        begin
            case(master_num)
                `MASTER_0: master_0_req = 1'b0;
                `MASTER_1: master_1_req = 1'b0;
                `MASTER_2: master_2_req = 1'b0;
                `MASTER_3: master_3_req = 1'b0;
            endcase
        end
    endtask

    task master_req_to_slave (
        input [1               : 0] master_number,
        input                       cmd,
        input [`DATA_WIDTH - 1 : 0] wdata,
        input [`ADDR_WIDTH - 1 : 0] addr       
    );
        begin
            // $display("%d ns: Msater_%d requested Slave_%d", $time, master_number, addr[31:30]);
            case (master_number)
                `MASTER_0: begin
                    master_0_req   = 1'b1;
                    master_0_addr  = addr;
                    master_0_cmd   = cmd;
                    master_0_wdata = wdata;
                end
                `MASTER_1: begin
                    master_1_req   = 1'b1;
                    master_1_addr  = addr;
                    master_1_cmd   = cmd;
                    master_1_wdata = wdata;
                end
                `MASTER_2: begin
                    master_2_req   = 1'b1;
                    master_2_addr  = addr;
                    master_2_cmd   = cmd;
                    master_2_wdata = wdata;
                end
                `MASTER_3: begin
                    master_3_req   = 1'b1;
                    master_3_addr  = addr;
                    master_3_cmd   = cmd;
                    master_3_wdata = wdata;
                end
            endcase
        end
    endtask
    
    task concurrent_reading_from_slave(input [1:0] slave_number);
        begin
            repeat(`DATA_WIDTH) begin
                master_req_to_slave(`MASTER_0, `CMD_READ, {`DATA_WIDTH{1'bx}}, slaves_addr[slave_number]);
                master_req_to_slave(`MASTER_1, `CMD_READ, {`DATA_WIDTH{1'bx}}, slaves_addr[slave_number]);
                master_req_to_slave(`MASTER_2, `CMD_READ, {`DATA_WIDTH{1'bx}}, slaves_addr[slave_number]);
                master_req_to_slave(`MASTER_3, `CMD_READ, {`DATA_WIDTH{1'bx}}, slaves_addr[slave_number]);
                #80;
                @(posedge clk)
                slaves_addr[slave_number] = slaves_addr[slave_number] + 1'b1;
            end
            // Reset slaves_addr for next task
            slaves_addr[0] = `SLAVE_0_BASE_ADDR;
            slaves_addr[1] = `SLAVE_1_BASE_ADDR;
            slaves_addr[2] = `SLAVE_2_BASE_ADDR;
            slaves_addr[3] = `SLAVE_3_BASE_ADDR;
        end
    endtask

    task concurrent_write_to_slave(input [1:0] slave_number); // Write to SLAVE_x_BASE_ADDR + 4, WData is hardcoded
        begin
           master_req_to_slave(`MASTER_0, `CMD_WRITE, 32'h01_02_03_04, slaves_addr[slave_number] + 4);
           master_req_to_slave(`MASTER_1, `CMD_WRITE, 32'h0A_0B_0C_0D, slaves_addr[slave_number] + 4);
           master_req_to_slave(`MASTER_2, `CMD_WRITE, 32'h11_22_33_44, slaves_addr[slave_number] + 4);
           master_req_to_slave(`MASTER_3, `CMD_WRITE, 32'hAA_BB_CC_DD, slaves_addr[slave_number] + 4); 
        end
    endtask

    always #10 clk = ~clk;
    initial begin
        slaves_data[0] = 32'hAA_00_00_00;
        slaves_data[1] = 32'hBB_00_00_00;
        slaves_data[2] = 32'hCC_00_00_00;
        slaves_data[3] = 32'hEE_00_00_00;
        slaves_addr[0] = `SLAVE_0_BASE_ADDR;
        slaves_addr[1] = `SLAVE_1_BASE_ADDR;
        slaves_addr[2] = `SLAVE_2_BASE_ADDR;
        slaves_addr[3] = `SLAVE_3_BASE_ADDR;
        init_input_signals;
        async_reset;
        #100;
        $display("%d ns: Masters start write requests, Master[i] write request to slave[i]", $time);
        repeat(`DEPTH) begin
            master_req_to_slave(`MASTER_0, `CMD_WRITE, slaves_data[0], slaves_addr[0]);
            master_req_to_slave(`MASTER_1, `CMD_WRITE, slaves_data[1], slaves_addr[1]);
            master_req_to_slave(`MASTER_2, `CMD_WRITE, slaves_data[2], slaves_addr[2]);
            master_req_to_slave(`MASTER_3, `CMD_WRITE, slaves_data[3], slaves_addr[3]);
            #50;

            slaves_data[0] = slaves_data[0] + 1'b1;
            slaves_data[1] = slaves_data[1] + 1'b1;
            slaves_data[2] = slaves_data[2] + 1'b1;
            slaves_data[3] = slaves_data[3] + 1'b1;

            slaves_addr[0] = slaves_addr[0] + 1'b1;
            slaves_addr[1] = slaves_addr[1] + 1'b1;
            slaves_addr[2] = slaves_addr[2] + 1'b1;
            slaves_addr[3] = slaves_addr[3] + 1'b1;
        end
        #200;
        /********************************************************************************/
        reset_master_request(`MASTER_0);
        reset_master_request(`MASTER_1);
        reset_master_request(`MASTER_2);
        reset_master_request(`MASTER_3);

        slaves_data[0] = {`DATA_WIDTH{1'b0}};
        slaves_data[1] = {`DATA_WIDTH{1'b0}};
        slaves_data[2] = {`DATA_WIDTH{1'b0}};
        slaves_data[3] = {`DATA_WIDTH{1'b0}};

        slaves_addr[0] = `SLAVE_0_BASE_ADDR;
        slaves_addr[1] = `SLAVE_1_BASE_ADDR;
        slaves_addr[2] = `SLAVE_2_BASE_ADDR;
        slaves_addr[3] = `SLAVE_3_BASE_ADDR;

        $display("%d ns: All Masters start read request to Slave_0", $time);
        concurrent_reading_from_slave(0);
        #120;
        /********************************************************************************/
        $display("%d ns: All Masters start read request to Slave_1", $time);
        concurrent_reading_from_slave(1);
        #120;
        /********************************************************************************/
        $display("%d ns: All Masters start read request to Slave_2", $time);
        concurrent_reading_from_slave(2);
        #120;
        /********************************************************************************/
        $display("%d ns: All Masters start read request to Slave_3", $time);
        concurrent_reading_from_slave(3);
        #120;
        $display("%d ns: All Masters write request to Slave_3", $time);
        concurrent_write_to_slave(3);
        #5;
        $display("%d ns: Master_0 ACK = %b,  Master_1 ACK = %b,  Master_2 ACK = %b,  Master_3 ACK = %b", $time, master_0_ack, master_1_ack, master_2_ack, master_3_ack);
        /********************************************************************************/
        reset_master_request(`MASTER_0);
        reset_master_request(`MASTER_1);
        reset_master_request(`MASTER_2);
        reset_master_request(`MASTER_3);
        #1000;
        $finish;
    end

endmodule
