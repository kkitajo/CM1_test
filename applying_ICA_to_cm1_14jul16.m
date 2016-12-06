% applying_ICA_to_cm1_14jul16.m applying ICA to KIRIN CM1 exp data
% Keiichi Kitajo at RIKEN BSI
% Jul/14/2016
%
tic
clear%% applying ICA to old data
%addpath(genpath('H:\kkitajo\vc1002_new\eeglab10_2_5_8b'));
addpath(genpath('D:\kkitajo\impact15eeg\dataforming\eeglab10_2_5_8b'))

duration=19000;

for l = 1:3
    
    for sub=[24] %subject number
        f_name1=strcat('CM1_S101_sub',num2str(sub),'_filt');
        f_name2=strcat('CM1_S81_sub',num2str(sub),'_filt');
        f_name3=strcat('CM1_S61_sub',num2str(sub),'_filt');
        
        loadname ...
            = {
            f_name1;f_name2;...
            f_name3;...
            
            };
        
        load(loadname{l});
        eval(['eegdata =',loadname{l},';']);
        
        
        eegdata = reshape(eegdata,[size(eegdata,1),duration,14]);
        
        epoch_length = size(eegdata,2);
        trial_num = size(eegdata,3);
        tmp_new = eegdata;
        
        %% ICA No.3  start %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %     if nargin < 4
        %         lowpass = 50;
        %     end
        %
        %     lowpass = 50;
        %% Low pass filter
        data = tmp_new;
        [ch,time,trial] = size(data);                                           % Get data size
        newdata = reshape(data,[ch,time*trial]);                               % Reshape
        %     newdata = eegfilt(newdata,sample_rate,0,lowpass);                       % Low pass filter
        
        %    newdata = newdata(:,1:10000);
        
        %% ICA
        [weights,sphere,compvars,bias,signs,lrates,activations] = runica(newdata,'extended',1); % ICA
        
        %    [ch,time,trial] = size(activations);
        chanlocs = readlocs('Easycap63ch.locs');
        %     chanlocs = readlocs('32ch.locs');
        winv = inv(weights*sphere);                                             % Inverse matrix of weights
        activations = reshape(activations,[ch,time,trial]);                     % Reshape activations
        
        %% Normalize
        topografie = winv';                                                     % Computes IC topographies
        act_norm = zeros(size(activations));                                   % Normalized activations
        for n = 1:size(winv,2)                                                  % Number of ICs
            ScalingFactor = norm(topografie(n,:));                              % Norm (vector)
            topografie(n,:) = topografie(n,:)/ScalingFactor;                    % Normalize
            act_norm(n,:,:) = ScalingFactor*activations(n,:,:);                 % Normalized IC topographies
        end
        
        %% Computes Generic Discontinuity spatial feature
        gdsf = Calc_GDSF_ver2(topografie,winv,ch,chanlocs);
        
        %% Computes Spatial Eye Difference feature
        [sediff,medie_left,medie_right] = Calc_SED_ver2(topografie,winv,chanlocs);
        
        %% Computes Spatial Average Difference feature
        [sadiff,var_front,var_back,mean_front,mean_back] = Calc_SAD_ver2(topografie,winv,chanlocs);
        
        %% Spatial Variance Difference between front zone and back zone
        svdiff = var_front-var_back;
        
        %% epoch dynamic range, variance and kurtosis
        epochVar = squeeze(var(act_norm,0,2))';                                 % Variance
        epochKur = squeeze(kurtosis(act_norm,1,2))';                            % Kurtosis
        
        %% TK - Temporal Kurtosis
        meanKur = zeros(1,size(winv,2));                                        % Average kurtosis
        for n = 1:size(winv,2)
            if trial > 100                                                      %
                meanKur(1,n) = trim_and_mean_ver2(epochKur(:,n));                    % Triming and average
            else
                meanKur(1,n) = mean(epochKur(:,n));                             % Average kurtosis
            end
        end
        
        %% MEV - Maximum Epoch Variance
        maxVar = zeros(1,size(winv,2));                                         % Maximum variance
        meanVar = zeros(1,size(winv,2));                                        % Average variance
        for n = 1:size(winv,2)
            if trial > 100
                maxVar(1,n) = trim_and_max_ver2(epochVar(:,n)');                     % Triming and maximum
                meanVar(1,n) = trim_and_mean_ver2(epochVar(:,n)');                   % Triming and average
            else
                maxVar(1,n) = max(epochVar(:,n));                               % Maximum variance
                meanVar(1,n) = mean(epochVar(:,n));                             % Average variance
            end
        end
        mev = maxVar./meanVar;                                                  % MEV in reviewed formulation:
        
        
        %% Thresholds computationsave('tmpdata_for_ICAno3_07112013_6','data');
        
        soglia_K = Clc_EM_ver2(meanKur);                                             % Mean kurtosis threshold
        soglia_SED = Clc_EM_ver2(sediff);                                            % SED threshold
        soglia_SAD = Clc_EM_ver2(sadiff);                                            % SAD threshold
        soglia_GDSF = Clc_EM_ver2(gdsf);                                             % GDS threshold
        soglia_V = Clc_EM_ver2(mev);                                                 % MEV threshold
        
        %% Horizontal eye movements (HEM)
        horiz = sediff >= soglia_SED & medie_left.*medie_right < 0 & mev >= soglia_V;
        
        %% Vertical eye movements (VEM)
        vert = sadiff >= soglia_SAD & medie_left.*medie_right > 0 & svdiff > 0 & mev >= soglia_V;
        
        %% Eye Blink (EB)
        blink = sadiff >= soglia_SAD & medie_left.*medie_right > 0 & meanKur >= soglia_K & svdiff > 0;
        
        %% Generic Discontinuities (GD)
        disc = gdsf >= soglia_GDSF & mev >= soglia_V;
        
        %% Heart Beat
        %heart_beat = meanKur >= soglia_K > 0;
        hb = meanKur == max(meanKur);
        %%
        %     EEG.icaweights = weights;
        %     EEG.icasphere = sphere;
        %     EEG.icaact = reshape(EEG.icaweights*EEG.icasphere*reshape...
        %         (filted_data(1:size(EEG.icaweights,1),:,:),[size(EEG.icaweights,1)...
        %         size(filted_data,2)*size(filted_data,3)]),...
        %         [size(EEG.icaweights,1) size(filted_data,2) size(filted_data,3)]);
        %     activations = EEG.icaact;
        %     [ch,time,trial] = size(activations);
        %
        artifact = find(blink | horiz | vert | disc | hb);
        component_keep = setdiff(1:size(weights,1),artifact);                   % Keep component
        tmp = reshape(activations,[size(activations,1),size(activations,2)*size(activations,3)]); % Reshape activations
        compproj = winv(:, component_keep)*tmp(component_keep,:);               % Removed artifacts data
        removed_data = reshape(compproj, size(compproj,1),time,trial);          % Reshape cleaned data
        
        removed_data = reshape(removed_data,[ch,time*trial]);
        
        lowcut=2;
        
        highcut=100;
        %  highcut=47;
        removed_data_filt=eegfilt(removed_data,1000,lowcut,highcut,...
            duration,200);
        %     save_name = ['removed_data_filt_27ch_',loadname{l}];
        save_name = ['removed_data',loadname{l}];
        
        %   save(save_name,'removed_data_filt.txt','-ASCII')
        save(save_name,'removed_data_filt')
        
        %% ICA No.3 end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % l
        %clear
    end
end;
toc
