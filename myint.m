function [I] = myint(El,Eu,pnts,Ef)%%%%%all energy in eV

N=inline('(1./(1+exp((E-Ef)/(.0259)))).*(1./sqrt((E-El)*1.6e-19))'); %% N(E,Ef,El)

I = 0;
step = (Eu - (El+.0000001))/ pnts;

for E = (El+.0000001) : step : Eu
    I = I + feval(N,E,Ef,El);
end

% compute integral
I = (I - (feval(N,El+.0000001,Ef,El) + feval(N,Eu,Ef,El))/2) * step*1.6e-19;

end

