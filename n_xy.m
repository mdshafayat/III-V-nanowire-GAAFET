function [] = n_xy()

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
    Egrid=(eigen(i)+int_interval*1e-2):int_interval:(eigen(i)+eg_lim);
    DOS=(1./sqrt(Egrid*qe-eigen(i)*qe));
    f=1./(1+exp((Egrid-Ef)/(K*T/qe)));
    N=trapz(Egrid*qe,f.*DOS);
    temp=(shi_sq_rawe(i,:).*N);
    n1=n1+temp;
end

temp1=(xx<=0 | xx>fin_width | yy<=0 | yy>fin_height);
temp1=temp1(:)';
nxy(k,:)=n1.*((temp1==0)*cs+(temp1==1)*cox);

max(nxy(k,:));
save nxy.mat nxy 
end