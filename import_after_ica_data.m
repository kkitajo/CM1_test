function [ data ] = import_after_ica_data( cm_num,sub_num )
%for import after ICA data and 
%   cmとsub入れるだけでデータica後のデータをインポート
        s1='\kkitajo\impact15eeg\dataforming\data_after_extra\CM1_S';
        s2=num2str(cm_num(cm));
        s3='_sub';
        s4=num2str(sub_num(s));
        s5='_filt.mat';
        ss=[s1 s2 s3 s4 s5];
        data = importdata(ss);
end

