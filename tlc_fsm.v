module tlc_fsm (
    input       CLOCK,
    input       RESET,
    input       FS,
    input       HS,

    output reg  FLEFT,
    output reg  FRED,
    output reg  FYELLOW,
    output reg  HGREEN,
    output reg  HLEFT,
    output reg  HRED,
    output reg  HYELLOW
    );

    reg [2:0] c_state;
    reg [2:0] n_state;

    always @(posedge CLOCK, posedge RESET) begin
        if(RESET == 1'b1) begin
            c_state <= 3'b000;
        end
        else begin
            c_state <= n_state;
        end
    end

///////////////////////////////////////////////////////////
//// TODO: insert your codes about (n_state)
    parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100, S5=3'b101, S6=3'b110, S7=3'b111;
    always @(*) begin
        case(c_state)
            S0 : n_state = (HS || FS) ? S1 : S0;
            S1 : n_state = HS ? S2 : S3;
            S2 : n_state = S4;
            S3 : n_state = S5;
            S4 : n_state = FS ? S3 : S6;
            S5 : n_state = S7;
            S6 : n_state = S0;
            S7 : n_state = S0;
        endcase
    end
///////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
//// TODO: insert your codes about (output)
    always @(*) begin
        case(c_state)
            S0 : {HGREEN, HLEFT, HYELLOW, HRED, FLEFT, FYELLOW, FRED} = 7'b1000_001;
            S1 : {HGREEN, HLEFT, HYELLOW, HRED, FLEFT, FYELLOW, FRED} = 7'b0010_001;
            S2 : {HGREEN, HLEFT, HYELLOW, HRED, FLEFT, FYELLOW, FRED} = 7'b0100_001;
            S3 : {HGREEN, HLEFT, HYELLOW, HRED, FLEFT, FYELLOW, FRED} = 7'b0001_100;
            S4 : {HGREEN, HLEFT, HYELLOW, HRED, FLEFT, FYELLOW, FRED} = 7'b0010_001;
            S5 : {HGREEN, HLEFT, HYELLOW, HRED, FLEFT, FYELLOW, FRED} = 7'b0001_010;
            S6 : {HGREEN, HLEFT, HYELLOW, HRED, FLEFT, FYELLOW, FRED} = 7'b1000_001;
            S7 : {HGREEN, HLEFT, HYELLOW, HRED, FLEFT, FYELLOW, FRED} = 7'b1000_001;
        endcase
    end
///////////////////////////////////////////////////////////

endmodule
