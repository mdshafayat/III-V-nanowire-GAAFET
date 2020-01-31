clc;
clear all;
close all;

load nxy.mat
load phhxy.mat
load plhxy.mat
load uni_const.mat
load dev_param.mat
load cal_val.mat


global Vapp k
display('Available gate voltage:');
Vg
display('Enter the index of  Vg you want:');
k=input('k=');
Vapp=Vg(k)

Q=pois();
schroe();
schrohh();
schrolh();
% save QQ.mat

%% Band diagram formation cross along middle of x axis
load Evm.mat Evmin Ev
load Ecm.mat Ecmin Ec
crossec=ceil(M/2);

% forming Ev
figure(1),
plot(xx(crossec,:),-Ev(crossec,:)-Evmin);
hold on

%forminig Ev eig
load shihh.mat
for i=1:length(eigenhh)-10
plot(xx(crossec,:),-eigenhh(i)*ones(size(xx(crossec,:))),'g');
end

% Ec form
plot(xx(crossec,:),Ec(crossec,:)+Ecmin);

%forminig Ec eig
load shie.mat
for i=1:length(eigene)-10
plot(xx(crossec,:),eigene(i)*ones(size(xx(crossec,:))),'g');
end

%Ef
plot(xx(crossec,:),0*ones(size(xx(crossec,:))),'r');

%% 3D Ec and Ev
figure(2),
vv=reshape(Ec,size(xx));
surf(xx,yy,vv,'FaceColor','interp',... 	
    'EdgeColor','none',...
  	'FaceLighting','phong');
figure(3),
vv=reshape(Ev,size(xx));
surf(xx,yy,vv,'FaceColor','interp',... 	
    'EdgeColor','none',...
  	'FaceLighting','phong');

%% potential profile
load pois.mat
figure(4),
vv=reshape(V,size(xx));
surf(xx,yy,vv,'FaceColor','interp',... 	
    'EdgeColor','none',...
  	'FaceLighting','phong');

%% electron concentration
load nxy.mat
load shie.mat
figure(5),
n=reshape(nxy(k,:),size(xx));
surf(xx,yy,n,'FaceColor','interp',... 	
    'EdgeColor','none',...
  	'FaceLighting','phong');

%% Heavy hole concentration
load phhxy.mat
load shihh.mat
figure(6),
n=reshape(phhxy(k,:),size(xx));
surf(xx,yy,n,'FaceColor','interp',... 	
    'EdgeColor','none',...
  	'FaceLighting','phong');

%% light hole concentration
load plhxy.mat
load shilh.mat
figure(7),
n=reshape(plhxy(k,:),size(xx));
surf(xx,yy,n,'FaceColor','interp',... 	
    'EdgeColor','none',...
  	'FaceLighting','phong');

%% Total charge density
ph=reshape(phhxy(k,:),size(xx));
pl=reshape(plhxy(k,:),size(xx));
n=reshape(nxy(k,:),size(xx));
temp1=(xx<=0 | xx>fin_width | yy<=0 | yy>fin_height);
t2=ones(size(xx))-temp1;
ch=qe*(ph+pl-n-t2*dop);
figure(8),
surf(xx,yy,ch,'FaceColor','interp',... 	
    'EdgeColor','none',...
  	'FaceLighting','phong');

%% shi_sq 
for f=1:10000
eigen_nth=input('Enter the eigen no of the desired shi: [eg. 1 or,5. 100 to exit]\n');

if(eigen_nth==100)
    break;
end

%% Ec shi_sq for electron
te=reshape(shi_sq_rawe(eigen_nth,:),size(xx));
figure(9),
surf(xx,yy,te,'FaceColor','interp',... 	
    'EdgeColor','none',...
  	'FaceLighting','phong');

%% Ev shi_sq for heavy hole
te=reshape(shi_sq_rawhh(eigen_nth,:),size(xx));
figure(10),
surf(xx,yy,te,'FaceColor','interp',... 	
    'EdgeColor','none',...
  	'FaceLighting','phong');

%% Ev shi_sq for light hole
te=reshape(shi_sq_rawlh(eigen_nth,:),size(xx));
figure(11),
surf(xx,yy,te,'FaceColor','interp',... 	
    'EdgeColor','none',...
  	'FaceLighting','phong');
end