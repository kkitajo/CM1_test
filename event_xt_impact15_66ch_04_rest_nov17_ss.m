% evext_VC1002.m
% trigger and eeg extraction program for resting 3min of consistency exp in
% 2015
%
% Keiichi Kitajo at RIKEN BSI
% Nov/17/2010
%


ch_eeg=66;

% tgcode=1;

sf=1000; % sampling frequency (Hz)
dur=180000; % epochdur for resting
prsw=0; % pre-stimulus time window length (sec) 1sec fixcross(pre), 2.5sec static, 5.5sec flicker
posw=180; % post-stimulus time window length (sec)


for sub = 1:1
filename=['i1s00',num2str(sub),'rest.vhdr']

path = 'D:\kkitajo\impact15eeg\dataforming';    % pwd;
[EEG, com] = pop_loadbv(path, filename);


   %f_name=strcat('VC1002_S',num2str(trigger(s)),'rest.mat');    % for save % Input % 
   
   f_name21=strcat('VC1002_63ch_S','01','_sub',num2str(sub),'_nonfilt','.mat');    % for save % Input % 
   f_name22=strcat('VC1002_63ch_S','02','_sub',num2str(sub),'_filt','.mat');    % for save % Input % 
 
    
    

    m=1;
    
    dat=EEG.data;

     pre=sf*prsw;
     pst=sf*posw;

    ntp=pre+pst
    
    eegdata=[];


    fprintf('Extracting EEG data...\n');
    % not fixation trial
    for n=1:1%28 %1:h  % epoch_num
       
            stepoch=(n-1)*ntp+1
            enepoch=stepoch+ntp;
            eegdata=[eegdata,dat(:,stepoch:enepoch-1)];
          
    end;


    eegdata2=[];
    n=1;
    % M2 substraction
    for ch=1:ch_eeg %
        if ch~=64 && ch~=65 && ch~=66 %Not HEOG_L,HEOG_R,VEOG_U,REF,VEOG_D
            eegdata2(n,:)=eegdata(ch,:)-eegdata(64,:)/2; 
            n=n+1;
        end
    end
    
    lowcut = 8;
    highcut = 12;
%    filt_eegdata=eegfilt(eegdata2,1000,lowcut,highcut,dur,200); 
 %    filt_eegdata1=filt_eegdata(:,1:dur*14);
 %    filt_eegdata2=filt_eegdata(:,dur*14+1:dur*28);
    %[weights,sphere,compvars,bias,signs,lrates,activations]=runica(eegdata2);
    
    %str=['VC1002_S','01'];
%    str21=['VC1002_63ch_S','01','_sub',num2str(sub),'_nonfilt'];
%    eval([str21,'=eegdata2;'])
    
%    str22=['VC1002_63ch_S','02','_sub',num2str(sub),'_filt'];
%    eval([str22,'=filt_eegdata2;'])
    
    save([f_name21],'eegdata2','-v7.3');      %%% input %%%
%    save([f_name22],['VC1002_63ch_S','02','_sub',num2str(sub),'_filt'],'-v7.3');
    

%     cd '/home/regular/E:/vc1002_for_extraction'
end

