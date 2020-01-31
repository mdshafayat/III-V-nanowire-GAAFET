function [] = calculate_values()

load dev_param.mat

%% shift of Efi from Emid
        %%%do

%% equlibrium carrier conc
%assume wire not compensated(only one type doping)
if(dop_typ>0)
    p0=dop/2+sqrt((dop/2)^2+ ni^2);
    n0=ni^2/p0;
else
    n0=dop/2+sqrt((dop/2)^2+ ni^2);
    p0=ni^2/n0;
end

%% phi_ms, assumed matal gate(not poly gate)
phi_mprime=phi_m-kai_ox;%in eV
kai_sprime=kai_s-kai_ox;%in eV

if(dop_typ>0)
    phi_fp=K*T*log(dop/ni)/qe;
    Phi_ms=phi_mprime-(kai_sprime+Eg_s/2+phi_fp);
else
    %%%do
end

%% eqilibrium band diagram
Ef=0;%reference in eV

if(dop_typ>0)
    phi_fv=K*T*log(dop/Nv)/qe+Ef;%Ev-Ef
    phi_fc=Eg_s+ phi_fv;%Ec-Ef
    Ec_offset=Eg_ox/2-phi_fc;
    Ev_offset=Eg_ox/2+phi_fv;
else
    %%%do
end

%% my grid
[xx,yy]=meshgrid(-oxide_thick:mygrid_del:fin_width+oxide_thick,-oxide_thick:mygrid_del:fin_height+oxide_thick);
[M,N]=size(xx);
save gridmy.mat Phi_ms xx yy M N

%%
save cal_val.mat
end