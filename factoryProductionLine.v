module productionLine(input wire clk, input wire reset, output reg[1:0] stage);

//State encoding

typedef enum reg[1:0]{
    SetupS = 2'b00,
    ProcessS = 2'b01,
    PackS = 2'b10
}State;

State nowState, nextState;
reg[15:0] timer;

localparam integer SetupTime = 100, ProcessTime = 200, PackTime = 50;

//State transition

always @(posedge clk or posedge reset)
begin
    if(state)
    begin 
        nowState <= SetupS;
        timer <= 0;
    end
    else
    begin
        if(timer < nowState == SetupS ? SetupTime : nowState == ProcessS ? ProcessTime : PackTime)
        begin 
            timer <= timer + 1;
        end
    end
    else 
    begin
        nowState <= nextState;
        timer <= 0;
    end     
end


//Next State logic

always @(*)
begin
    case(nowState)
        SetupS : begin
            if(timer < SetupTime)
                nextState = SetupS;
            else 
                nextState = ProcessS;
        end
        ProcessS : begin
            if(timer < ProcessTime)
                nextState = ProcessS;
            else 
                nextState = PackS;
        end
        PackS : begin 
            if(timer < PackTime)
                nextState = PackS;
            else
                nextState =  SetupS;
        end
        default : nextState = SetupS;
    endcase
end

//Output logic

always @(*)
begin
    stage = nowState;
end
endmodule


