% PCID Phys Data Processing
% 8/1/13
% Author: Ken Hwang, M.S.

tic;

% Path
p = mfilename('fullpath');
dir = fileparts(p);

addpath(genpath('C:\Users\krh5058\Documents\SLEIC\PCID\sieglephystools'));

timedir = [dir filesep 'timing'];
[~,subj] = system(['dir /b ' timedir]);
subj = regexp(subj(1:end-1),'\n','split'); % From timing\

datdir = uigetdir(dir);
[~,d] = system(['dir /s/b ' datdir filesep '*out.txt']);
d = regexp(d(1:end-1),'\n','split');

subj2 = unique(cellfun(@(y)(regexp(y,'00\d{2,2}','match')),d)); % From data\

% Run format
run = [repmat(0,[7 1]); ... % Beginning (0)
    repmat(1,[12+(7*5) 1]); ... % Section (1)
    repmat(2,[12+(7*5) 1]); ... % Section (2)
    repmat(3,[12+(7*5) 1]); ... % Section (3)
    repmat(4,[12+(7*5) 1]); ... % Section (4)
    repmat(5,[8 1])]; % End (5)
run_n = length(run);

beg_n = 7;
end_n = 8;

run_names = cell([run_n 1]);
[run_names(1:beg_n)] = deal({'MC'});

for r = 8:47:(run_n-end_n)
    [run_names([r r+1 r+3 r+5 r+7 r+9 r+11])] = deal({'Instruction'});
    run_names{r+2} = 'ListenToCount';
    run_names{r+4} = 'CountSilence';
    run_names{r+6} = 'Condition'; % Parse from subj_cell{X,1}
    run_names{r+8} = 'Emote'; % Parse from subj_cell{X,2}
    run_names{r+10} = 'Reflect';
    [run_names([r+12:r+12+34])] = deal({'MC'});
end

[run_names(run_n-end_n+1:run_n-2)] = deal({'MC'});
run_names{run_n-1} = 'Instruction';
run_names{run_n} = 'EndSilence';

run_template = [num2cell(run) run_names];

pres_names = {'ListenToCount','CountSilence','Condition','Emote','Reflect','MC'};

% Timing data
subj_cell = cell([length(subj) 2]); % Subject condition and run orders
onset_cell = cell([length(subj) 3]); % Data from text files
runtime_cell = cell([length(subj) 3]); % Runtime lengths by subj x 

for j = 1:length(subj)
    [~,temp_d] = system(['dir /b ' timedir filesep subj{j}]);
    
    % Use summary text to get condition and order
    [~,summary] = system(['dir /b/a-d ' timedir filesep subj{j} filesep temp_d(1:end-1) filesep '*summary.txt']);
    summary = summary(1:end-1);
    fid = fopen([timedir filesep subj{j} filesep temp_d(1:end-1) filesep summary]);
    
    fgetl(fid);fgetl(fid); % Skip
    
    cond = fgetl(fid);
    cond = cond(regexp(cond,'(Condition: )','end')+1:end);
    order = fgetl(fid);
    order = order(regexp(order,'(Emotion Presentation Order: )','end')+1:end);
    order = regexp(order,',\s','split');
    
    fgetl(fid);fgetl(fid); % Skip
    
    temp_runtime_data = cell([1 3]);
    temp_runtime_data{1} =  fgetl(fid);
    temp_skip1 = fgetl(fid);
    if isempty(regexp(temp_skip1,'End-Silence', 'once'))
        temp_runtime_data{2} = temp_skip1;
    else
        temp_runtime_data{2} = fgetl(fid); 
    end
    
    temp_skip2 = fgetl(fid);
    if isempty(regexp(temp_skip2,'End-Silence', 'once'))
        temp_runtime_data{3} = temp_skip2;
    else
        temp_runtime_data{3} = fgetl(fid); 
    end
    
    temp_runtime_names = cellfun(@(y)(regexp(y,'Fear|Happy|Sad','match')),temp_runtime_data);
    [I,J] = sort(temp_runtime_names);
    temp_runtime_vals = cellfun(@str2double,cellfun(@(y)(regexp(y,'\d*[.]\d*','match')),temp_runtime_data));
    runtime_cell(j,:) = num2cell(temp_runtime_vals(J));
    
    subj_cell{j,1} = cond;
    subj_cell{j,2} = order;
    
    [~,cond_d] = system(['dir /b/ad ' timedir filesep subj{j} filesep temp_d(1:end-1) filesep subj{j} '*']);    
    cond_d = regexp(cond_d(1:end-1),'\n','split');
    
    % Loop through each order/run
    for jj = 1:length(cond_d)
        [~,txtlist] = system(['dir /b ' timedir filesep subj{j} filesep temp_d(1:end-1) filesep cond_d{jj}]);
        txtlist = regexp(txtlist(1:end-1),'\n','split');
        
        tempcell = cell([length(txtlist) 2]);
        
        % Loop through each sub-section within run
        for jjj = 1:length(txtlist)
            fid2 = fopen([timedir filesep subj{j} filesep temp_d(1:end-1) filesep cond_d{jj} filesep txtlist{jjj}]);
            tempdat = textscan(fid2,'%f%f%d','Delimiter','\t');
            pres = regexp(txtlist{jjj},'[^_]*[.]','match');
            pres = pres{1}(1:end-1);
            
            tempcell{jjj,1} = pres;
            tempcell{jjj,2} = tempdat{1};
        end
        
        onset_cell{j,jj} = tempcell;
    end
end

% At this point, subj_cell and onset_cell are populated (from timing files)

fclose('all');

% Check for incomplete runs & parse onset times onto run_template
skip = zeros([size(onset_cell,1) size(onset_cell,2)]); % Skip these runs due to mismatch in presentation number
subjrun_cell = cell([length(subj) 3 2]); % Will contain run data, and section onset/offset.  x = subj, y = run, z(1) = run onsets/condition, or z(2) by-section onset/offset
subjpres_cell = cell([length(subj) 3]);

for k = 1:size(onset_cell,1)
   for kk = 1:size(onset_cell,2)
       if sum(cellfun(@length,onset_cell{k,kk}(:,2))) ~= run_n % Missing run data
           skip(k,kk) = 1;
       else
           % Consolidate onset times
           subjrun_data = run_template;
           count_temp = ones([length(onset_cell{k,kk}(:,2)) 1]);
           
           cond = subj_cell{k,1};
           switch kk % Assuming alphabetical order in cond_d listing
               case 1
                   emote = 'Fear';
               case 2
                   emote = 'Happy';
               case 3
                   emote = 'Sad';
           end
           
           for kkk = 1:run_n
               switch subjrun_data{kkk,2}
                   case 'Condition'
                       search = cond;
                       subjrun_data{kkk,2} = cond;
                   case 'Emote'
                       search = emote;
                       subjrun_data{kkk,2} = emote;
                   otherwise
                       search = subjrun_data{kkk,2};
               end
               
               onset_cell_index = find(strcmp(search,onset_cell{k,kk}(:,1))); % Use 'search' to find index in onset_cell
               
               subjrun_data{kkk,3} = onset_cell{k,kk}{onset_cell_index,2}(count_temp(onset_cell_index)); % Use onset_cell_index to get cumulative index in a given condition, and use that to find the corresponding index (due to repeats)
               count_temp(onset_cell_index) = count_temp(onset_cell_index) + 1;
           end
           subjrun_cell{k,kk,1} = subjrun_data; % Save run order data
           
           % Break-down by section
           section_onsets = cell([4 length(pres_names)]);
           
           for s = 1:4 % Only "real" sections are indexed at 1:4.  0 and 5 are beginning and end, respectively.
               section_ind = find([subjrun_cell{k,kk}{:,1}]==s);
               section = subjrun_cell{k,kk}(section_ind,2:3); % Parsing section only
               for ss = 1:length(pres_names)
                   switch pres_names{ss}
                       case 'Condition'
                           search = cond;
                       case 'Emote'
                           search = emote;
                       otherwise
                           search = pres_names{ss};
                   end
                   pres_ind1 = find(strcmp(section(:,1),search),1); % All sections are consecutive and do not overlap, does not include Instruction
                   
                   if ss ~= length(pres_names)
                       offset = section{pres_ind1+1,2}; % All but MC offset on next index
                   else
                       offset = subjrun_cell{k,kk}{max(section_ind)+1,3}; % MC needs offset from first onset in next section
                   end
                   
                   section_onsets{s,ss} = [section{pres_ind1,2} offset]; % Record onset/offset for each section
               end
           end
           subjrun_cell{k,kk,2} = section_onsets; % Save section onset/offset data
       end
   end
end

% At this point, subjrun_cell is populated.  This is a secondary
% organization to onset_cell.  It applies an onset to each (3)
% run_template, breaks runs into section and condition, then calculates
% onset and offset time to each condition (by section).

% Resp and HR data
forindex = length(d);

p_cell = cell([forindex 1]);
b_cell = cell([forindex 1]);

TR = 3; % Specify TR

calcTime = zeros([forindex 1]);

for i = 1:forindex
    tic;
    [p,f] = fileparts(d{i});
    resp = load([p filesep f(1:end-3) 'resp.mat']);
    b_cell{i} = pmu_brthpm(resp.resp_s,resp.resp_t);
    p_cell{i}=readfiezcc(d{i});
    
    % Each file in d, is represented by the same index in p_cell/b_cell.
    % Each row in subjrun_cell(:,:,2) is by subject in "subj".  The column
    % order is Fear, Happy, Sad (alphabetically).  subj_cell(:,2) is the
    % order of actual presentation.  It is assumed that "1", "2", and "3"
    % in the phys data is associated with the orders in subj_cell(:,2).
    % E.g.  If the order in subj_cell(:,2) is Happy, Sad, Fear.  Then, "1"
    % will stand for the "Happy" run, and so on.
    
    temp_subj = regexp(p,'00\d{2,2}','match');
    sindex = find(strcmp(temp_subj{1},subj));
    
    if ~isempty(sindex) % If physio timing file is present
        oindex = str2double(f(regexp(f,'_\d_')+1)); % Order index from file name
        switch subj_cell{sindex,2}{oindex} % Match file with order
            case 'Fear'
                eindex = 1;
            case 'Happy'
                eindex = 2;
            case 'Sad'
                eindex = 3;
        end
        
        temp_onset = subjrun_cell{sindex,eindex,2};
        
        % Section x pres_name x DV (1 = bpm, 2 = brthpm, 3 = lfhrv, 4 = hfhrv
        out_cell = cell([size(temp_onset,1) size(temp_onset,2) 4]); 
        out_f1 = [p filesep f(1:end-3) 'bpm.csv'];
        out_f2 = [p filesep f(1:end-3) 'brthpm.csv'];
        out_f3 = [p filesep f(1:end-3) 'lfhrv.csv'];
        out_f4 = [p filesep f(1:end-3) 'hfhrv.csv'];
        
        out2_f1 = [p filesep f(1:end-3) 'bpm_smplfreq.csv'];
        out2_f2 = [p filesep f(1:end-3) 'brthpm_smplfreq.csv'];
        out2_f3 = [p filesep f(1:end-3) 'lfhrv_smplfreq.csv'];
        out2_f4 = [p filesep f(1:end-3) 'hfhrv_smplfreq.csv'];
        
        out3_f1 = [p filesep f(1:end-3) 'bpm_tr.csv'];
        out3_f2 = [p filesep f(1:end-3) 'brthpm_tr.csv'];
        out3_f3 = [p filesep f(1:end-3) 'lfhrv_tr.csv'];
        out3_f4 = [p filesep f(1:end-3) 'hfhrv_tr.csv'];  
        
        for ii = 1:size(temp_onset,1)
            for iii = 1:size(temp_onset,2)
                
                temp_sample_range = temp_onset{ii,iii}*p_cell{i}.RescaleFactor;
                temp_sample_range = [floor(temp_sample_range(1)) ceil(temp_sample_range(2))];
                
                if max(temp_sample_range) > size(p_cell{i}.tick,1)
                    disp(['Issue in file: ' d{i}]);
                    disp(['Requested Sample (' int2str(max(temp_sample_range)) ') exceeds data bounds.  Physiological data stream did not last as long as presentation.']);
                else
                    bpm = mean(p_cell{i}.curhr(temp_sample_range(1):temp_sample_range(2)));% Average beats/min
                    
                    brthps = sum(b_cell{i}(temp_sample_range(1):temp_sample_range(2)))/diff(temp_onset{ii,iii}); % # of Breaths / Time range (sec)
                    brthpm = brthps * 60; % Breaths/second * 60 seconds/min = Breaths/min
                    
                    lfhrv = mean(p_cell{i}.lfhrv(temp_sample_range(1):temp_sample_range(2))); % Average Low-frequency heart rate variability
                    
                    hfhrv = mean(p_cell{i}.hfhrv(temp_sample_range(1):temp_sample_range(2))); % Average High-frequency heart rate variability
                    
                    out_cell{ii,iii,1} = bpm;
                    out_cell{ii,iii,2} = brthpm;
                    out_cell{ii,iii,3} = lfhrv;
                    out_cell{ii,iii,4} = hfhrv;
                end
                
            end
        end
        
        cell2csv(out_f1,out_cell(:,:,1));
        cell2csv(out_f2,out_cell(:,:,2));
        cell2csv(out_f3,out_cell(:,:,3));
        cell2csv(out_f4,out_cell(:,:,4));
        
        if ~skip(sindex,eindex)
            
            acqIntvl = 1/p_cell{i}.RescaleFactor;
            
            % Format output cell for each dv
            out2_cell = cell([4 1]);
            out3_cell = cell([4 1]);
            
            % For "_smplfreq", by sample, determine condition and apply value
            for jj = 1:4 % By DV
                switch jj % Switch by DV
                    case 1 % bpm
                        temp_dv = p_cell{i}.curhr;
                    case 2 % brthpm
                        %                     temp_dv = b_cell{i};
                        continue; % Cannot calculate at this sample rate
                    case 3 % lfhrv
                        temp_dv = p_cell{i}.lfhrv;
                    case 4 % hfhrv
                        temp_dv = p_cell{i}.hfhrv;
                end
                
                temp_samples = cell([length(temp_dv) 3]); % Pre-allocate sample vector
                temp_samples(:,1) = num2cell(temp_dv);
                
                temp_onset2 = subjrun_cell{sindex,eindex,1}(:,3); % Vector of onsets
                
                for jjj = 1:length(temp_dv) % By sample (sample 1 = index 1)
                    time_s = jjj*acqIntvl;
                    
                    % Subtract and look in only negative numbers, find the last value (closed index to time sample)
                    temp_sample_conditions = {subjrun_cell{sindex,eindex,1}{find(([temp_onset2{:}] - time_s) < 0,1,'last'),1:2}};
                    if ~isempty(temp_sample_conditions) % Only if not empty (a.k.a. uncaptured)
                        temp_samples(jjj,2:3) = temp_sample_conditions;
                    end
                end
                
                out2_cell{jj} = temp_samples;
                
                % For "_tr".  Determine TR window and average DV within
                % window.  This is condition independent.
                simTR = num2cell(0:TR:floor(runtime_cell{sindex,eindex}));
                temp_tr = cell([length(simTR)-1 3]); % Ignore final offset (within interval calculations)
                temp_tr(:,1) = simTR(1:end-1); % Ignore final offset (within interval calculations)
                temp_tr(:,2) = num2cell(diff(cell2mat(simTR)));
                samples_s = (1:length(temp_dv)).*acqIntvl;
                for jjj = 1:(length(simTR)-1) % By TR (TR 0 = index 1), calculating within interval (length-1)
                    temp_tr{jjj,3} = mean(temp_dv(samples_s <= simTR{jjj+1} & samples_s > simTR{jjj}));
                end
                
                out3_cell{jj} = temp_tr;
                
            end
            
            cell2csv(out2_f1,out2_cell{1});
            %         cell2csv(out_f2,out_cell{2}); % Cannot calculate brthrpm at this sample rate
            cell2csv(out2_f3,out2_cell{3});
            cell2csv(out2_f4,out2_cell{4});
            
            cell2csv(out3_f1,out3_cell{1});
            %         cell2csv(out_f2,out_cell{2}); % Cannot calculate brthrpm at this sample rate
            cell2csv(out3_f3,out3_cell{3});
            cell2csv(out3_f4,out3_cell{3});
        end
    end
    
    calcTime(i) = toc;
    disp('stop');
    
end

toc;