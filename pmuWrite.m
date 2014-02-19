function pmuWrite(varargin)

% PMU script for processing physiological data.
% Input: .ext (required), .resp, .puls, .ecg files
% Output: ASCII text files that are clipped to include only scan window
% Susan Lemieux Sept 2010 Penn State University
% Modified by Kenny Hwang - 08/08/11
% Modified t calculate heart rate SKL 9/2011
% Changed Cardiac to ECG
% Note: there can only be respiration OR cardiac never both with current
% equpt.

p = mfilename('fullpath');
dir = fileparts(p);

batch = 0;
if nargin > 0
    switch varargin{1}
        case 'batch'
            batch = 1;
            datdir = uigetdir(dir);
            [~,d] = system(['dir /s/b ' datdir filesep '*.ext']);
            d = regexp(d(1:end-1),'\n','split');
            forindex = length(d);
        otherwise
            batch = 0;
    end
end

% clear all;

if ~batch
    [ext_file,p_dir, filterindex] = uigetfile('*.ext', 'Select external trigger file');
    forindex = 1;
end

for i = 1:forindex
    try
        
        if batch
            [~,file,ext] = fileparts(d{i});
            ext_file = [file ext];
            p_dir = [fileparts(d{i}) filesep];
        end
        
        % Specify ext file
        file1 = ext_file(1:end-4);
        
        % Ext Trig (required)
        fileext=[p_dir, file1, '.ext'];
        [t1,s1]=physioloadpsu(fileext);
        
        fileresp=[p_dir, file1, '.resp'];
        [t2,s2]=physioloadpsu(fileresp); % Call physioloadpsu.m script
        
        filepuls=[p_dir, file1, '.puls'];
        [t3,s3]=physioloadpsu(filepuls);
        
        % Scaling external trigger to match a mean that exists (look for first)
        s_scale = s2;
        triggerScale=mean(s_scale);
        s1sc=s1*triggerScale;
        s1sc_d = double(s1sc); % Right now s1sc is class type uint16, converting to double
        
        % Calculating Signal Changes, RF Pulses, and start/end of imaging
        d1 = diff(s1sc_d); % Difference between signal values, will produce negative values as well if in class double
        
        % Counting the number of RF cycles, subtracting the last signal, which is just an end signal.  Also, dividing by two because each TR cycle has two signal changes.
        RF = (length(find(d1)) - 1)/2;
        
        % Repetition time and Sampling frequency for the ext. trigger, resp, puls,
        % and ecg.  ***Need to adjust sampling freqs if equipment changes***
        Fs_ext = 200;
        Fs_r = 50;
        Fs_p = 50;
        Fs_ratio_r = Fs_r/Fs_ext;
        Fs_ratio_p = Fs_p/Fs_ext;
        
        start2 = find(d1,2); % Find first two changes in signal
        TR = (start2(2) - start2(1))/Fs_ext; % Calculating TR (Only needed to calculate end trigger time).
        %TR = 2; % Manual TR input (Only needed to calculate end trigger time)
        
        % Start and end indice (ext trigger)
        start_trig = find(d1, 1); % Start time is found by determining first change in signal (Only works if ext trigger has activity before first TR sequence)
        end2 = find(d1, 2, 'last'); % Finding last two changes in signal
        end_trig = end2(1); % End time is found by determining second to last change in signal (last change is off signal which is irrelevant).
        
        % Start and end sample number (resp) & rounding up (To match trigger time)
        start_r = ceil(start_trig * Fs_ratio_r); % Rounding up (ceil) to match time of external signal (time from external signal actually rounds down due calculation from diff)
        end_r = ceil(end_trig * Fs_ratio_r);
        
        % Start and end sample number (puls) & rounding up (To match trigger time)
        start_p = ceil(start_trig * Fs_ratio_p);
        end_p = ceil(end_trig * Fs_ratio_p);
        
        % Clipped ext, resp, puls
        ext_t = t1(start_trig:end_trig);
        ext_s = s1sc(start_trig:end_trig);
        
        resp_t = t2(start_r:end_r);
        resp_s = s2(start_r:end_r);
        
        puls_t = t3(start_p:end_p);
        puls_s = s3(start_p:end_p);
        
        % Down-sample trigger signal to 50Hz.  It seems that every 2nd sample out
        % of 4 is where trigger changes occur.  Will take this row for now.
        parse_constant = inv(Fs_ratio_r);
        % Reshape is the easiest way to down-sample this time series.  Need to
        % clip the signal to fit as rectangular matrix.
        d_ext_s = reshape(ext_s(1:(end-mod(length(ext_s),parse_constant))),[parse_constant floor(length(ext_s)/parse_constant)]);
        d_ext_s = d_ext_s(2,:);
        if size(d_ext_s,2) < size(resp_s,1)
            d_ext_s(end+1) = d_ext_s(end); % Pseudo-fill, due to clipping for reshape
        end
        
        % Writing with comma delim
        col_n = 5;
        out = cell([length(d_ext_s) col_n]);
        
        out(:,1) = num2cell(resp_t);
        out(:,2) = num2cell(d_ext_s);
        out(:,3) = num2cell(puls_s);
        % Leave 4 empty, no ECG
        out(:,4) = num2cell(zeros([length(d_ext_s) 1]));
        out(:,5) = num2cell(resp_s);
        
        cell2csv([p_dir file1 '_out.txt'], out);
        save([p_dir file1 '_resp.mat'],'resp_s','resp_t');
        
    catch ME
        disp(ME);
    end
end

% % Writing ASCII text files with dlmwrite.
% dlmwrite([p_dir file1 '_ext.txt'], d_ext_s)
%
% if exist('resp_s', 'var')
%     dlmwrite([p_dir file1 '_resp.txt'], resp_s)
% end
%
% if exist('puls_s', 'var')
%     dlmwrite([p_dir file1 '_puls.txt'], puls_s)
% end
%
% end

end