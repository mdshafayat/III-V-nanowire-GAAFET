function [] = load_device_parameter()
%%% all units are S.I.
%%% with the changing geometry and condition change this file

load uni_const.mat

%%basic
T=300;%kelvin
oic=3e16;%oxide interface charge
use_dit=0;%0/1 no/yes

%% decide
refine_mesh=1;%1 for finwidth 30nm. increase accordingly
mygrid_del=1e-9;
tolerance=2e-2;%best 1e-2
eigen_no=20;%best 50
pc_loc=1; % 0/1, home/buet
max_it=1000; %best 1000
CV_typ=1;%1/0 qunatum/semiclassical
update=.04;%best .04
Vg=-1.5:.1:1;
% Vg=1;
%% geometry
fin_width=30e-9;
fin_height=30e-9;
oxide_thick=10e-9;%symmetric %%%%%use 10n 8n 6n 4n 2n 1.5n
metal_thick=20e-9;%symmetric
channel_len=50e-9;

%% material
%metal WN
phi_m=4.6;%metal work func in eV
m_metal=9.1e-31;%effective mass in metal
eps_m=1*eps0;

%insulator Al2O3
kai_ox=1;%oxide affinity in eV
Eg_ox=9;%6.705 in eV [ref:DOI:10.1063/1.2218826]
eps_ox=9*eps0;%10%3.9 atlas[ref: DOI:10.1021/cr900056b: eps=7][DOI: 10.1134/S0021364007030071; eps=10]
me_ox=.4*m0;%Dos effective mass[ref:DOI:10.1063/1.2218826 ;me_ox=.3*m0][DOI: 10.1134/S0021364007030071;me_ox=.4*m0]
mhh_ox=.7*m0;%[Doi:10.1063/1.1897431; 10.1063/1.2010607; mh=.7] [10.1109/NVMT.2008.4731201 ; mh=.46]
mlh_ox=.46*m0;%[not sure]
me_ox_c=m0;%conductivity effective mass [not sure]
mh_ox_c=1.86*m0;%[DOI: 10.1134/S0021364007030071; (6.3+.36)^(1/3)][not sure]

%nanowire In(1-x)Gs(x)As x=.47 %%%generize for x using vegard or Kp method
kai_s=4.51;%semiconductor affinity in eV
Eg_s=0.75;%in eV
eps_s=13.899*eps0;

me_s=.041*m0;%Dos effective mass [ref: ioffe.org]
mhh_s=.457*m0;
mlh_s=.052*m0;
me_s_c=.041*m0;%conductivity effective mass [not sure]
mhh_s_c=m0;%[not sure]
mlh_s_c=m0;%[not sure]

ni=6.3e17;%[ref: ioffe.org]
Nc=2.1e23;
Nv=7.7e24;

%%doping fully deplated
dop_typ=1;%1/-1 p-type/n-type
dop=2e21;

%% Carrier density calculation accuracy
int_interval=1e-4;%1e-5
eg_lim=10*K*T/qe;%100kT
po_ints=2000;%5000

%% my int is not fully generalized {edit manually}

%%
save dev_param.mat
end

