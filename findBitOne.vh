reg[15:0] flag;
integer i;
initial 
begin 
    flag = 16'b0010-0000-0000-0000;
    i = 0;
    begin: block1
            while(i < 16)
            begin 
                if(flag[i])
                begin
                    $display("True biti ile karsilasildi %d", i);
                    disable block1;
                end
                i = i + 1;
            end
    end
end