module pedestrianSignal(input wire clk, input wire reset, output reg walk);

//State encoding
typedef enum reg {
    DontWalkS = 1'b0,
    WalkS = 1'b1
}State;

State nowState, nextState;

reg[15:0] timer;

localparam integer walkTime = 50, dontWalkTime = 150;

//State transition 

always @(posedge clk or posedge reset) begin
    if(reset) begin
        nowState <= DontWalkS;
        timer <= 0;
    end else begin
        if(timer < (nowState == WalkS ? walkTime : dontWalkTime))
        begin
            timer <= timer + 1;
        end
        else
        begin
            nowState <= nextState;
            timer <= 0;
        end
    end
end

//Next state logic

always @(*)
begin
    case(nowState)
        WalkS : begin 
            if(timer < walkTime)
                nextState = WalkS;
            else 
                nextState = DontWalkS;
        end
        DontWalkS : begin
            if(timer < dontWalkTime)
                nextState = DontWalkS;
            else
                nextState = WalkS;
        end
        default : nextState = DontWalkS;
    endcase
end

//Output logic
always @(*) 
begin
    walk = (state = WalkS);
end

endmodule 