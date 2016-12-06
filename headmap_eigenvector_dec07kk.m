%% Dec/7/2015 Kitajo
addpath(genpath('H:\kkitajo\impact15eeg\dataforming\eeglab10_2_5_8b'))

%% Settings
clear all
% 
% fs=1000;
% fcl=3; 
% fch=47;
% stp=10*fs;       % start point
% enp=170*fs;     % end point

tuL ={'btw','blr'};       % tune label
taL = {'notap','tap'};     % tap label
clim = [-300 300];
clim = [0 300]

% %% 1. Same condition
% clear r1 A1 B1 U1 V1;
% parfor tune=1:2
%     for tap=1:2
%         hoge = load(['ms3\ms3_eegdata_filt_',char(tuL(tune)),'_',char(taL(tap)),'_1_csd.mat']);
%         edata1=hoge.CEALL(:,:);
%         hoge = load(['ms3\ms3_eegdata_filt_',char(tuL(tune)),'_',char(taL(tap)),'_2_csd.mat']);
%         edata2=hoge.CEALL(:,:);
%         
%         data1 = eegfilt(edata1,fs,fcl,fch);
%         data2 = eegfilt(edata2,fs,fcl,fch);
%         
%         sdata1=data1(:,stp+1:enp);
%         sdata2=data2(:,stp+1:enp);
%         
%         [A1{tune,tap},B1{tune,tap},r1{tune,tap},U1{tune,tap},V1{tune,tap}]=canoncorr(sdata1',sdata2');
%     end
% end
% A1=load('S2011_eigenvector_stim1.csv');
 tmp=load('D:\kkitajo\impact15eeg\dataforming\WAs1t5.txt');
%   tmp=load('WAs1t11.txt');
   tmp=load('D:\kkitajo\impact15eeg\dataforming\WBs1t11.txt');
%    tmp=load('WBs1t24.txt');
   
mA1=tmp(:,1); %eigen vector
mA1=abs(tmp(:,1)); %eigen vector

%  mA1=tmp(1,:);
%  mA1=mA1';
 %mA1=mean(A1');
 %mA1=mA1';
 
%  mabsA1=mean(abs(A1'));
 % mabsA1=mabsA1';
 
%  A1=load('S1_vector.csv');
% A1=load('A1.txt');
%% 

% figure,hold on,grid on
% plot(r1{1,1},'b'),plot(r1{1,2},'b:'),plot(r1{2,1},'r'),plot(r1{2,2},'r:')
% legend('btw, notap','btw, tap','blr, notap','blr, tap')
% title('CCA among same conditions'),
% ylim([0 0.8]),hold off
figure,
 subplot(1,1,1),topoplot(mA1(:,1),'Easycap63ch.locs'); title(['trial1']),caxis(clim);
 %% 
 
figure,
 subplot(2,7,1),topoplot(A1(:,1),'Easycap63ch.locs'); title(['trial1']),caxis(clim);
subplot(2,7,2),topoplot(A1(:,2),'Easycap63ch.locs'); title(['trial2']),caxis(clim);
subplot(2,7,3),topoplot(A1(:,3),'Easycap63ch.locs'); title(['trial3']),caxis(clim);
subplot(2,7,4),topoplot(A1(:,4),'Easycap63ch.locs'); title(['trial4']),caxis(clim);
subplot(2,7,5),topoplot(A1(:,5),'Easycap63ch.locs'); title(['trial5']),caxis(clim);
subplot(2,7,6),topoplot(A1(:,6),'Easycap63ch.locs'); title(['trial6']),caxis(clim);
subplot(2,7,7),topoplot(A1(:,7),'Easycap63ch.locs'); title(['trial7']),caxis(clim);
subplot(2,7,8),topoplot(A1(:,8),'Easycap63ch.locs'); title(['trial8']),caxis(clim);
subplot(2,7,9),topoplot(A1(:,9),'Easycap63ch.locs'); title(['trial9']),caxis(clim);
subplot(2,7,10),topoplot(A1(:,10),'Easycap63ch.locs'); title(['trial10']),caxis(clim);
subplot(2,7,11),topoplot(A1(:,11),'Easycap63ch.locs'); title(['trial11']),caxis(clim);
subplot(2,7,12),topoplot(A1(:,12),'Easycap63ch.locs'); title(['trial12']),caxis(clim);
subplot(2,7,13),topoplot(A1(:,13),'Easycap63ch.locs'); title(['trial13']),caxis(clim);
subplot(2,7,14),topoplot(A1(:,14),'Easycap63ch.locs'); title(['trial14']),caxis(clim);




figure,
 subplot(2,7,1),topoplot(abs(A1(:,1)),'Easycap63ch.locs'); title(['trial1']),caxis(clim);
subplot(2,7,2),topoplot(abs(A1(:,2)),'Easycap63ch.locs'); title(['trial2']),caxis(clim);
subplot(2,7,3),topoplot(abs(A1(:,3)),'Easycap63ch.locs'); title(['trial3']),caxis(clim);
subplot(2,7,4),topoplot(abs(A1(:,4)),'Easycap63ch.locs'); title(['trial4']),caxis(clim);
subplot(2,7,5),topoplot(abs(A1(:,5)),'Easycap63ch.locs'); title(['trial5']),caxis(clim);
subplot(2,7,6),topoplot(abs(A1(:,6)),'Easycap63ch.locs'); title(['trial6']),caxis(clim);
subplot(2,7,7),topoplot(abs(A1(:,7)),'Easycap63ch.locs'); title(['trial7']),caxis(clim);
subplot(2,7,8),topoplot(abs(A1(:,8)),'Easycap63ch.locs'); title(['trial8']),caxis(clim);
subplot(2,7,9),topoplot(abs(A1(:,9)),'Easycap63ch.locs'); title(['trial9']),caxis(clim);
subplot(2,7,10),topoplot(abs(A1(:,10)),'Easycap63ch.locs'); title(['trial10']),caxis(clim);
subplot(2,7,11),topoplot(abs(A1(:,11)),'Easycap63ch.locs'); title(['trial11']),caxis(clim);
subplot(2,7,12),topoplot(abs(A1(:,12)),'Easycap63ch.locs'); title(['trial12']),caxis(clim);
subplot(2,7,13),topoplot(abs(A1(:,13)),'Easycap63ch.locs'); title(['trial13']),caxis(clim);
subplot(2,7,14),topoplot(abs(A1(:,14)),'Easycap63ch.locs'); title(['trial14']),caxis(clim);
 
figure,
 subplot(1,1,1),topoplot(mabsA1(:,1),'Easycap63ch.locs'); title(['trial1']),caxis(clim);


 figure,
 subplot(2,7,1),topoplot(abs(A1(:,1)),'Easycap63ch.locs'); title(['trial1']),caxis(clim);
 
      
figure,
% subplot(221),topoplot(B1{1,1}(:,1),'Easycap63ch.locs'); title(['btw, notap']),caxis(clim);
% subplot(222),topoplot(B1{1,2}(:,1),'Easycap63ch.locs'); title(['btw, tap']),caxis(clim);
% subplot(223),topoplot(B1{2,1}(:,1),'Easycap63ch.locs'); title(['blr, notap']),caxis(clim);
% subplot(224),topoplot(B1{2,2}(:,1),'Easycap63ch.locs'); title(['blr, tap']),caxis(clim);
% 
% 

%% 2. CCA among same and different tunes (notap)
clear r;
hoge = load(['ms3\ms3_eegdata_filt_btw_notap_1_csd.mat']);
edata(:,:,1,1)=hoge.CEALL(:,:);
hoge = load(['ms3\ms3_eegdata_filt_btw_notap_2_csd.mat']);
edata(:,:,1,2)=hoge.CEALL(:,:);
hoge = load(['ms3\ms3_eegdata_filt_blr_notap_1_csd.mat']);
edata(:,:,2,1)=hoge.CEALL(:,:);
hoge = load(['ms3\ms3_eegdata_filt_blr_notap_2_csd.mat']);
edata(:,:,2,2)=hoge.CEALL(:,:);

parfor tune=1:2
    for trial=1:2
        tmp = eegfilt(edata(:,:,tune,trial),fs,fcl,fch);
        sdata(:,:,tune,trial) = tmp(:,stp+1:enp);
    end
end

[A2{1},B2{1},r2{1},U2{1},V2{1}]=canoncorr(sdata(:,:,1,1)',sdata(:,:,1,2)');
[A2{2},B2{2},r2{2},U2{2},V2{2}]=canoncorr(sdata(:,:,2,1)',sdata(:,:,2,2)');
[A2{3},B2{3},r2{3},U2{3},V2{3}]=canoncorr(sdata(:,:,1,1)',sdata(:,:,2,1)');
[A2{4},B2{4},r2{4},U2{4},V2{4}]=canoncorr(sdata(:,:,1,1)',sdata(:,:,2,2)');
[A2{5},B2{5},r2{5},U2{5},V2{5}]=canoncorr(sdata(:,:,1,2)',sdata(:,:,2,1)');
[A2{6},B2{6},r2{6},U2{6},V2{6}]=canoncorr(sdata(:,:,1,2)',sdata(:,:,2,2)');

figure,hold on,grid on
plot(r2{1},'b'),plot(r2{2},'b:'),plot(r2{3},'r'),plot(r2{4},'r'),plot(r2{5},'r'),plot(r2{6},'r')
legend('same btw-btw','same blr-blr','different')
title(['CCA among same and different tunes, ']),
ylim([0 0.8]),hold off



figure,
subplot(242),topoplot(A2{1}(:,1),'Easycap63ch.locs'); title(['same btw-btw']),caxis(clim);
subplot(243),topoplot(A2{2}(:,1),'Easycap63ch.locs'); title(['same blr-blr']),caxis(clim),colorbar('east');
subplot(245),topoplot(A2{3}(:,1),'Easycap63ch.locs'); title(['different']),caxis(clim);
subplot(246),topoplot(A2{4}(:,1),'Easycap63ch.locs'); title(['different']),caxis(clim);
subplot(247),topoplot(A2{5}(:,1),'Easycap63ch.locs'); title(['different']),caxis(clim);
subplot(248),topoplot(A2{6}(:,1),'Easycap63ch.locs'); title(['different']),caxis(clim);
figure,
subplot(242),topoplot(B2{1}(:,1),'Easycap63ch.locs'); title(['same btw-btw']),caxis(clim);
subplot(243),topoplot(B2{2}(:,1),'Easycap63ch.locs'); title(['same blr-blr']),caxis(clim),colorbar('east');
subplot(245),topoplot(B2{3}(:,1),'Easycap63ch.locs'); title(['different']),caxis(clim);
subplot(246),topoplot(B2{4}(:,1),'Easycap63ch.locs'); title(['different']),caxis(clim);
subplot(247),topoplot(B2{5}(:,1),'Easycap63ch.locs'); title(['different']),caxis(clim);
subplot(248),topoplot(B2{6}(:,1),'Easycap63ch.locs'); title(['different']),caxis(clim);

%% 3. CCA among tap condition
clear r3 A3 B3 U3 V3;
tune=1;
hoge = load(['ms3\ms3_eegdata_filt_',char(tuL(tune)),'_notap_1_csd.mat']);
edata(:,:,1,1)=hoge.CEALL(:,:);
hoge = load(['ms3\ms3_eegdata_filt_',char(tuL(tune)),'_notap_2_csd.mat']);
edata(:,:,1,2)=hoge.CEALL(:,:);
hoge = load(['ms3\ms3_eegdata_filt_',char(tuL(tune)),'_tap_1_csd.mat']);
edata(:,:,2,1)=hoge.CEALL(:,:);
hoge = load(['ms3\ms3_eegdata_filt_',char(tuL(tune)),'_tap_2_csd.mat']);
edata(:,:,2,2)=hoge.CEALL(:,:);

parfor tu=1:2
    for tr=1:2
        tmp = eegfilt(edata(:,:,tu,tr),fs,fcl,fch);
        sdata(:,:,tu,tr) = tmp(:,stp+1:enp);
    end
end

[A3{1},B3{1},r3{1},U3{1},V3{1}]=canoncorr(sdata(:,:,1,1)',sdata(:,:,1,2)');
[A3{2},B3{2},r3{2},U3{2},V3{2}]=canoncorr(sdata(:,:,2,1)',sdata(:,:,2,2)');
[A3{3},B3{3},r3{3},U3{3},V3{3}]=canoncorr(sdata(:,:,1,1)',sdata(:,:,2,1)');
[A3{4},B3{4},r3{4},U3{4},V3{4}]=canoncorr(sdata(:,:,1,1)',sdata(:,:,2,2)');
[A3{5},B3{5},r3{5},U3{5},V3{5}]=canoncorr(sdata(:,:,1,2)',sdata(:,:,2,1)');
[A3{6},B3{6},r3{6},U3{6},V3{6}]=canoncorr(sdata(:,:,1,2)',sdata(:,:,2,2)');

figure,hold on,grid on
plot(r3{1},'b'),plot(r3{2},'b:'),plot(r3{3},'r'),plot(r3{4},'r'),plot(r3{5},'r'),plot(r3{6},'r')
legend('notap-notap','tap-tap','tap-nontap1','tap-nontap2','tap-nontap3','tap-nontap4')
title(['CCA among tap condition, ']),
ylim([0 0.8]),hold off

figure,
subplot(242),topoplot(A3{1}(:,1),'Easycap63ch.locs'); title(['notap-notap']),caxis(clim);
subplot(243),topoplot(A3{2}(:,1),'Easycap63ch.locs'); title(['tap-tap']),caxis(clim),colorbar('east');
subplot(245),topoplot(A3{3}(:,1),'Easycap63ch.locs'); title(['tap-nontap1']),caxis(clim);
subplot(246),topoplot(A3{4}(:,1),'Easycap63ch.locs'); title(['tap-nontap2']),caxis(clim);
subplot(247),topoplot(A3{5}(:,1),'Easycap63ch.locs'); title(['tap-nontap3']),caxis(clim);
subplot(248),topoplot(A3{6}(:,1),'Easycap63ch.locs'); title(['tap-nontap4']),caxis(clim);
figure,
subplot(242),topoplot(B3{1}(:,1),'Easycap63ch.locs'); title(['notap-notap']),caxis(clim);
subplot(243),topoplot(B3{2}(:,1),'Easycap63ch.locs'); title(['tap-tap']),caxis(clim),colorbar('east');
subplot(245),topoplot(B3{3}(:,1),'Easycap63ch.locs'); title(['tap-nontap1']),caxis(clim);
subplot(246),topoplot(B3{4}(:,1),'Easycap63ch.locs'); title(['tap-nontap2']),caxis(clim);
subplot(247),topoplot(B3{5}(:,1),'Easycap63ch.locs'); title(['tap-nontap3']),caxis(clim);
subplot(248),topoplot(B3{6}(:,1),'Easycap63ch.locs'); title(['tap-nontap4']),caxis(clim);

%%
tmp = repmat(A3{1}(:,1),1,1000);
save tmp.mat tmp
