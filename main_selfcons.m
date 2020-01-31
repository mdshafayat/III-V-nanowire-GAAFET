%self consistent main file 
%intial input file will have semiclassical potential profile semiclasspoi.mat

%% clear
clc;
clear all;
close all;

%% globals
global Vapp k

%% loads
load_universal_const();
load_device_parameter();
calculate_values();
load uni_const.mat
load dev_param.mat
load cal_val.mat
   
%%
L=length(Vg);
% initial quantum carriers
    nxy=zeros(L,M*N);
    save nxy.mat nxy
    phhxy=zeros(L,M*N);
    save phhxy.mat phhxy
    plhxy=zeros(L,M*N);
    save plhxy.mat plhxy
    
for k=1:L %gate voltage sweep
    Vapp=Vg(k);
    
    %initial pot profile
    V=zeros(1,M*N);
    save pois.mat V

    %first schrodinger solve
    schroe();
    schrohh();
    schrolh();

    if(pc_loc==0)
     n_xy_my();
     phh_xy_my();
     plh_xy_my();
    else
     n_xy();
     phh_xy();
     plh_xy();
    end

    Vold=V;

    for it=1:max_it %self consistent
        
        Q(k)=pois();
        load pois.mat V

        err=max(abs(Vold-V))
        Vapp
        if(err<tolerance)
            disp('the end');
            break;
        end

        V=Vold*(1-update)+V*update;
        Vold=V;
        save pois.mat V

        %schrodinger solve
        schroe();
        schrohh();
        schrolh();

        if(pc_loc==0)
            n_xy_my();
            phh_xy_my();
            plh_xy_my();
        else
            n_xy();
            phh_xy();
            plh_xy();
        end
        
    end %self consistent for end
    
    save QQ.mat Q

end %gate voltage sweep end