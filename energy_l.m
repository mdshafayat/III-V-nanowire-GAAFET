function [ Eng] = energy_l(x,y)
%split off not considered
load gridmy.mat xx yy 
load pois.mat V
load uni_const.mat
load dev_param.mat
load cal_val.mat

V=(V-phi_fv)*qe;

%% forming Ev
V=reshape(V,size(xx));
temp1=(xx<=0 | xx>fin_width | yy<=0 | yy>fin_height);
Ev=temp1*Ev_offset*qe + V;
Evmin=min(min(Ev));
Ev=Ev-Evmin;

% figure(5),
% surf(xx,yy,Ec,'FaceColor','interp',... 	
%     'EdgeColor','none',...
%   	'FaceLighting','phong');

Eng=interp2(xx,yy,Ev,x,y,'nearest'); %%%with respect to metal Ec taken as o ev

%%
save Evm.mat Evmin Ev
end

