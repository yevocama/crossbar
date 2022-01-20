module selector_4_1 #(
    parameter DATA_WIDTH = 65
)(
    input      [DATA_WIDTH - 1 : 0] in_0,
    input      [DATA_WIDTH - 1 : 0] in_1,
    input      [DATA_WIDTH - 1 : 0] in_2,
    input      [DATA_WIDTH - 1 : 0] in_3,
    input      [3              : 0] select,
    output reg [DATA_WIDTH - 1 : 0] out
);

    always @(*) begin
        case(select)
            4'b0001: out = in_0;
            4'b0010: out = in_1;
            4'b0100: out = in_2;
            4'b1000: out = in_3;
            default: out = {1'b0, {(DATA_WIDTH - 1){1'bx}}};
        endcase
    end

endmodule