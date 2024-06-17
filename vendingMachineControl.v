module vendingMachine(input wire clk, input wire reset, input wire coinInserted, 
                        input wire selectPressed, output reg[1:0] stateIndicator);
// State encoding

typedef enum reg[1:0]{
    Idle = 2'b00,
    Select = 2'b01,
    Payment = 2'b10,
    Deliver = 2'b11
}State;

State nowState, nextState;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        nowState <= Idle;
    end
    else
    begin
        nowState <= nextState;
    end
end

//Next State logic

always @(*)
begin
    case(nowState)
        Idle : begin
            if(selectPressed)
                nextState = Select;
            else
                nextState = Idle;
        end
        Select : begin
            if(coinInserted)
                nextState = Payment;
            else
                nextState = Deliver;
        end
        Payment : begin
            nextState = Deliver;
        end
        Deliver : begin
            nextState = Idle;
        end
        default : nextState = Idle;
end

//Output logic

always @(*)
begin
    stateIndicator = nowState;
end
endmodule



