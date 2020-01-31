function [ Eng] = energy_e(x,y)

load gridmy.mat xx yy 
load pois.mat V
load uni_const.mat
load dev_param.mat
load cal_val.mat

V=(-V+phi_fc)*qe;

%% forming Ec
V=reshape(V,size(xx));
temp1=(xx<=0 | xx>fin_width | yy<=0 | yy>fin_height);
Ec=temp1*Ec_offset*qe + V;
Ecmin=min(min(Ec));
Ec=Ec-Ecmin;

% figure(5),
% surf(xx,yy,Ec,'FaceColor','interp',... 	
%     'EdgeColor','none',...
%   	'FaceLighting','phong');

Eng=interp2(xx,yy,Ec,x,y,'nearest');

%%
save Ecm.mat Ecmin Ec
end

