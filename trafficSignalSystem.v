module trafficSignalSystem(input wire clock, input wire reset, output reg[2:0] light);

//State encoding
typedef enum reg[1:0]{
    GreenS = 2'b00,
    YellowS = 2'b01, 
    RedS = 2'b10
}State;

State nowState, nextState;

reg[31:0] timer; //32 bit timer

localparam [2:0] Red = 3'b100, Yellow = 3'b100, Red = 3'b001;

localparam integer GreenTime = 100, YellowTime = 20, RedTime = 100;

always @(posedge clock or posedge reset)
begin
    if(reset)
    begin
        state <= GreenS;
        timer <= 0;
    end else 
    begin
        if(timer < (GreenS ? GreenTime : nowState == YellowS ? nowState == YellowTime : RedTime))
        begin
            timer <= timer + 1;
        end
        else begin 
            nowState <= nextState;
            timer <= 0;
        end
    end
end

// Next State logic
always @(*)
begin 
    case(nowState)
    GreenS : begin
        if(timer < GreenTime)
            nextState = GreenS;
        else 
            nextState = YellowS;
    end

    YellowS : begin
        if(timer < YellowTime)
            nextState = YellowS;
        else
            nextState = RedS;
    end

    RedS : begin 
        if(timer < RedS)
            nextState = RedS;
        else
            nextState = GreenS;
    end
    default : nextState = GreenS;
    endcase
end

//Output logic
always @(*) begin 
    case(nowState)
        GreenS : light = Green;
        YellowS : light = Yellow;
        RedS : light = Red;
        default : light = Red;
    endcase
end

endmodule




endmodule