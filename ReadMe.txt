2/16/14


Report summary:
- Total processing time: 2129.10 seconds (35.4850 minutes)
- Processing time per physiological data file (without organizational overhead) is approximately 82 seconds.
- Additional files: 144
- Organizational structure: ../data/[subj]/[fileID_run#]
- New addition filename formats: bpm_smplfreq.csv, lfhrv_smplfreq.csv, hfhrv_smplfreq.csv, bpm_tr.csv, lfhrv_tr.csv, hfhrv_tr.csv


General Notes:
- Post-processing script on current data
- Exvolt formatting not included
- 0058_Neutral_Happy does not have timing data
- Excluding missing data.  Client informed on 6/7/13:
1) Inconsistent data:
- 0026 is missing run “1”
- 0028 has 2 sets of data that contain run “2” in it: 201212131930_2 and 2012121310930_2.  Using only the first one, and considering run “3” as missing.
- 0035 is missing run “1”
- 0045 is missing run “1”
- 0047 is missing run “1”
- Excess run folders in 0030 (0030_Neutral_20121207T163820) and 0058 (0058_Neutral_20130403T112844 and 0058_Neutral_20130403T113059).  Considered as aborted runs, and are thrown out.
- 0054 contained 0053’s exact timing folders, 0054 has been thrown out
- 0035\201212041300_2 has a timing range that exceeds physiological data range.  Final section "MC" data omitted.
- Excluding additional missing timing data /0044.  Was not listed last time.
- Excluding breath rate calculations.  Inappropriate sampling rate for frequency analysis.  3rd party data analysis does not handle breath rate calculations:
- Client informed on 6/14/13:
2) I am fairly certain sieglephystools does not perform breath rate calculations.  (At least, I haven't found any code corresponding with it yet.)  However, Susan does have an algorithm to do this already.
- Files with irregularities between task timing or physiological data stream length will produce various results.  0035 is one example.


Notes (for “_tr” output):
- Assuming TR is 3 from examples
- First column specifications unclear: “with the first column being seconds”.  Units, but not onset/offset.  In example, first sample and column would be offset.  However, physiological data and timing both have data prior to offset.  Ignoring example and considering to be onset.  Consequently, labeling first row, first column as time = 0.
- Producing TR onsets and intervals deterministically.  Actual acquisition time unavailable.
- TR length is determined from summary text files.  If TR length is longer than physiological data stream, NaN will produce due to lack of data points.


Notes (for “_smplfreq” output):
- Unsure of nomenclature specifications: “(6) Manipulation Check, and (7) ManipulationCheck”
- No specification of beginning “MC”, ending “MC”, ending “Instruction”, and ending “EndSilence”
- No specification of data samples not captured by onset of script stimulus
- No specification of all “Instruction” periods
- Due to request for all data samples without clear exemplars of nominal values at each sample, nomenclature is as follows:
Column 2 (Section-specific):
- [Blank]: Uncaptured
- 0: Beginning section
- 1: Section 1
- 2: Section 2
- 3: Section 3
- 4: Section 4
- 5: Ending section
Column 3 (Event-specific):
- [Blank]: Uncaptured
- “MC”
- “Instruction”
- “ListenToCount”
- “CountSilence”
- [Higher order condition] (e.g. “Neutral”, “Relax”, “Worry”)
- [Lower order condition] (e.g. Fear, Happy, Sad)
- “Reflect”
- “EndSilence”


2/15/14


General Notes:
- Post-processing script on current data.  Exvolt formatting not included.
- 0058_Neutral_Happy does not have timing data
- Excluding missing data.  Client informed on 6/7/13:
1) Inconsistent data:
- 0026 is missing run “1”
- 0028 has 2 sets of data that contain run “2” in it: 201212131930_2 and 2012121310930_2.  Using only the first one, and considering run “3” as missing.
- 0035 is missing run “1”
- 0045 is missing run “1”
- 0047 is missing run “1”
- Excess run folders in 0030 (0030_Neutral_20121207T163820) and 0058 (0058_Neutral_20130403T112844 and 0058_Neutral_20130403T113059).  Considered as aborted runs, and are thrown out.
- 0054 contained 0053’s exact timing folders, 0054 has been thrown out
- 0035\201212041300_2 has a timing range that exceeds physiological data range.  Final section "MC" data omitted.


Notes (“_tr”):
- Assuming TR is 3 from examples
- Not including TRs after EndSilence
- Can include at later date at client request.


Notes (“_smplfreq”): 
Nomenclature:
1. ListenToCount
2. CountSilence
3. Condition
4. Emote (Fear, Happy, Sad)
5. Condition (Relax, Worry, Neutral)
6. MC
- Only using data within sections, beginning MC and ending MC, Instruction and EndSilence are 0
- Can include at later date at client request.
- Instruction are considered 0
- Unsure difference between (6) Manipulation Check, and (7) ManipulationCheck
- Different number of samples between breath rpm and sieglephystools output.  Again, unsure how 3rd party package performs calculations.
- Client informed on 6/14/13:


1) Firstly, I simply connected the dots between our physiological output and the sieglephystools input.  I've looked slightly into Greg Siegle's package and there are a lot of parameters (such as for bandpass filtering) that I am assuming meets the standards for this project.  Although Susan and I also have a data analysis pipeline with our own methods for physiological data stream analysis, it is important to remember that in either case these analysis procedures are in no way straightforward.  That being said, if you guys are satisfied with the results from sieglephystools, then I will move forward with this approach.  However, the downside is that no one, outside of Greg Siegle, is readily available to provide a description of the methodology.  (Moreover, sieglephystools is not very well commented, which makes it more difficult to understand.)  The alternative would be to use mine and Susan's homegrown package, which is not entirely prepared to perform HRV analyses.  However, our procedures will also be based off our own evaluation of the data and understanding of signal analysis, which will result in best-informed tweaking of methodology (e.g. beat threshold, signal smoothing, rate calculation method, etc.).  I imagine that Greg Siegle is more of an expert in this respect.


________________


2) I am fairly certain sieglephystools does not perform breath rate calculations.  (At least, I haven't found any code corresponding with it yet.)  However, Susan does have an algorithm to do this already.


8/7/13


Please see attached for data output.


Some notes:


1) Inconsistent data:
- 0026 is missing run “1”
- 0028 has 2 sets of data that contain run “2” in it: 201212131930_2 and 2012121310930_2.  Using only the first one, and considering run “3” as missing.
- 0035 is missing run “1”
- 0045 is missing run “1”
- 0047 is missing run “1”
- Excess run folders in 0030 (0030_Neutral_20121207T163820) and 0058 (0058_Neutral_20130403T112844 and 0058_Neutral_20130403T113059).  Considered as aborted runs, and are thrown out.
- 0054 contained 0053’s exact timing folders, 0054 has been thrown out
- 0035\201212041300_2 has a timing range that exceeds physiological data range.  Final section "MC" data omitted.


2) Data that was capable of being processed return a .csv with either "bpm", "brthpm", "lfhrv", and "hfhrv" in the file name.  Each csv has 6 columns and 4 rows.  Each row signifies the data within each run's section (1-4).  Column format is as follows:


Column 1: "ListenToCount"
Column 2: "CountSilence"
Column 3: Worry/Relax/Neutral conditon
Column 4: Happy/Sad/Fear condition
Column 5: "Reflect"
Column 6: "MC"


3) I took the run order from the summary text file, and assumed "1", "2", and "3" in the physio data file names referenced the index within this order.  E.g.  If the order was "Happy, Sad, Fear", then "1" would stand for the "Happy" run and so on.


4) The data directory follows exactly how the physio data was given to me.  It is first separated by subject ID, then each .csv file has the corresponding filename, order number, and dependent variable in its name.


Let me know if you have any questions.


Ken


8/6/13


    % Each file in d, is represented by the same index in p_cell/b_cell.
    % Each row in subjrun_cell(:,:,2) is by subject in "subj".  The column
    % order is Fear, Happy, Sad (alphabetically).  subj_cell(:,2) is the
    % order of actual presentation.  It is assumed that "1", "2", and "3"
    % in the phys data is associated with the orders in subj_cell(:,2).
    % E.g.  If the order in subj_cell(:,2) is Happy, Sad, Fear.  Then, "1"
    % will stand for the "Happy" run, and so on.


Dependent variables:


beats/min, curhr
brths/min
lfhrv
hfhrv


Added checks for timing ranges exceeding physiological data range:
- 0035:  201212041300_2


8/2/13 


Phys Data Notes --


Inconsistent data:
- 0026 is missing run “1”
- 0028 has 2 sets of data that contain run “2” in it: 201212131930_2 and 2012121310930_2.  Using only the first one, and considering run “3” as missing.
- 0035 is missing run “1”
- 0045 is missing run “1”
- 0047 is missing run “1”
- Excess run folders in 0030 (0030_Neutral_20121207T163820) and 0058 (0058_Neutral_20130403T112844 and 0058_Neutral_20130403T113059).  Considered as aborted runs, and are thrown out.
- 0054 contained 0053’s exact timing folders, 0054 has been thrown out


2-13-12


Time commitment: 5
Fixed bug where last MC in group would be tallied as ‘NA’
- Issue was due to leaving response handling during silence durations, which was to capture ‘esc’ key, but a line of code that was made to report ‘NA’ during MC questions without an answer interfered.
- Included if statement to ignore this line of code during non-MC questions
-Fixed bug to remove error of undefined endSilencetime variable, which only existed without early abort.


12-14-12


Fixed ordering bug with sort.


12-3-12


Fixed bug, so practice ignores emote(pres_i).endTime.
Added EndSilence time start to summary.


11-26-12


- Saved prescell.mat to /bin.
- Line 308: Removed Neutral check in if statement.
- Using .jpg formatted pictures.
- Added EndSilence wait time to 1200 - (GetSecs - startTime).  1140s taken from below.  Need to change this value to exact timing.  Processing speed adds additional latencies between presentations.
- Added CondName object property to PresSelect.m.  Added CondName input for object definition in pcid.m
- Added CondName object property to datafiler.m.  Fixed an issue where MC4 and MC7 responses were not recorded due to incorrect regular expression.
- Added endTime to emote structure for total time duration of each run.
- Recorded emote.endTime to summary output file.
- Max time calculation:


Beginning: 
 MC1: 3*7=21s


Section:
 Instructions: 1s
 Instructions: 1s
 Listen to Count: ~30s
 Instructions: 1s
 Count Silence: 30s
 Instructions: 1s
 Worry/Relax/Neutral Silence: 30s
 Instructions: 1s
 Emote Block: ~40s
 Instructions: 1s
 Reflect Silence: 30s
 Instructions: 1s
 MC2: 3*7=21s
 MC3: 3*7=21s
 MC4: 3*7=21s
 MC5: 3*7=21s
 MC6: 3*7=21s


End:
 MC2: 5*6=30s
 Instructions: 1s


1 Section: ~272s
4 Sections: ~1088s
Beginning + End: 52s
Total: ~1140s = 19m


11/14/12
Requested: 
- Have Neutral conditions equate Worry/Relax conditions by filling in Silence and MC (4 and 7) with neutral replacements
- Listen/Count output naming change
- Buffer additional time at end of run with silence.  Output this as its own file.
- Change max wait time for regular MCs to 3 and end MCs to 5.
- Add modified prescell.mat to directory structure.


Changes in progress:
pcid.m
- Line 212: Changed commented prescell to include 'Audio', 'EndSilence'.  Need to save and add to directory.
- Lines 221-228 & 243: Removed Neutral if statement to remove *|# symbols from prescell skeleton
- Lines 262 & 270: Commented out Neutral if statement for modification of final MC (7).  Still need this MC7 (Happy and FearorSad) for neutral conditions
- Lines 308-320: Need to adjust headerNames to include Neutral MC questions.
- Lines 469, 477, & 479: Changed from '7' to '8' outputs to include end silence.
- Lines 480, 481, & 483: Commented out Neutral if statement to skip output 5.
PresSelect.m
- Line 39: Added CondName to property values of PresSelect.m
- Line 129: Set max wait time to '5' from '3'
- Line 154: Set Max wait time to '3' from '5'
- Lines 194-198: Added if statement for checking '^End' expression.  Will change waitlimit to maximum run time duration minus current time stamp minus start time stamp of run.
- Lines 207-210: Commented out Worry/Relax silence.  Will add Neutral, but need to allow for 'CondName' property.
- Lines 217-220: Added and commented out End Silence if statement to write file.  Will uncomment when line 195 is corrected for.
- Line 222: Set max wait time to '3' from '5'




11-07-12


- Changed count title format


ToDo:
Change count title format
Change neutral (need practice, instructions, and MC) to match Relax/Worry
Get Total Time Count


10/19/12


Fixed bug so that escape will work in between trials.
Restricted KbStrokeWait’s to spacebar.


10/16/12


Max run time:


Beginning:
 MC1: 35


Section:
Instructions: 2
Listen to Count ~ 30
Instructions: 1
Count Silence: 30
Instructions (Worry/Relax): 1
Worry/Relax Silence: 30
Instructions: 1
Emote Block ~ 40
Instructions: 1
Reflect Silence: 30
Instructions: 1
MC2: 35
MC3: 35
MC4: 35
MC5: 35
MC6: 35


End:
MC7: 42
Instructions: 1 


Worry/Relax:
1 Section = 342s
4 Sections = 1368s
4 Sections + extra = 1446s


Neutral:
1 Section = 276s
4 Sections = 1104s
4 Sections + extra = 1140s


10/1/12


-Added Sampling frequency warning if not 44.1kHz
-Added Summary output txt file.


9/28/12


-Added “Old” directory for old participant audio.
-Tested audio file swap.
-Fixed button box mapping.
-Changed Instructions screen to “Wait”
-White background on MCs only
-Removed warning, added “Press Spacebar to continue”.
        -Added Spacebar wait in between conditions.
-Screen clear removed between MC sets.
-Added Practice session prior to auto-trigger selection and presentation.
        -Neutral story labelled as “Practice.wav” in ParticipantAudio
        -Spacebar to initiate and continue afterwards.
        -No data recording.


Need to add:
        -Sampling frequency check.
        -Summary output.
                -Condition (Worry/Relax/Neutral)
                -Emotion orders (Happy/Sad/Fear)
                -Story orders (T1P1,etc.)
                -Trigger (Yes/No)
                -Total time
                -Escape early


9/27/12


-Fix instructions screen.
-Might remove screen clear
-White background on mc's only.


9/19/12


-PC .jpg display bug fixed.
-Included button box mapping, and OS-appropriate escape key mapping.
-temp cell now writes to output file.
        - Still need to include manual output write in case of crashes.
-Still need to include file check.
-PsychPortAudio is setting pahandle to 48000 Hz for some reason and this speeds up playback for wav’s that are 44100 Hz sample rate.  Changed to 44100 Hz, for now, but need to keep in mind when audio is recorded at different sample rates.


9/14/12


datafiler.m:
        - Now includes a listener for resp property.
        - When resp property changes, data is saved in a cell that is saved to a temp.mat in the subject’s data folder.
                - Need to save and overwrite .csv.


PC problems:
- Escape key (27), (and possibly others not working)
- Pictures are not presenting (directory issue?)


9/13/12


SAD changed to Sad
Subject ID input and included in data output.
        -Zero-padded
Renamed directory folder to PCID
        - Including dated notes in folder


9/9/12


File Output:
Need to separate output
Need to calculate durations
Record into resp txt (online)
Directory structure for /data?


Response:
Escape key during audio does not work.
Need to adjust .3 pause to inside KbCheck loop
Adjust so Spacebar is accessible for manual trigger


Misc:
Add Auto-trigger w/ “Waiting” Screen
Button box mapping
Strange issue with escaping during audio play
ListenChar(0)


8/21/12


PCID Update


Scripting Infrastructure:
        - Placeholder for auto-trigger.  Will implement when testing in control room.
        - Directory structure that allows for interchangeable audio files for participants.
        - .mat file that allows for modifiable presentation order
        - Files and directories follow strict nomenclature.
        - File check still under construction.


User Interface:
        - Worry/Relax/Neutral condition selection
- “Worry/Relax” selection will modify audio presentations and if “Neutral” is selected, then presentation order is modified (presentations removed).
- Happy/Sad/Fear order selection
- Currently, will only present first selection (placeholder for loop), but all emotion blocks should work. (Added 9/9/12)
        - Enabled check for order validity (any sequence violation will result in error).
- Keyboard response is working, but values 1-8 have not been implemented yet.  Most likely will wait until working with MRI button box.
        - .5 second pause after display to prevent button press overlap
        - 3 second maximum delay implemented.
        - Still need to adjust for 7 second maximum delay on final MC. (Added 9/9/12)
- Escape key implemented for abort.  Currently, user will need to wait until presentation block is finished.  Need to test for full functionality throughout run. (Added 9/9/12)


Presentation:
        - Audio and picture presentations are functional.
        - Missing “Reflect.wav”.
        - Need to test for all conditions


Output:
        - Timestamps and responses are recorded.
        - No file output yet.  Will need to format.
        - No online recording yet.
        


7/18/12


Experimental Design:


1 subject
3 txt files so far


Task:
        - Skip ahead on request
        - On-line logging
        - Auto-trigger per run
        - TR = 3
        - 6 conditions(runs):
- 3 Presentation orders, depending Worry/Relax/Neutral manipulation (counter balanced between subjects)
                - 3 pairs according to emotion (presentation order is counter balanced): 
- sad1, sad2
- fear1, fear2
- happy1, happy2                        
- 1pt1, 1pt2, 2pt1, 2pt2
                        - 2pt1, 2pt2, 1pt1, 1pt2
                        - 1 run entails:
                                1) Manipulation check (variable, max 3s each) - “MC1”[a][b]
                                2) Instructions (audio) 
- Closing eyes (~1s)
- “Listen” (~1s)                                
                                3) Listen to Count (30s, audio) [c]
                                4) Instructions (1s)
                                        - “Count”
                                5) Silence (30s) - “Counting”
                                6) Instructions (audio)
                                        - “Worry/Relax” (~1s)
                                        - Remove if Neutral
                                7) Silence (30s) 
- “Worry[d]/Relax”
- Remove if Neutral
- *** Consistent in later blocks within each run ***
                                8) Instructions (audio)
                                        - Listen (~1s)
11) Emotional Block, pt1 of either story 1 or 2 (ex: sad1pt1, fear2pt1, amust1pt1, etc.) - Duration varies (20-40s, based audio recordings) - “HappyT2P1” (ex)
12) Instructions (audio)
        - “Reflect” (~1s)
13) Silence (30s) - “Reflect”
14) Instructions (audio)
        - “Open eyes” (~1s)
13) Manipulation check (variable, max 3s per) - “MC”[e]


Times 4 for each Emotion part (Follow randomization/order as listed above)


26) Manipulation Check (variable, max 7s each) 
- 6 questions[f]
27) Close Eyes (audio) 
- “CloseEyes”
28) Notification to RA - END
28) Silence until reached max time
        - 1240s (~20min)


Response Recording:
L -> R 
        1:8


Output:
Timing of each event , Responses for each manipulation check
Column 1: Onset (sec)
Column 2: Duration (sec)
Column 3: 1s
        - Separate time txt files for:
                - Instructions
                - Listen Count
                - Counting Out Loud
                - Worry/Relax
                - Emotion (all parts)
                        - Separate for each (Happy, Fear, SAD)
                - Reflect
                - Manipulation Checks (Including beginning, final, 1-7)
                        - Timing for individual questions.
        - Separate response txt files:
                        - Last MC is only 6
                        - Some questions have blank responses (Mark “NA”)
                        - 1 row per participant: MCs grouped in 7s
                                - Headers: 
Ex: Happy_MC1_T1_Q1 >>> Happy_MC7_T1_Q6
      SAD_MC1_T1_Q1 >>> SAD_MC7_T1_Q6
-*** Neutral will be shorter because of less MCs


6/6/12


E-prime > FSL
1 subject
3 txt files so far


Task:
        - 6 conditions(runs):
- 4 presentations/parts per condition
- 2 Presentation orders, depending Worry/Relax manipulation (counter balanced across subjects)
                        - 1pt1, 1pt2, 2pt1, 2pt2
                        - 2pt1, 2pt2, 1pt1, 1pt2
                - 3 pairs according to emotion (presentation order is counter balanced): 
- sad1, sad2
- fear1, fear2
- amuse1, amuse2
                        - 1 run entails:
                                1) Manipulation check (variable, max 21s) - “MC1”
                                2) Instructions (2s) - “CloseEyesSound, CountSound”
                                3) Count (30s) - “Rest”
                                4) Instructions (2s) - “OpenEyesSound”
                                5) Manipulation check(variable, max 21s) - “MC2”
                                6) Instructions (2s) - “CloseEyesSound1, WorrySound”
                                7) Worry/Relax (30s) - “Worry”
*** Consistent in later blocks within each run ***
                                8) Instructions (2s) - “OpenEyesSound1”
                                9) Manipulation check(variable, max 21s) - “MC3”
                                10) Instructions (2s) - “CloseEyesSound2, ListenSound”
11) Emotional Block, pt1 of either story 1 or 2 (ex: sad1pt1, fear2pt1, amust1pt1, etc.) - Duration varies (20-40s, based audio recordings) - “AmuseT2P1” (ex)
12) Instructions (2s) - “OpenEyesSound2” *** This comes before #11 (AmuseT2P1) ***
13) Manipulation check (variable, max 21s) - “MC4”
14) Instructions (2s)  - “CloseEyesSound, CountSound”
15) Count (30s)
16) Instructions (20s)
17) Manipulation check (variable, max 21s) - “MC2”
18) Instructions (2s)
19) Worry/Relax (30s)
20) Instructions (2s)
21) Manipulation check (variable, max 21s) - “MC3”
22) Instructions (2s)
23) Emotional Block, pt2 of story 1 or 2 depending on #11 (ex: sad1pt2, fear2pt2, amust1pt12 etc.) - Duration varies (20-40s, based audio recordings)
24) Instructions (2s) - “OpenEyesSound2”
25) Manipulation check (variable, max 21s) - “MC4”
*** Steps 2-25 one more time ***
        26) Manipulation Check (variable, max 69s) - “WorryContrast1-6”
27) Close Eyes (1s) - “CloseEyes”




Level: 4
	*** LogFrame Start ***
	Procedure: MCSlpe1
	MC1: 1
	FileName: Manipulation_Check_MartyItems_800x600_RIGHTNOW/Slide1.gif
	Running: MC1
	MC1.Cycle: 1
	MC1.Sample: 1
	MCImage.OnsetDelay: 89
	MCImage.OnsetTime: 16977
	MCImage.DurationError: 2
	MCImage.PreRelease: -1
	MCImage.Duration: 3000
	MCImage.StartTime: 16964
	MCImage.OffsetTime: 16979
	MCImage.FinishTime: 16979
	MCImage.TimingMode: 1
	MCImage.CustomOnsetTime: 0
	MCImage.CustomOffsetTime: 0
	MCImage.ActionDelay: 0
	MCImage.ActionTime: 16977
	MCImage.TargetOffsetTime: 16888
	MCImage.TargetOnsetTime: 16888
	MCImage.PendingInputMasks: 0
	MCImage.OffsetDelay: 91
	MCImage.RTTime: 18647
	MCImage.ACC: 0
	MCImage.RT: 1670
	MCImage.RESP: 8
	MCImage.CRESP: 
	MCImage.Tag: 
	MCImage.OnsetToOnsetTime: 0
	

Need:
Timing of each event , Responses for each manipulation check
Column 1: Onset (sec)
Column 2: Duration (sec)
Column 3: 1s
        - Separate time csv files for:
                - Instructions
                - Count (“Rest”)
                - Worry/Relax
                - Emotion (all parts)
                - Manipulation Checks (Include final)
        - Separate response csv files:
                7 Columns for each question
                        - Last MC is only 6, leave final blank
                        - Some questions have blank responses


Using StartTime:


dat_cell = 


    'Proc'               'Start'     'End'       'RT'       'Resp'[g]
    'MCImage'            [ 17797]    [ 17815]    [ 1868]    '7'   
    'MCImage'            [ 19769]    [ 19780]    [ 2589]    '8'   
    'MCImage'            [ 22455]    [ 22482]    [ 2479]    '7'   
    'MCImage'            [ 25054]    [ 25063]    [ 1722]    '8'   
    'MCImage'            [ 26877]    [ 26896]    [ 1626]    '6'   
    'MCImage'            [ 28608]    [ 28629]    [ 2310]    '8'   
    'MCImage'            [ 31031]    [ 31046]    [ 2660[h]]    '6'   
    'CloseEyesSound'     [ 34111]    [ 35201]    [    0]    ''    
    'CountSound'         [ 35201]    [ 36257]    [    0]    ''    [i]
    'Rest'               [ 36258]    [ 36276]    [    0]    ''    
    'OpenEyesSound'      [ 36277]    [ 68354]    [    0]    ''    [j][k]
    'MCImage'            [ 68364]    [ 68373]    [ 2033]    '8'   
    'MCImage'            [ 70417]    [ 70440]    [ 1318]    '8'   
    'MCImage'            [ 71770]    [ 71790]    [    0]    ''    
    'MCImage'            [ 74768]    [ 74790]    [ 2489]    '7'   
    'MCImage'            [ 77289]    [ 77306]    [ 2452]    '6'   
    'MCImage'            [ 79769]    [ 79789]    [ 1433]    '7'   
    'MCImage'            [ 81235]    [ 81256]    [ 2222]    '7'   
    'CloseEyesSound1'    [ 84226]    [ 85299]    [    0]    ''    
    'RelaxSound'         [ 85299]    [ 86365]    [    0]    ''    [l]
    'Relax'              [ 86366]    [ 86389]    [    0]    ''    
    'OpenEyesSound1'     [ 86389]    [118502]    [    0]    ''    [m]
    'MCImage'            [118510]    [118519]    [ 1614]    '7'   
    'MCImage'            [120143]    [120152]    [ 1957]    '8'   
    'MCImage'            [122120]    [122135]    [ 2174]    '6'   
    'MCImage'            [124319]    [124335]    [ 1758]    '8'   
    'MCImage'            [126105]    [126118]    [ 1087]    '8'   
    'MCImage'            [127216]    [127235]    [ 1562]    '7'   
    'MCImage'            [128807]    [128818]    [ 1235]    '8'   
    'CloseEyesSound2'    [131797]    [133079]    [    0]    ''    
    'ListenSound'        [133080]    [133080]    [    0]    ''    [n][o][p]
    'SADT2P1'            [133081]    [160721]    [    0]    ''    
    'OpenEyesSound2'     [160721]    [162793]    [    0]    ''    [q]
    'MCImage'            [162801]    [162815]    [ 1909]    '8'   
    'MCImage'            [164734]    [164748]    [ 1408]    '1'   
    'MCImage'            [166168]    [166182]    [ 1407]    '8'   
    'MCImage'            [167600]    [167615]    [ 2085]    '7'   
    'MCImage'            [169713]    [169731]    [ 1745]    '1'   
    'MCImage'            [171488]    [171498]    [ 1066]    '8'   
    'MCImage'            [172575]    [172581]    [ 1751]    '1'   
    'CloseEyesSound'     [175576]    [176649]    [    0]    ''    
    'CountSound'         [176649]    [177725]    [    0]    ''    
    'Rest'               [177726]    [177747]    [    0]    ''    
    'OpenEyesSound'      [177748]    [209852]    [    0]    ''    
    'MCImage'            [209861]    [209878]    [ 2605]    '8'   
    'MCImage'            [212495]    [212511]    [ 1676]    '7'   
    'MCImage'            [214200]    [214211]    [ 2608]    '6'   
    'MCImage'            [216832]    [216844]    [ 2055]    '8'   
    'MCImage'            [218911]    [218927]    [ 1004]    '8'   
    'MCImage'            [219943]    [219960]    [ 1355]    '7'   
    'MCImage'            [221325]    [221343]    [ 2116]    '8'   
    'CloseEyesSound1'    [224316]    [225385]    [    0]    ''    
    'RelaxSound'         [225385]    [226461]    [    0]    ''    
    'Relax'              [226462]    [226476]    [    0]    ''    
    'OpenEyesSound1'     [226477]    [258598]    [    0]    ''    
    'MCImage'            [258606]    [258623]    [ 2043]    '7'   
    'MCImage'            [260676]    [260690]    [ 1264]    '8'   
    'MCImage'            [261964]    [261973]    [ 1653]    '6'   
    'MCImage'            [263636]    [263656]    [ 1946]    '8'   
    'MCImage'            [265612]    [265623]    [ 1939]    '8'   
    'MCImage'            [267574]    [267589]    [ 1949]    '7'   
    'MCImage'            [269550]    [269556]    [ 1254]    '8'   
    'CloseEyesSound2'    [272541]    [273622]    [    0]    ''    
    'ListenSound'        [273623]    [273633]    [    0]    ''    
    'SADT2P2'            [273634]    [295340]    [    0]    ''    
    'OpenEyesSound2'     [295341]    [297444]    [    0]    ''    
    'MCImage'            [297453]    [297470]    [ 1643]    '8'   
    'MCImage'            [299125]    [299137]    [ 2753]    '2'   
    'MCImage'            [301902]    [301920]    [ 1873]    '8'   
    'MCImage'            [303803]    [303819]    [ 1902]    '2'   
    'MCImage'            [305734]    [305753]    [ 2689]    '2'   
    'MCImage'            [308453]    [308469]    [ 1668]    '8'   
    'MCImage'            [310147]    [310169]    [ 2392]    '3'   
    'CloseEyesSound'     [313147]    [314215]    [    0]    ''    
    'CountSound'         [314216]    [315302]    [    0]    ''    
    'Rest'               [315303]    [315318]    [    0]    ''    
    'OpenEyesSound'      [315319]    [347429]    [    0]    ''    
    'MCImage'            [347438]    [347449]    [ 1959]    '7'   
    'MCImage'            [349421]    [349432]    [ 1928]    '1'   
    'MCImage'            [351371]    [351382]    [ 2706]    '6'   
    'MCImage'            [354099]    [354115]    [ 2277]    '1'   
    'MCImage'            [356403]    [356415]    [ 2409]    '2'   
    'MCImage'            [358834]    [358848]    [ 2712]    '8'   
    'MCImage'            [361570]    [361581]    [ 1515]    '7'   
    'CloseEyesSound1'    [364560]    [365643]    [    0]    ''    
    'RelaxSound'         [365644]    [366720]    [    0]    ''    
    'Relax'              [366721]    [366731]    [    0]    ''    
    'OpenEyesSound1'     [366731]    [398857]    [    0]    ''    
    'MCImage'            [398865]    [398878]    [ 1841]    '8'   
    'MCImage'            [400732]    [400744]    [ 1199]    '8'   
    'MCImage'            [401955]    [401961]    [ 2422]    '7'   
    'MCImage'            [404395]    [404411]    [ 1764]    '8'   
    'MCImage'            [406187]    [406194]    [ 1765]    '8'   
    'MCImage'            [407969]    [407977]    [ 2166]    '6'   
    'MCImage'            [410155]    [410177]    [ 1694]    '8'   
    'CloseEyesSound2'    [413146]    [414217]    [    0]    ''    
    'ListenSound'        [414217]    [414237]    [    0]    ''    
    'SADT1P1'            [414238]    [444042]    [32556]    '9'   [r]
    'OpenEyesSound2'     [444043]    [446125]    [    0]    ''    
    'MCImage'            [446133]    [446140]    [ 1642]    '9'   
    'MCImage'            [447793]    [447807]    [ 1431]    '3'   
    'MCImage'            [449250]    [449257]    [ 2846]    '8'   
    'MCImage'            [452112]    [452123]    [    0]    ''    
    'MCImage'            [455113]    [455123]    [ 1715]    '2'   
    'MCImage'            [456848]    [456856]    [ 1326]    '8'   
    'MCImage'            [458192]    [458206]    [ 1968]    '2'   
    'CloseEyesSound'     [461191]    [462267]    [    0]    ''    
    'CountSound'         [462267]    [463343]    [    0]    ''    
    'Rest'               [463344]    [463355]    [    0]    ''    
    'OpenEyesSound'      [463356]    [495439]    [    0]    ''    
    'MCImage'            [495448]    [495469]    [ 1392]    '8'   
    'MCImage'            [496871]    [496886]    [ 1871]    '8'   
    'MCImage'            [498767]    [498786]    [ 2355]    '6'   
    'MCImage'            [501150]    [501169]    [ 2116]    '6'   
    'MCImage'            [503298]    [503319]    [ 1630]    '7'   
    'MCImage'            [504960]    [504969]    [ 2037]    '6'   
    'MCImage'            [507015]    [507035]    [ 2169]    '7'   
    'CloseEyesSound1'    [510006]    [511084]    [    0]    ''    
    'RelaxSound'         [511085]    [512161]    [    0]    ''    
    'Relax'              [512161]    [512185]    [    0]    ''    
    'OpenEyesSound1'     [512185]    [544297]    [    0]    ''    
    'MCImage'            [544305]    [544315]    [ 1793]    '7'   
    'MCImage'            [546120]    [546132]    [  961]    '8'   
    'MCImage'            [547101]    [549110]    [ 2193]    '1'   
    'MCImage'            [549319]    [549331]    [ 1417]    '8'   
    'MCImage'            [550757]    [550765]    [ 1640]    '8'   
    'MCImage'            [552413]    [552431]    [ 1605]    '6'   
    'MCImage'            [554048]    [554064]    [ 1451]    '8'   
    'CloseEyesSound2'    [557039]    [558123]    [    0]    ''    
    'ListenSound'        [558123]    [558134]    [    0]    ''    
    'SADT1P2'            [558134]    [579751]    [    0]    ''    
    'OpenEyesSound2'     [579751]    [581843]    [    0]    ''    
    'MCImage'            [581852]    [581862]    [ 1053]    '8'   
    'MCImage'            [582928]    [582945]    [ 1570]    '3'   
    'MCImage'            [584525]    [584545]    [ 1714]    '8'   
    'MCImage'            [586270]    [586278]    [ 1741]    '7'   
    'MCImage'            [588030]    [588045]    [ 1423]    '2'   
    'MCImage'            [589479]    [589494]    [ 1605]    '8'   
    'MCImage'            [591108]    [591128]    [ 1380]    '2'   
    'MCImage1'           [594150]    [594161]    [ 4538]    '6'   
    'MCImage1'           [598708]    [598727]    [ 4731]    '2'   
    'MCImage1'           [603503]    [603510]    [ 4204]    '6'   
    'MCImage1'           [607752]    [607759]    [ 3523]    '6'   
    'MCImage1'           [611330]    [611343]    [ 4668]    '6'   
    'MCImage1'           [616171]    [616192]    [ 6066]    '8'   
    'CloseEyes'          [624011]    [625133]    [    0]    ''    
    'Rest1'              [625134]    [708977]    [83835]    's'  


Using OnsetTime:


dat_cell = 


    'Proc'               'Start'     'End'       'RT'       'Resp'
    'MCImage'            [ 49291]    [ 49293]    [ 2000]    '7'   
    'MCImage'            [ 51390]    [ 51392]    [ 2332]    '9'   
    'MCImage'            [ 53824]    [ 53826]    [ 1714]    '6'   
    'MCImage'            [ 55640]    [ 55642]    [ 1795]    '6'   
    'MCImage'            [ 57541]    [ 57543]    [ 1174]    '7'   
    'MCImage'            [ 58824]    [ 58826]    [ 2506]    '8'   
    'MCImage'            [ 61441]    [ 61443]    [ 1857]    '7'   
    'CloseEyesSound'     [ 64502]    [ 65585]    [    0]    ''    
    'CountSound'         [ 65586]    [ 66642]    [    0]    ''    
    'Rest'               [ 66656]    [ 66656]    [    0]    ''    
    'OpenEyesSound'      [ 96641]    [ 98739]    [    0]    ''    
    'MCImage'            [ 98770]    [ 98770]    [ 2247]    '7'   
    'MCImage'            [101036]    [101036]    [ 1901]    '8'   
    'MCImage'            [102969]    [102969]    [ 2296]    '8'   
    'MCImage'            [105286]    [105286]    [ 1178]    '7'   
    'MCImage'            [106486]    [106486]    [ 1163]    '7'   
    'MCImage'            [107669]    [107669]    [ 2459]    '7'   
    'MCImage'            [110152]    [110152]    [ 1504]    '7'   
    'CloseEyesSound1'    [113131]    [114189]    [    0]    ''    
    'WorrySound'         [114190]    [115246]    [    0]    ''    
    'Worry'              [115268]    [115268]    [    0]    ''    
    'OpenEyesSound1'     [145245]    [147343]    [    0]    ''    
    'MCImage'            [147365]    [147365]    [ 2379]    '8'   
    'MCImage'            [149765]    [149765]    [ 2043]    '8'   
    'MCImage'            [151832]    [151832]    [ 1919]    '9'   
    'MCImage'            [153781]    [153782]    [ 1570]    '7'   
    'MCImage'            [155381]    [155381]    [ 2226]    '7'   
    'MCImage'            [157631]    [157631]    [    0]    ''    
    'MCImage'            [160631]    [160631]    [   48]    '8'   
    'CloseEyesSound2'    [163610[s]]    [164674]    [    0]    ''    
    'ListenSound'        [164675]    [164675]    [    0]    ''    
    'SADT1P1'            [165680[t]]    [194499]    [32766]    '9'   
    'OpenEyesSound2'     [194500]    [196561]    [    0]    ''    
    'MCImage'            [196578]    [196578]    [ 1868]    '9'   
    'MCImage'            [198477]    [198478]    [ 1889]    '3'   
    'MCImage'            [200394]    [200394]    [ 2260]    '9'   
    'MCImage'            [202677]    [202677]    [ 1593]    '9'   
    'MCImage'            [204294]    [204294]    [ 2448]    '1'   
    'MCImage'            [206760]    [206760]    [ 2246]    '8'   
    'MCImage'            [209027]    [209027]    [ 1875]    '7'   
    'CloseEyesSound'     [212026]    [213099]    [    0]    ''    
    'CountSound'         [213109]    [214176]    [    0]    ''    
    'Rest'               [214193]    [214193]    [    0]    ''    
    'OpenEyesSound'      [244175]    [246273]    [    0]    ''    
    'MCImage'            [246290]    [246290]    [ 2443]    '7'   
    'MCImage'            [248756]    [248756]    [ 1313]    '9'   
    'MCImage'            [250090]    [250090]    [ 2195]    '2'   
    'MCImage'            [252306]    [252306]    [ 2019]    '7'   
    'MCImage'            [254356]    [254356]    [ 2145]    '8'   
    'MCImage'            [256522]    [256522]    [ 2099]    '6'   
    'MCImage'            [258639]    [258639]    [ 1630]    '8'   
    'CloseEyesSound1'    [261634]    [262709]    [    0]    ''    
    'WorrySound'         [262721]    [263775]    [    0]    ''    
    'Worry'              [263788]    [263788]    [    0]    ''    
    'OpenEyesSound1'     [293774]    [295873]    [    0]    ''    
    'MCImage'            [295902]    [295902]    [ 1158]    '8'   
    'MCImage'            [297085]    [297086]    [ 1767]    '7'   
    'MCImage'            [298869]    [298869]    [ 1839]    '9'   
    'MCImage'            [300735]    [300735]    [ 1389]    '6'   
    'MCImage'            [302152]    [302152]    [ 1492]    '1'   
    'MCImage'            [303668]    [303668]    [ 1640]    '8'   
    'MCImage'            [305335]    [305335]    [ 1965]    '7'   
    'CloseEyesSound2'    [308320]    [309384]    [    0]    ''    
    'ListenSound'        [309395]    [309395]    [    0]    ''    
    'SADT1P2'            [310384]    [330991]    [24068]    '9'   
    'OpenEyesSound2'     [331003]    [333074]    [    0]    ''    
    'MCImage'            [333099]    [333099]    [ 1353]    '9'   
    'MCImage'            [334482]    [334482]    [ 1953]    '3'   
    'MCImage'            [336465]    [336465]    [ 1691]    '9'   
    'MCImage'            [338182]    [338182]    [ 1885]    '8'   
    'MCImage'            [340098]    [340098]    [ 1529]    '3'   
    'MCImage'            [341648]    [341648]    [    0]    ''    
    'MCImage'            [344648]    [344648]    [   43]    '8'   
    'CloseEyesSound'     [347651]    [348718]    [    0]    ''    
    'CountSound'         [348729]    [349785]    [    0]    ''    
    'Rest'               [349797]    [349798]    [    0]    ''    
    'OpenEyesSound'      [379784]    [381881]    [    0]    ''    
    'MCImage'            [381895]    [381895]    [ 1260]    '8'   
    'MCImage'            [383178]    [383178]    [ 1872]    '8'   
    'MCImage'            [385078]    [385078]    [ 1420]    '6'   
    'MCImage'            [386528]    [386528]    [ 2202]    '7'   
    'MCImage'            [388761]    [388761]    [ 2129]    '7'   
    'MCImage'            [390911]    [390911]    [ 1779]    '8'   
    'MCImage'            [392710]    [392711]    [    0]    ''    
    'CloseEyesSound1'    [395705]    [396763]    [    0]    ''    
    'WorrySound'         [396773]    [397819]    [    0]    ''    
    'Worry'              [397843]    [397843]    [    0]    ''    
    'OpenEyesSound1'     [427818]    [429917]    [    0]    ''    
    'MCImage'            [429940]    [429941]    [ 1701]    '8'   
    'MCImage'            [431674]    [431674]    [ 1911]    '7'   
    'MCImage'            [433607]    [433607]    [ 1346]    '8'   
    'MCImage'            [434973]    [434974]    [ 2228]    '6'   
    'MCImage'            [437223]    [437223]    [ 2234]    '2'   
    'MCImage'            [439490]    [439490]    [ 1735]    '8'   
    'MCImage'            [441256]    [441256]    [ 2193]    '7'   
    'CloseEyesSound2'    [444238]    [445297]    [    0]    ''    
    'ListenSound'        [445307]    [445307]    [    0]    ''    
    'SADT2P1'            [446306]    [472948]    [    0]    ''    
    'OpenEyesSound2'     [472959]    [475030]    [    0]    ''    
    'MCImage'            [475053]    [475053]    [ 1515]    '8'   
    'MCImage'            [476586]    [476587]    [ 1638]    '1'   
    'MCImage'            [478253]    [478253]    [ 1971]    '8'   
    'MCImage'            [480253]    [480253]    [ 2691]    '1'   
    'MCImage'            [482969]    [482969]    [ 2423]    '1'   
    'MCImage'            [485419]    [485419]    [ 2141]    '7'   
    'MCImage'            [487585]    [487586]    [ 2383]    '2'   
    'CloseEyesSound'     [490580]    [491650]    [    0]    ''    
    'CountSound'         [491661]    [492717]    [    0]    ''    
    'Rest'               [492735]    [492735]    [    0]    ''    
    'OpenEyesSound'      [522716]    [524813]    [    0]    ''    
    'MCImage'            [524832]    [524832]    [ 1551]    '8'   
    'MCImage'            [526399]    [526399]    [ 1648]    '7'   
    'MCImage'            [528065]    [528065]    [ 2070]    '8'   
    'MCImage'            [530165]    [530165]    [ 2482]    '8'   
    'MCImage'            [532665]    [532665]    [ 1174]    '7'   
    'MCImage'            [533865]    [533865]    [ 2334]    '7'   
    'MCImage'            [536214]    [536215]    [ 2281]    '8'   
    'CloseEyesSound1'    [539210]    [540274]    [    0]    ''    
    'WorrySound'         [540284]    [541341]    [    0]    ''    
    'Worry'              [541364]    [541364]    [    0]    ''    
    'OpenEyesSound1'     [571340]    [573437]    [    0]    ''    
    'MCImage'            [573461]    [573461]    [ 2385]    '8'   
    'MCImage'            [575878]    [575878]    [ 1768]    '6'   
    'MCImage'            [577678]    [577678]    [ 2168]    '7'   
    'MCImage'            [579877]    [579877]    [ 1433]    '1'   
    'MCImage'            [581327]    [581327]    [ 1071]    '1'   
    'MCImage'            [582427]    [582427]    [ 2427]    '8'   
    'MCImage'            [584877]    [584877]    [ 1313]    '8'   
    'CloseEyesSound2'    [587868]    [588929]    [    0]    ''    
    'ListenSound'        [588940]    [588940]    [    0]    ''    
    'SADT2P2'            [589926]    [610648]    [25071]    '9'   
    'OpenEyesSound2'     [610660]    [612730]    [    0]    ''    
    'MCImage'            [612758]    [612758]    [ 2239]    '9'   
    'MCImage'            [615024]    [615024]    [ 1781]    '1'   
    'MCImage'            [616824]    [616824]    [ 1213]    '9'   
    'MCImage'            [618057]    [618057]    [ 2188]    '7'   
    'MCImage'            [620274]    [620274]    [ 1531]    '2'   
    'MCImage'            [621824]    [621824]    [ 2077]    '8'   
    'MCImage'            [623923]    [623924]    [    0]    ''    
    'MCImage1'           [626990]    [626990]    [  111]    '1'   
    'MCImage1'           [627140]    [627140]    [ 4081]    '2'   
    'MCImage1'           [631273]    [631273]    [ 4012]    '2'   
    'MCImage1'           [635322]    [635323]    [ 6179]    '6'   
    'MCImage1'           [641539]    [641539]    [ 5274]    '7'   
    'MCImage1'           [646871]    [646872]    [ 4646]    '6'   
    'CloseEyes'          [654821]    [655951]    [    0]    ''    
    'Rest1'              [655971]    [740491]    [84520]    's'   


[a]Lost Comments, forget numbering
[b]MC 1 also repeated? No. Only in beginning.
[c]Need this file?  Will get.
[d]Worry Silence, (Relax too)
[e]No MC4 or 7, if Neutral?  No.
[f]Skip this if neutral run
[g]Replaced WaitingForResponse, Assumed it was waiting for trigger
[h]Add to end time.
[i]2.146s
[j]OpenEyesSound includes time for both Rest and Instructions (~32s)
[k]Have to use .OnsetTime
[l]2.139s
[m]Same here
[n]1.283s
[o]Why shorter?
[p]Look Below at OnsetTime data set, SADT2P1 is delayed by one second.
[q]Not here. OpenEyesSound2 is ~2s and SADT2P1 is ~27s
[r]Ignore?
[s]3 second gap?
[t]Must subtract SADT1P1 Onset from Onset of CloseEyesSound2 to achieve 2s