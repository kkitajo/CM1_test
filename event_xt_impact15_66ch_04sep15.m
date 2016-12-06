% evext_VC1002.m
% trigger and eeg extraction program
%
% Keiichi Kitajo at RIKEN BSI
% JUL/5/2010
%


ch_eeg=66;

% tgcode='R128'; %1: maru kipi, 2:kaku kipi, 3:maru moma, 4:kaku kipi
tgcode=1;
% tgcode=str2num(tgcode);

% cd 'C:\Program Files\MATLAB\kkitajo\babyEEG\VC1002'
% 
% filename='VC1002.vhdr';     % Input % 
% path='C:\Program Files\MATLAB\kkitajo\babyEEG\VC1002';
% cd '/home/regular/E:/vc1002_for_extraction'

sf=1000; % sampling frequency (Hz)
prsw=2; % pre-stimulus time window length (sec) 1sec fixcross(pre), 2.5sec static, 5.5sec flicker
posw=9; % post-stimulus time window length (sec)

% [dat,f,lab,ev2p]=loadcnt_ext32(filename);


%  for n=1:b
%  ev(1,n)=getfield(ev2p,{n},'type');
%  ev(2,n)=getfield(ev2p,{n},'latency');
ch_eeg2=5;%  end;
% trigger=[21 22 23 24 41 42 43 44 61 62 63 64 81 82 83 84 101 102 103 104];
 trigger=[21 22 41 42 61 62 81 82 101 102];
% trigger=[22]
%  trigger=[21 22 33 34 53 54 81 82 101 102]; % for subject 73,74
  
for sub = 104:104
%filename=['i1s0',num2str(sub),'.vhdr'];
%filename=['i1s001.vhdr'];
if sub>=100
   filename=['i1s',num2str(sub),'.vhdr'];   
else
filename=['i1s0',num2str(sub),'.vhdr'];     % Input % 
%filename=['i1s00',num2str(sub),'plus10.vhdr'];     % Input % 
end;

path = 'd:\kkitajo\impact15eeg\dataforming';    % pwd;
[EEG, com] = pop_loadbv(path, filename);
% [a,b]=size(ev2p);
% ev=zeros(2,b);
[a,b]=size(EEG.event);
ev2p=EEG.event;
ev=zeros(2,b);

for s=1:length(trigger)
   f_name=strcat('VC1002_S',num2str(trigger(s)),'.mat');    % for save % Input % 
 %  f_name2=strcat('VC1002_63ch_S',num2str(trigger(s)),'_sub',num2str(sub),'_filt_2','.mat');    % for save % Input % 
   f_name2=strcat('VC1002_63ch_S',num2str(trigger(s)),'_sub',num2str(sub),'_filt','.mat');    % for save % Input % 
    for n=1:b %1:b % epoch roop
        str_ev=getfield(ev2p,{1,n},'type');
 
        if trigger(s)<10
            str=strcmp(str_ev, ['S  ',num2str(trigger(s))]);
        elseif trigger(s)>=10 && trigger(s)<100
            str=strcmp(str_ev, ['S ',num2str(trigger(s))]);
        elseif trigger(s)>=100
            str=strcmp(str_ev, ['S',num2str(trigger(s))]);
        end
        
        if str==1
            str_ev_n=1;
        else
            str_ev_n=0;
        end
        ev(1,n)=str_ev_n;
        ev(2,n)=getfield(ev2p,{1,n},'latency');
        
    end;

    
    epochs=[];
    
    d=1;

    %for c=1:8
    for n=1:b %1:b
        %if ev(1,n)==s(c) && ev(1,n-2)==205;
        %if ev(1,n)==s(c);
        if ev(1,n)==1;
            
            epochs(1,d)=ev(1,n);
            epochs(2,d)=ev(2,n);
            epochs(3,d)=n;
            %break;
            %b=b+1;

            d=d+1;

        end;
    end;
    %end;
    
    
    [g,h]=size(epochs);

    m=1;
    
    dat=EEG.data;

    % save ev.mat ev;
    % save dat.mat dat;
    % save epochs.mat epochs;
    
    pre=sf*prsw;
    pst=sf*posw;

    ntp=pre+pst
    
    eegdata=[];


    fprintf('Extracting EEG data...\n');
    % not fixation trial
    for n=1:h %1:h  % epoch_num
        if epochs(1,n)==tgcode; %75
            stepoch=epochs(2,n); % start of the stim
            enepoch=stepoch+pst;
            eegdata=[eegdata,dat(:,stepoch-pre:enepoch-1)];
            %          eegdata=dat(:,stepoch-pre:enepoch-1);
        end;
    end;

    %eegdata channel ch1:Fp1,ch2:Fp2,ch3:F7,ch4:F3,ch5:Fz,ch6:F4,ch7:F8,ch8:FC5,ch9:FC1,ch10:FC2,ch11:FC6,ch12:T7,ch13:C3,ch14:Cz,ch15:C4,ch16:T8,ch17:HEOG_L,ch18:CP5,ch19:CP1,ch20:CP2,ch21:CP6,ch22:HEOG_R,ch23:P7,ch24:P3,ch25:Pz,ch26:P4,ch27:P8,ch28:VEOG_U,ch29:O1,ch30:REF,ch31:O2,ch32:VEOG_L
    
    eegdata2=[];
    n=1;
    % M2 substraction
    for ch=1:ch_eeg %
        if ch~=64 && ch~=65 && ch~=66 %Not HEOG_L,HEOG_R,VEOG_U,REF,VEOG_D
            eegdata2(n,:)=eegdata(ch,:)-eegdata(64,:)/2; 
            n=n+1;
        end
    end
    
    
%    eegdata3=[];
    
%     eegdata3(1,:)=eegdata2(17,:); %Fz
%     eegdata3(2,:)=eegdata2(5,:); %C3
%     eegdata3(3,:)=eegdata2(19,:); %Pz
%     eegdata3(4,:)=eegdata2(9,:); %O1   
%     eegdata3(5,:)=eegdata2(10,:); %O2
       
    %eegdata2 channel ch1:Fp1,ch2:Fp2,ch3:F7,ch4:F3,ch5:Fz,ch6:F4,ch7:F8,ch8:FC5,ch9:FC1,ch10:FC2,ch11:FC6,ch12:T7,ch13:C3,ch14:Cz,ch15:C4,ch16:T8,ch17:CP5,ch18:CP1,ch19:CP2,ch20:CP6,ch21:P7,ch22:P3,ch23:Pz,ch24:P4,ch25:P8,ch26:O1,ch27:O2,ch28:HEOG_L-HEOG_R,ch29:VEOG_U-VEOG_D
    %
   
    %filt_eegdata=eegfilt(eegdata2,1000,0.1,100,11000,200);
    lowcut = 2;
    highcut = 100;
    %filt_eegdata=eegfilt(eegdata2,1000,lowcut,highcut,10000,200);
     filt_eegdata=eegfilt(eegdata2,1000,lowcut,highcut,11000,200); 
    %[weights,sphere,compvars,bias,signs,lrates,activations]=runica(eegdata2);
    
    str=['VC1002_S',num2str(trigger(s))];
    str2=['VC1002_63ch_S',num2str(trigger(s)),'_sub',num2str(sub),'_filt'];
    %eval([str,'=eegdata2;'])
    
%     eval([str,'=eegdata3;'])
    eval([str2,'=filt_eegdata;'])
    % s10103sham=eegdata2; % choose           %%% input %%%
%     save([f_name],['VC1002_S' num2str(trigger(s))],'-v7.3');      %%% input %%%
    save([f_name2],['VC1002_63ch_S',num2str(trigger(s)),'_sub',num2str(sub),'_filt'],'-v7.3');      %%% input %%%
    % save([f_name],'s10103sham','-v7.3');    %%% input %%%
    

%     cd '/home/regular/E:/vc1002_for_extraction'
end
end
