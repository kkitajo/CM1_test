% script_CCA_MDS_cm1_14jul16.m applying ICA to KIRIN CM1 exp data
% Keiichi Kitajo at RIKEN BSI
% Jul/14/2016
%


clear all;
tic

addpath(genpath('d:\kkitajo\impact15eeg\dataforming\eeglab10_2_5_8b'))

scale=0.01;
alowcut=9;
ahighcut=11;
alphacut=0;
lowcut=4;
highcut=8;
bandpass=0;
sf=1000;

%s1='../preprocessed_data/removed_data_filt_VC1002_63ch_S';
%s1='\kkitajo\impact15eeg\dataforming\removed_dataCM1_S';
s1='\kkitajo\impact15eeg\dataforming\data_after_ICA\removed_dataCM1_S';
s3='_sub';
s5='_filt.mat';

numtrial=14
%intensity=10;
trialdur=19000;  % 2.0:fixation cross  3.0 start 18.0:fixation 19.0:end


sub_num1=13 %sub XXXXXXXXXXXXXXXXXXXXXXXXXX
sub_num2=13

stim1=81 % 1 or 2 realization
stim2=101 % 1 or 2

%アサヒスーパードライ（ASD_CM.avi）；　101
%キリン一番搾り（IS_CM.avi）；　81
% サントリープレミアムモルツ（PM_CM.avi）；　61


stp=3*sf
enp=18*sf


%s2=num2str(10*intensity+stim1); %１の位：刺激の種類（1 or 2）10の位：刺激の強度
s2=num2str(stim1);
s4=num2str(sub_num1); %被験者（1 - 3）

ss=[s1 s2 s3 s4 s5];
load(ss);
if alphacut==1;
    % removed_data_filt2=eegfilt(removed_data_filt,1000,lowcut,highcut,...
    %    11000,200,1,0,0);
    revfilt=1;
    removed_data_filt2=eegfiltfft(removed_data_filt,1000,alowcut,ahighcut,trialdur,200,revfilt);
    %  removed_data_filt2=eegfilt(removed_data_filt,1000,lowcut,highcut,...
    %   11000,200);
    removed_data_filt=removed_data_filt2;
else
    % removed_data_filt=removed_data_filt;
end

if bandpass==1;
    % removed_data_filt2=eegfilt(removed_data_filt,1000,lowcut,highcut,...
    %    11000,200,1,0,0);
    revfilt=0;
    removed_data_filt2=eegfiltfft(removed_data_filt,1000,lowcut,highcut,trialdur,200,revfilt);
    %  removed_data_filt2=eegfilt(removed_data_filt,1000,lowcut,highcut,...
    %   11000,200);
    removed_data_filt=removed_data_filt2;
else
    % removed_data_filt=removed_data_filt;
end

data=tanh(scale*removed_data_filt)';
%data=data(:,[1,2,3,4,5,6,7]);
%data=data(:,[9,10,20,29,30,31,32]); % visual 7ch
data=data(:,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]);



for j=1:numtrial
    X{j}=data(trialdur*(j-1)+stp:trialdur*(j-1)+enp,:);
end

%sub_num2=5;

s2=num2str(stim2); %１の位：刺激の種類（1 or 2）10の位：刺激の強度
%s2=num2str(10*intensity+stim2); %１の位：刺激の種類（1 or 2）10の位：刺激の強度
s4=num2str(sub_num2); %被験者（1 - 3）


ss=[s1 s2 s3 s4 s5];
load(ss);

if alphacut==1;
    % removed_data_filt2=eegfilt(removed_data_filt,1000,lowcut,highcut,...
    %    11000,200,1,0,0);
    revfilt=1;
    removed_data_filt2=eegfiltfft(removed_data_filt,1000,alowcut,ahighcut,trialdur,200,revfilt);
    %  removed_data_filt2=eegfilt(removed_data_filt,1000,lowcut,highcut,...
    %   11000,200);
    removed_data_filt=removed_data_filt2;
else
    % removed_data_filt=removed_data_filt;
end

if bandpass==1;
    % removed_data_filt2=eegfilt(removed_data_filt,1000,lowcut,highcut,...
    %    11000,200,1,0,0);
    revfilt=0;
    removed_data_filt2=eegfiltfft(removed_data_filt,1000,lowcut,highcut,trialdur,200,revfilt);
    %  removed_data_filt2=eegfilt(removed_data_filt,1000,lowcut,highcut,...
    %   11000,200);
    removed_data_filt=removed_data_filt2;
else
    % removed_data_filt=removed_data_filt;
end

data=tanh(scale*removed_data_filt)';
%data=data(:,[1,2,3,4,5,6,7]);
% data=data(:,[9,10,20,29,30,31,32]); % visual 7ch
data=data(:,[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]);
% 10-20 19ch



for j=1:numtrial
    % X{j+numtrial}=data(1e+4*(j-1)+1:1e+4*j,:);
    X{j+numtrial}=data(trialdur*(j-1)+stp:trialdur*(j-1)+enp,:);
end



J=numtrial*2;
T=trialdur;
d=zeros(J,J);
r=zeros(J,J);
cnum=1

for m=1:J-1
    for n=m+1:J
        [WA,WB,tmp_r,U,V] = canoncorr(X{m}(1:1:end,:),X{n}(1:1:end,:));
        d(m,n)=mean(abs(U(:,cnum)-V(:,cnum)));
        d(n,m)=d(m,n);
        r(m,n)=tmp_r(1);
        r(n,m)=r(m,n);
        
        if (m==3)&&(n==4)
            figure;
            plot(V(:,cnum),'m','LineWidth',2)
            hold on
            plot(U(:,cnum),'g','LineWidth',2)
            set(gca,'fontsize',16)
            legend('sub1, visual stim 1, trial 3','sub1, visual stim 1, trial 4')
            axis([0 18000 -5 5 ])
            xlabel('Time (ms)','FontSize', 20)
            ylabel('Amplitude of 1st CC','FontSize', 20)
            
            text(300,4.5,'R=','FontSize', 20)
            text(700,4.5,num2str(r(m,n)),'FontSize', 20)
            
            save 'WA.txt' WA -ascii;
            save 'WB.txt' WB -ascii;
            
            
        end
    end
end

for n=1:J
    d(n,n)=0;
    r(n,n)=1;
end


[Y,eigvals] = cmdscale(d); %mds
[a,b]=size(Y);

% Fisher variance ratio
var_interlabels=mean(Y(1:14,1))-mean(Y(15:28,1));
var_interlabels=var_interlabels^2

%var_withinlabels=((14-1)*var(Y(1:14,1))+(14-1)*var(Y(15:28,1)))*1/(14+14-2);
%fisher_gamma=var_interlabels/var_withinlabels
var_withinlabels=((14-1)*var(Y(1:14,1))+(14-1)*var(Y(15:28,1)))*1/(14+14-2);
var_withinlabels1=((14-1)*var(Y(1:14,1)))*1/(14-1)
var_withinlabels2=((14-1)*var(Y(15:28,1)))*1/(14-1)
fisher_gamma=abs(var_interlabels/var_withinlabels)


figure;
d1=1;
for l=1:J
    if l<=J/2
        plot3(Y(l,d1), Y(l,d1+1), Y(l,d1+2), 'r.', 'MarkerSize', 50);
        %  plot(Y(l,1), Y(l,2), 'm.', 'MarkerSize', 50);
    else
        plot3(Y(l,d1), Y(l,d1+1), Y(l,d1+2), 'b.', 'MarkerSize', 50);
        %   plot(Y(l,1), Y(l,2), 'g.', 'MarkerSize', 50);
    end
    
    hold on;
    ll=num2str(l);
    text(Y(l,1)+0.001, Y(l,2)+0.001, ll, 'FontSize', 30);
    %text(Y(l,1)+0.001, Y(l,2)+0.001, Y(l, 3)+0.001, ll, 'FontSize', 30);
end
grid on;


z=linkage(d);
dendrogram(z);
set(gca,'fontsize',14)


S=['s1';'s1';'s1';'s1';'s1';'s1';'s1';'s1';'s1';'s1';'s1';'s1';'s1';'s1';'s2';'s2';'s2';'s2';'s2';'s2';'s2';'s2';'s2';'s2';'s2';'s2';'s2';'s2'];
indiv=cellstr(S);
inds = ~strcmp(indiv,'s3');
%X = Y(inds,1:numtrial*2-1);
X = Y(inds,1:b);

y = indiv(inds);

% SVMModel = fitcsvm(X,y,'Solver','ISDA');
SVMModel = fitcsvm(X,y,'Solver','SMO');
classOrder = SVMModel.ClassNames

sv = SVMModel.SupportVectors;
figure
gscatter(X(:,1),X(:,2),y)
hold on
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
legend('s1','s2','Support Vector')
hold off

CVSVMModel = crossval(SVMModel);
classLoss = kfoldLoss(CVSVMModel);


classLoss

toc
% figure;
% plot(V(:,1),'r')
% hold on
% plot(U(:,1),'b')
% legend('trial 1','trial 2')

