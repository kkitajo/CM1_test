% event_xt_kirin_cm1_13jul16.m
% trigger and eeg extraction program for KIRIN CM exp
%
% Keiichi Kitajo at RIKEN BSI
% Jul/13/2016
%

ch_eeg=66;

tgcode=1;
% tgcode=str2num(tgcode);

sf=1000; % sampling frequency (Hz)
%prsw=2; % pre-stimulus time window length (sec) 1sec fixcross(pre), 2.5sec static, 5.5sec flicker
prsw=2;
posw=17; % 1sec:CM start 16sec:CM end
%posw=9; % post-stimulus time window length (sec)

duration =sf*(prsw+posw);
%アサヒスーパードライ（ASD_CM.avi）；　101
%キリン一番搾り（IS_CM.avi）；　81
% サントリープレミアムモルツ（PM_CM.avi）；　61

ch_eeg2=5;%  end;
% trigger=[21 22 41 42 61 62 81 82 101 102];
  trigger=[61 81 101];   
  
for sub = 9:9
if sub>=100
   filename=['cm1s',num2str(sub),'-2.vhdr'];   
else
filename=['cm1s00',num2str(sub),'-2.vhdr'];     % Input % 
end;

path = 'd:\kkitajo\impact15eeg\dataforming';    % pwd;
[EEG, com] = pop_loadbv(path, filename);
[a,b]=size(EEG.event);
ev2p=EEG.event;
ev=zeros(2,b);

for s=1:length(trigger)
   f_name=strcat('CM1_S',num2str(trigger(s)),'-2.mat');    % for save % Input % 
   f_name2=strcat('CM1_S',num2str(trigger(s)),'_sub',num2str(sub),'_filt-2','.mat');    % for save % Input % 
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


    for n=1:b %1:b

        if ev(1,n)==1;
            
            epochs(1,d)=ev(1,n);
            epochs(2,d)=ev(2,n);
            epochs(3,d)=n;
      

            d=d+1;

        end;
    end;

    
    
    [g,h]=size(epochs);

    m=1;
    
    dat=EEG.data;
    
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
       
        end;
    end;

  
    eegdata2=[];
    n=1;
    % M2 substraction
    for ch=1:ch_eeg %
        if ch~=64 && ch~=65 && ch~=66 %Not HEOG_L,HEOG_R,VEOG_U,REF,VEOG_D
            eegdata2(n,:)=eegdata(ch,:)-eegdata(64,:)/2; 
       %     n=n+1;
        end
    end
    

   
 
    lowcut = 2;
    highcut = 100;

     filt_eegdata=eegfilt(eegdata2,1000,lowcut,highcut,duration,200); 
 
    
    str=['CM1_S',num2str(trigger(s))];
    str2=['CM1_S',num2str(trigger(s)),'_sub',num2str(sub),'_filt'];

    eval([str2,'=filt_eegdata;'])

    save([f_name2],['CM1_S',num2str(trigger(s)),'_sub',num2str(sub),'_filt'],'-v7.3');      %%% input %%%

end
end

load('CM1_S61_sub9_filt.mat');
tmp=CM1_S61_sub9_filt;

load('CM1_S61_sub9_filt-2.mat');
CM1_S61_sub9_filt=[tmp,CM1_S61_sub9_filt];

save 'CM1_S61_sub9_filt.mat' CM1_S61_sub9_filt -mat;
