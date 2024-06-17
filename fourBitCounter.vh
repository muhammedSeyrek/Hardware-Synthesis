module Counter(Q, clock, clear);

output [3:0] Q;
input clock, clear;
always @(posedge clear or negedge clock)
begin
    if(clear)
        Q <= 4'd0;
    else
        Q <= Q + 1;
end
endmodule