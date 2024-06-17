module elevatorControlSystem(input wire clk, input wire reset, output reg[1:0] floor);

//State 

typedef enum reg[1:0]{
    Ground = 2'b00,
    First = 2'b01,
    Second = 2'b10
}State;

State nowState, nextState;
reg[15:0] timer;

localparam integer floorTime = 100;

//State transition
always @(posedge clk or posedge reset) 
begin
    if(reset)
    begin
        nowState <= Ground;
        timer <= 0;
    end
    else 
    begin
        if(timer < floorTime)
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
    case(state)
        Ground : nextState = First;
        First : nextState = Second;
        Second : nextState = Ground;
        default : nextState = Ground;
    endcase
end

//Output logic

always @(*)
begin
    floor = nowState;
end

endmodule











