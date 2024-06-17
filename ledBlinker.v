module ledBlinker(input wire reset, input wire clk, output reg led);

//State encoding

typedef enum reg{
    LedOn = 1'b0,
    LedOff = 1'b1
}State;

State nowState, nextState;
reg[15:0] timer;

localparam integer OnTime = 1000, OffTime = 1000;

//State transaction

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        nowState <= Ledoff;
        timer <= 0;
    end
    else
    begin
        if(timer < nowState == LedOn ? OnTime : OffTime)
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
        LedOn : begin
            if(timer < OnTime)
                nextState = LedOn;
            else 
                nextState = LedOff;
        end
        LedOff : begin
            if(timer < OffTime)
                nextState = LedOff;
            else 
                nextState = LedOff;
        end
        default : nextState = LedOff;
    endcase
end

//Output logic
always @(*) 
begin
    led = nowState;
end
endmodule





