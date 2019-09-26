clc;clear all

vdnm='2011.069.15.40.03.8200.SX.JIC.00.BHZ.D.SAC.ASC';
sd=datestr(datenum(vdnm(1:4),'yyyy')+str2num(vdnm(6:8))-1,'yyyymmdd');
st=datenum(strcat(sd,vdnm(10:11),vdnm(13:14),vdnm(16:17)),'yyyymmddHHMMSS');
orid=textread(vdnm,'%s','delimiter','\n','whitespace','');
orid(1:30,:)=[];m=1:20:length(orid);orid=char(orid(m,:));
dift=1/(1440*60);
nt=[];nd=[];k=1;
for i=1:length(orid)
    tmt=st+(i-1)*dift;
    tmd=str2num(orid(i,:))*1e-6;%nm to mm
    nt(k,1)=tmt;
    nd(k,1)=tmd(1);
    k=k+1;
end
% nt=nt+13/1440;%调整时间
figure('position',[100 200 400 250]);
plot(nt,nd,'k')
datetick('x','HH:MM')
ylabel('Displacement/mm')
xlim([min(nt) max(nt)])
ylim([min(nd) max(nd)])

ot=str2num(datestr(nt','yyyymmddHHMMSS'));
fid=fopen(strcat(vdnm,'.txt'),'wt');
fprintf(fid,'%.0f %.8f\n',[ot,nd]');
fclose(fid);