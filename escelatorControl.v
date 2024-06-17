module escelatorControl(input wire clk, input wire reset, output reg[1:0] direction);

//State encoding

typedef enum reg[1:0]{
    Stop = 2'b00,
    Up = 2'b01,
    Down = 2'b10
}State;

State nowState, nextState;

reg[15:0] timer;

//Timing parameters

localparam integer UpTime = 150, DownTime = 150, StopTime = 50;

//State transition

always @(posedge clk, posedge reset) 
begin
    if(reset)
    begin
        nowState <= Stop;
        timer <= 0;
    end
    else
    begin
        if(timer < nowState == Up ? UpTime : nowState == Down ? DownTime : StopTime)
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

//Nextstate logic

always @(*)
begin
    case(nowState)
        Stop : begin
            if(timer < StopTime)
                nextState = Stop;
            else 
                nextState = Up;
        end
        Up : begin
            if(timer < UpTime)
                nextState = Up;
            else 
                nextState = Down;
        end
        Down : begin
            if(timer < DownTime)
                nextState = Down;
            else
                nextState = Stop;
        end
        default : nextState = Stop;
    endcase
end

//Output logic
always @(*)
begin
    direction = state;
end
endmodule