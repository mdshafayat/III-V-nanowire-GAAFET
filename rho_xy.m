function [rhoxy] = rho_xy(x,y)

global k Vapp
load gridmy.mat xx yy 
load uni_const.mat
load cal_val.mat
load nxy.mat nxy
load phhxy.mat phhxy
load plhxy.mat plhxy

temp=Vapp-Phi_ms;

if(temp>=0)
rhoxy=qe*(phhxy(k,:)+plhxy(k,:)-nxy(k,:)-dop_typ*dop);
else
rhoxy=qe*(phhxy(k,:)+plhxy(k,:)-nxy(k,:)); 
end

save rhoxy.mat rhoxy

rhoxy=reshape(rhoxy,size(xx));
rhoxy=interp2(xx,yy,rhoxy,x,y);

end
