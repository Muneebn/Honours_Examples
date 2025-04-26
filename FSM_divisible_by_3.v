module div_by_3_detector (
    input wire clk,
    input wire reset,
    input wire bit_in,
    output reg div_by_3
);

// State encoding
typedef enum reg [1:0] {
    S0 = 2'b00,  // Remainder 0
    S1 = 2'b01,  // Remainder 1
    S2 = 2'b10   // Remainder 2
} state_t;

state_t current_state, next_state;

// State transition
always @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= S0;
    else
        current_state <= next_state;
end

// Next state logic
always @(*) begin
    case (current_state)
        S0: next_state = (bit_in == 1'b0) ? S0 : S1;
        S1: next_state = (bit_in == 1'b0) ? S2 : S0;
        S2: next_state = (bit_in == 1'b0) ? S1 : S2;
        default: next_state = S0;
    endcase
end

// Output logic
always @(posedge clk or posedge reset) begin
    if (reset)
        div_by_3 <= 1'b0;
    else begin
        case (current_state)
            S0: div_by_3 <= 1'b1;
            default: div_by_3 <= 1'b0;
        endcase
    end
end

endmodule
