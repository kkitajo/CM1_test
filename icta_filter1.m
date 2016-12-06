% ictal_filter1.m 
% for filtering ECoG signals
% Keiichi Kitajo RIKEN BSI 1st Sep 2016

%ictal interictal data extraction
clear all;
cd D:\kkitajo\impact15eeg\dataforming
sf=2000; % sampling frequency
epochframes=0;
dummy=0;

data1=load('D:\kkitajo\impact15eeg\ECoG\ictal_interictal\Pt1_ictal\Pt1_ictal1.mat')

data=data1.Pt1_ictal1.DATA;

cd D:\kkitajo\impact15eeg\ECoG\ictal_interictal\Pt1_ictal

save 'pt1_ictal1_data.mat' data -v7.3;

addpath(genpath('d:\kkitajo\impact15eeg\dataforming\eeglab13_5_4b'))


%% hicult filtering
locut=0
hicut=0.5
revfilt=0
load('pt1_ictal1_data.mat');
dat1=eegfiltfft(data',sf,locut,hicut,epochframes,dummy,revfilt);
save 'pt1_ictal1_hicut.mat' dat1 -v7.3;

%% locut filtering
locut=0.5
hicut=0
revfilt=0
load('pt1_ictal1_data.mat');
dat1=eegfiltfft(data',sf,locut,hicut,epochframes,dummy,revfilt);
save 'pt1_ictal1_locut.mat' dat1 -v7.3;
