%% Dec/7/2015 Kitajo
%% Oct/7/2016 Kitajo

addpath(genpath('d:\kkitajo\impact15eeg\dataforming\eeglab10_2_5_8b'))

%% Settings
clear all
%

clim = [-300 300];
clim = [0 300]

% tmp=load('WAs1t5.txt');
%   tmp=load('WAs1t11.txt');
   tmp=load('WBs1t11.txt');
%    tmp=load('WBs1t24.txt');
   
mA1=tmp(:,1); %eigen vector
mA1=abs(tmp(:,1)); %abs of eigen vector

figure,
 subplot(1,1,1),topoplot(mA1(:,1),'Easycap63ch.locs'); title(['trial1']),caxis(clim);