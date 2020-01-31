function []=n_xy_my()%%%%this way too slow compared to trapz version

global k

load shie.mat
load uni_const.mat
load dev_param.mat
load cal_val.mat
load nxy.mat 

cs=sqrt(2*me_s/hcut^2);%constant
cox=sqrt(2*me_ox/hcut^2);

eigen=eigene/qe;
n1=zeros(size(xx(:)'));

for i=1:length(eigen)
    N=myint(eigen(i),(eigen(i)+eg_lim),po_ints,Ef);
    temp=(shi_sq_rawe(i,:).*N);
    n1=n1+temp;
end

temp1=(xx<=0 | xx>fin_width | yy<=0 | yy>fin_height);
temp1=temp1(:)';
nxy(k,:)=n1.*((temp1==0)*cs+(temp1==1)*cox);

max(nxy(k,:))
save nxy.mat nxy
end