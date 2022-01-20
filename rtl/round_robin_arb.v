module round_robin_arb
(
    input        clk,
    input        areset_n,
    input  [3:0] req,
    output [3:0] grant
);

    localparam [2:0] IDLE_S = 3'b000,
                     S0_S   = 3'b001,
                     S1_S   = 3'b010,
                     S2_S   = 3'b011,
                     S3_S   = 3'b100;

    reg [2:0] state, next_state;

    always @(posedge clk or negedge areset_n) begin
        if(!areset_n)
            state <= IDLE_S;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        case(state)
            IDLE_S: begin
                if     (req[0]) next_state = S0_S;
                else if(req[1]) next_state = S1_S;
                else if(req[2]) next_state = S2_S;
                else if(req[3]) next_state = S3_S;
                else            next_state = IDLE_S;
            end
            S0_S: begin
                if     (req[1]) next_state = S1_S;
                else if(req[2]) next_state = S2_S;
                else if(req[3]) next_state = S3_S;
                else if(req[0]) next_state = S0_S;
                else            next_state = IDLE_S;
            end
            S1_S: begin
                if     (req[2]) next_state = S2_S;
                else if(req[3]) next_state = S3_S;
                else if(req[0]) next_state = S0_S;
                else if(req[1]) next_state = S1_S;
                else            next_state = IDLE_S;
            end
            S2_S: begin
                if     (req[3]) next_state = S3_S;
                else if(req[0]) next_state = S0_S;
                else if(req[1]) next_state = S1_S;
                else if(req[2]) next_state = S2_S;
                else            next_state = IDLE_S;
            end
            S3_S: begin
                if     (req[0]) next_state = S0_S;
                else if(req[1]) next_state = S1_S;
                else if(req[2]) next_state = S2_S;
                else if(req[3]) next_state = S3_S;
                else            next_state = IDLE_S;
            end
            default: next_state = IDLE_S;
        endcase
    end

    assign grant[0] = (state == S0_S);
    assign grant[1] = (state == S1_S);
    assign grant[2] = (state == S2_S);
    assign grant[3] = (state == S3_S);
    
endmodule