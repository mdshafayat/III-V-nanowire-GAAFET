function [rhoox] = rho_ox(x,y)

global k
load gridmy.mat xx yy 
load uni_const.mat
load nxy.mat nxy
load phhxy.mat phhxy
load plhxy.mat plhxy

rhoox=qe*(phhxy(k,:)+plhxy(k,:)-nxy(k,:));
save rhoox.mat rhoox

rhoox=reshape(rhoox,size(xx));
rhoox=interp2(xx,yy,rhoox,x,y);

end
