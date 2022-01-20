module mux_4_1 #(
    parameter DATA_WIDTH = 32
)(
    input      [DATA_WIDTH - 1 : 0] in_0,
    input      [DATA_WIDTH - 1 : 0] in_1,
    input      [DATA_WIDTH - 1 : 0] in_2,
    input      [DATA_WIDTH - 1 : 0] in_3,
    input      [1              : 0] select,
    output reg [DATA_WIDTH - 1 : 0] out
);
    always @(*) begin
        case(select)
            2'b00: out = in_0;
            2'b01: out = in_1;
            2'b10: out = in_2;
            2'b11: out = in_3;
            default: out = {(DATA_WIDTH){1'b0}};
        endcase
    end
endmodule