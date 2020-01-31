function [Q]=pois()

global Vapp
load uni_const.mat
load dev_param.mat
load cal_val.mat

flclear fem

% COMSOL version
clear vrsn
vrsn.name = 'COMSOL 3.5';
vrsn.ext = '';
vrsn.major = 0;
vrsn.build = 494;
vrsn.rcs = '$Name:  $';
vrsn.date = '$Date: 2008/09/19 16:09:48 $';
fem.version = vrsn;

% Geometry
g3=rect2(fin_width,fin_height,'base','corner','pos',[0,0]);
g4=rect2(fin_width+oxide_thick+oxide_thick,oxide_thick,'base','corner','pos',[-oxide_thick,fin_height]);
g5=rect2(fin_width+oxide_thick+oxide_thick,oxide_thick,'base','corner','pos',[-oxide_thick,-oxide_thick]);
g6=rect2(oxide_thick,fin_height,'base','corner','pos',[-oxide_thick,0]);
g7=rect2(oxide_thick,fin_height,'base','corner','pos',[fin_width,0]);
g8=geomcomp({g4,g5,g6,g7},'ns',{'g4','g5','g6','g7'},'sf','g4+g5+g6+g7','edge','none');
g9=geomdel(g8);


% Analyzed geometry
clear s
s.objs={g3,g9};
s.name={'pInGaAs','Al2O3'};
s.tags={'g3','g9'};

fem.draw=struct('s',s);
fem.geom=geomcsg(fem);

% Initialize mesh
fem.mesh=meshinit(fem, ...
                  'hauto',5);

for rf=1:refine_mesh              
% Refine mesh
fem.mesh=meshrefine(fem, ...
                    'mcase',0, ...
                    'rmethod','regular');
end    

% (Default values are not included)

% Application mode 1
clear appl
appl.mode.class = 'Poisson';
appl.sshape = 2;
appl.border = 'on';
appl.assignsuffix = '_poeq';
clear bnd
bnd.r = {Vapp-Phi_ms,0};
bnd.type = {'dir','neu'};
bnd.ind = [1,1,1,1,1,2,2,2,2,1,1,1];
appl.bnd = bnd;
clear equ
equ.f = {'rho_ox(x,y)','rho_xy(x,y)'};%%%%%%%%%%%%%%%%%pb in oxide
equ.c = {eps_ox,eps_s};
equ.ind = [1,2];
appl.equ = equ;
fem.appl{1} = appl;
fem.frame = {'ref'};
fem.border = 1;
clear units;
units.basesystem = 'SI';
fem.units = units;

% ODE Settings
clear ode
clear units;
units.basesystem = 'SI';
ode.units = units;
fem.ode=ode;

% Multiphysics
fem=multiphysics(fem);

% Extend mesh
fem.xmesh=meshextend(fem);

% Solve problem
fem.sol=femstatic(fem, ...
                  'solcomp',{'u'}, ...
                  'outcomp',{'u'}, ...
                  'blocksize','auto');

% Save current fem structure for restart purposes
fem0=fem;

V=postinterp(fem,'u',[xx(:)';yy(:)']);
Q=postint(fem,'rho_xy(x,y)','dl',[2]);% in domain 2 pdoped,

% % Plot in cross-section or along domain
% postcrossplot(fem,1,[2.5e-8 2.5e-8;4e-8 -1e-8], ...
%               'lindata','u', ...
%               'solnum',[1], ...
%               'title','u', ...
%               'axislabel',{'Arc-length','u'});

save pois.mat V 
end
