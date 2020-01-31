function [ind] = myfind(Vgate,Vapplied)

for h=1:length(Vgate)
    if(Vgate(h)==Vapplied)
        ind=h;
    end
end

end

