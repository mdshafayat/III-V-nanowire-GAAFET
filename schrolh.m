function []=schrolh()

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
g2=rect2(fin_width,fin_height,'base','corner','pos',[0,0]);
g3=rect2(fin_width+oxide_thick+oxide_thick,oxide_thick,'base','corner','pos',[-oxide_thick,fin_height]);
g4=rect2(fin_width+oxide_thick+oxide_thick,oxide_thick,'base','corner','pos',[-oxide_thick,-oxide_thick]);
g5=rect2(oxide_thick,fin_height,'base','corner','pos',[-oxide_thick,0]);
g6=rect2(oxide_thick,fin_height,'base','corner','pos',[fin_width,0]);
g7=geomcomp({g3,g4,g5,g6},'ns',{'g3','g4','g5','g6'},'sf','g3+g4+g5+g6','edge','none');
g8=geomdel(g7);

% Analyzed geometry
clear s
s.objs={g2,g8};
s.name={'pInGaAS','Al2O3'};
s.tags={'g2','g8'};

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
appl.mode.class = 'Schrodinger';
appl.sshape = 2;
appl.assignsuffix = '_scheq';
clear bnd
bnd.type = {'dir','neu'};
bnd.ind = [1,1,1,1,1,2,2,2,2,1,1,1];
appl.bnd = bnd;
clear equ
equ.c = {hcut^2/(2*mlh_ox),hcut^2/(2*mlh_s)};
equ.a ={'energy_l(x,y)','energy_l(x,y)'};% {7.6e-19,'-sin(3.1416/30*1e9*x)*sin(3.1416/30*1e9*y)*1.6e-17'};
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
fem.sol=femeig(fem, ...
               'solcomp','u', ...
               'neigs',eigen_no, ...
               'outcomp','u');

% Save current fem structure for restart purposes
fem0=fem;


eigentemp=fem.sol.lambda;
eigenlh=eigentemp(1:eigen_no);
shi_sq_rawlh=postinterp(fem,'(abs(u)).^2',[xx(:)';yy(:)'],'solnum',1:length(eigenlh));
area=postint(fem,'(abs(u)).^2','solnum',1:length(eigenlh));

for j=1:length(eigenlh)
    shi_sq_rawlh(j,:)=shi_sq_rawlh(j,:)./area(j);
end

%  te=reshape(shi_sq_raw(1,:),size(xx));
%  figure(1),%surf(xx,yy,te);
%  surf(xx,yy,te,'FaceColor','interp',... 	
%     'EdgeColor','none',...
%   	'FaceLighting','phong');

load Evm.mat Evmin
eigenlh=eigenlh+Evmin;
save shilh.mat shi_sq_rawlh eigenlh 

end


