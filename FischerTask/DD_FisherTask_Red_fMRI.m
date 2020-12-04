%%%% FISHER TASK EXPERIMENT %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Reference of the code:
%%%% Jardri, Duverne, Litvinova, Denève (2017): https://www.nature.com/articles/ncomms14218


%%%% The OutputMatrix for each subject is saved in the experiment's outputdata directory
%%%% (see at the bottom of the script)
%%%% the matrix includes:
%% column 1: block order
%% column 2: prior for left lake
%% column 3: prior for right lake
%% column 4: proportion of target fish in left lake
%% column 5: proportion of target fish in right lake
%% column 6: trial type

%%%%%% TRIAL TYPES 1-3 WERE DISCARDED FOR THE fMRI ADPATATION OF THE FISHER TASK

%%%%%% 1: S100 P50 = fish proportion is 100% in one of the lakes and prior non-informative
%%%%%% 2: S100 PCong = fish proportion is 100% in one of the lakes and prior congruent
%%%%%% 3: S100 PConf = fish proportion is 100% in one of the lakes and prior conflictual
%%%%%% 4: P50 = priors 50/50 in each lake
%%%%%% 5: S50 = fish proportions 50/50 in each lake
%%%%%% 6: S50 P50 = priors 50/50 and fish proportions 50/50 in each lake
%%%%%% 7: PS Congruent = matching high prior and high proportion od target fish in each lake (e.g., 70% and .90 in left lake)
%%%%%% 8: PS Conflictual = mismatching high prior and high proportion of target fish in each

%% column 7: time of trial begining
%% column 8: response time in sec
%% column 9: bottom press (1 for let-button mouse press)
%% column 10: confidence response - X coordinate
%% column 11: confidence response - Y coordinate


clear; clc;


% %*************************************************
% % CHARACTERISTICS OF SCREEN
% %*************************************************

info{1} = input('Subject number (3-digit number):', 's'); 
SubjectID = (['Subj' info{1}]);

currentDirectory = pwd;
ouputDirectory = ([currentDirectory filesep 'output_data' filesep]);



% %*************************************************
% % CHARACTERISTICS OF SCREEN
% %*************************************************

% Proportions (800x600);
P=0.5;

screens=Screen('Screens');
HideCursor;
screenNum=0;
[w,rect]=Screen('OpenWindow',screenNum);
white=WhiteIndex(w);
black=BlackIndex(w);
Screen('FillRect', w, white);   % initializes screen as full black
Screen('TextFont',w, 'Times New Roman');  % or Garamond
Screen('TextStyle', w, 0);      % style normal

Xletter=round (fix(rect(4)/2));
Yletter=round(fix(rect(4)/2)-90); % readjustement of letter position for scanner
newPosition=round([800 100]*P); % defines mouse cursor position

%=========Read images=======

addpath ([currentDirectory filesep 'Images']);

lake=imread('small_lake.jpg');

red=imread('red.jpg'); %read images of fishes in the lakes
bl=imread('black.jpg');

red1=imread('red1.jpg'); % read images of fishes in fishman's heands
bl1=imread('black1.jpg');

scale=imread('scale_round_sp.jpg'); % read image with confidence scale
hum=imread('hum.jpg'); %read image of fisherman

basket=imread('basket_w.jpg');


%=======================================Environment========================

%% FIXED TIME
priorsec=1;        %TIME OF DISPLAYING A PRIOR
ISI=0.05;          % time between Prior and Sensory input (50 msec)
ITI=0.8;           %time of fixation point displaying

%% OUTPUT MATRIX
%datatest_prior=[];

%% TRIAL MATRIX

% load ('TrialList'); File used for the Behavioral task (8 types of trials)
load('TrialList_fMRI'); % Reduces the nb of trials from 240 to 164

BlockOrder = randperm(8); % randomize order of blocks


%=======================================Environment========================


%% STARTING THE EXPERIMENT

%============================

Tstart=GetSecs;         % provides time in sec that computer started running

% % WARMING DISPLAY
wPRET = w;
Screen('TextSize',wPRET, 70);
DrawFormattedText(wPRET,'LISTO!','center', Yletter, [255 0 0]);
Screen('Flip',wPRET);
WaitSecs(3);
%
% Fixation point
wFixPt = w;
Screen('TextSize',wFixPt, 100*P);      % defines font size
DrawFormattedText(wFixPt,'+','center', Yletter, black);
Screen('Flip',wFixPt);
WaitSecs(1);



%% BLOCK LOOP

for block = 1:size(TrialList,2)

    %randomize order of trials within current block
    TrialOrder = randperm(20);

    %%TRIAL LOOP

    for trial=1:length(TrialList{BlockOrder(block)})

        wPtr = w;

        %PRIORS in each Lake

       [Posbasket_upcorner,Posbasket_downcorner] = posbasket(1100*P,700*P,2.5*TrialList{BlockOrder(block)}(TrialOrder(trial),1)*P*3,1.4);  
       Screen('PutImage', wPtr, basket, round([Posbasket_upcorner(1) Posbasket_upcorner(2) Posbasket_downcorner(1) Posbasket_downcorner(2)]*P));
       [Posbasket_upcorner,Posbasket_downcorner] = posbasket(2000*P,700*P,2.5*TrialList{BlockOrder(block)}(TrialOrder(trial),2)*P*3,1.4);  
       Screen('PutImage', wPtr, basket, round([Posbasket_upcorner(1) Posbasket_upcorner(2) Posbasket_downcorner(1) Posbasket_downcorner(2)]*P));
       
        t1=GetSecs;

        Screen('Flip',wPtr); 
        while GetSecs < t1 + priorsec %time of displaying environment with chances without fishes
        end
        
        Screen('Flip',w); 
        while GetSecs < t1 + priorsec + ISI
        end

        %Lakes
        Screen('PutImage', wPtr, lake, round([350 150 800 500]*P));
        Screen('PutImage', wPtr, lake, round([800 150 1250 500]*P));


        %Fishes Lake A
        proportion_fish=TrialList{BlockOrder(block)}(TrialOrder(trial),3);
        [colorfish,Posfish_upcorner,Posfish_downcorner] = plotlacs100a(550*P,330*P,300*P,proportion_fish,3);

        for k=1:100
            if colorfish(k)==0
                Screen('PutImage', wPtr, bl, [Posfish_upcorner(k,1) Posfish_upcorner(k,2) Posfish_downcorner(k,1) Posfish_downcorner(k,2)])
            elseif colorfish(k)==1
                Screen('PutImage', wPtr, red, [Posfish_upcorner(k,1) Posfish_upcorner(k,2) Posfish_downcorner(k,1) Posfish_downcorner(k,2)])
            end
        end

        %Fishes Lake B
        proportion_fish=TrialList{BlockOrder(block)}(TrialOrder(trial),4);
        [colorfish,Posfish_upcorner,Posfish_downcorner] = plotlacs100a(1000*P,330*P,300*P,proportion_fish,3);

        for k=1:100
            if colorfish(k)==0
                Screen('PutImage', wPtr, bl, [Posfish_upcorner(k,1) Posfish_upcorner(k,2) Posfish_downcorner(k,1) Posfish_downcorner(k,2)])
            elseif colorfish(k)==1
                Screen('PutImage', wPtr, red, [Posfish_upcorner(k,1) Posfish_upcorner(k,2) Posfish_downcorner(k,1) Posfish_downcorner(k,2)])
            end
        end


        set(0, 'PointerLocation', newPosition) %returns mouse position to newPosition
        ShowCursor('Arrow');

        %Confidence Scale
        Screen('PutImage', wPtr, scale, round([400 800 1200 1200]*P));

        %Fishman
        Screen('PutImage', wPtr, hum, round([685 480 895 780]*P));

        %fish in fisherman' hands - RED !!!!
        Screen('PutImage', wPtr, red1, round([715 632 865 692]*P));


        %setting other variables

        % COLLECTING BEHAVIORAL DATA..
        i=0;
        a=0; b=0; c=0;
        preRT=0;
        pretouche=-1;                    % -1 does not have a meaning on the keyboard map (if no key is pressed)
        x=0; y=0;

        % DISPLAYING IMAGE...
        Screen('Flip',wPtr);
        %KbWait        % waits for subject response

        %[a,b,c]=KbCheck                 % collects behavioral information from keyboard [button press, RT , pressed button]
        %[x,y]=GetMouse                  % collects mouse click coordinates
        %if  a==1                        % if a key was pressed while KbCheck is listening to the ADP port (which is handling the keybord)
        %    i=i+1;                      % increments the internal counter to avoid rewriting over the first value
        %    preRT(i)=b;                 % stores time information from KbCheck
        %    pretouche(i)=find(c==1,1);
        %else
        %end
        %
        [clicks,x,y,pretouche(1)] = GetClicks();V=GetSecs; RT=V-t1-priorsec;
        % reporting RT in output matrix
        %if preRT==0         % if no response
        %    RT=-1;
        %else
        %    RT=preRT(1)-t1-priorsec; % calculates response time
        %end


        %% REPORTING TRIAL CHARACTERISTICS AND BEHAVIORAL DATA

        if block == 1 && trial == 1
            OutputMatrix(1,1) = 1; % block order
            OutputMatrix(1,2:6) = TrialList{BlockOrder(block)}(TrialOrder(trial),1:5); % trial characterics
            OutputMatrix(1,7)=t1;
            OutputMatrix(1,8)=RT;                        % writes RT
            OutputMatrix(1,9)=pretouche(1);              % writes pressed button
            OutputMatrix(1,10)=x;                         % writes X mouse coordinate
            OutputMatrix(1,11)=y;                         % writes Y mouse coordinate
        else
            currentline = size(OutputMatrix,1)+1;
            OutputMatrix(currentline,1) = block; % block order
            OutputMatrix(currentline,2:6) = TrialList{BlockOrder(block)}(TrialOrder(trial),1:5); % trial characterics
            OutputMatrix(currentline,7)=t1;
            OutputMatrix(currentline,8)=RT;                        % writes RT
            OutputMatrix(currentline,9)=pretouche(1);              % writes pressed button
            OutputMatrix(currentline,10)=x;                         % writes X mouse coordinate
            OutputMatrix(currentline,11)=y;                         % writes Y mouse coordinate
        end



        % ITI: DISPLAYING FIXATION POINT...
        HideCursor;
        Screen('TextSize',wFixPt, 100*P);      % defines font size
        DrawFormattedText(wFixPt,'+','center', Yletter, [0 0 0]);
        t2=GetSecs;
        Screen('Flip',wFixPt);
        while GetSecs < t2 + ITI        % defines duration of fixation point displaying
        end
    end

    if block<8
        wBr = w;
        Screen('TextSize',wBr,round(40*P));      % defines font size
        DrawFormattedText(wBr,'PUEDES HACER UNA PAUSA AQUÍ!','center', Yletter, black);
        Screen('Flip',wBr);
        WaitSecs(5);

        Screen('TextSize',wBr,round(30*P));      % defines font size
        DrawFormattedText(wBr,'PRESIONA LA BARRA ESPACIO PARA CONTINUAR','center', Yletter, black);
        Screen('Flip',wBr);
        KbWait;
    end

    Screen('TextSize',wBr,round(100*P));      % defines font size
    DrawFormattedText(wBr,'+','center', Yletter, black);
    Screen('Flip',wBr);
    WaitSecs(1);


end

UpDisp=fix(rect(4)/2)-250;
LowDisp=fix(rect(4)/2)-100;

%FINAL DISPLAY
wBr = w;
Screen('TextSize',wBr,round(40*P));      % defines font size
DrawFormattedText(wBr,'BRAVO!','center', UpDisp, [255 0 0]);
DrawFormattedText(wBr,'SE TERMINÓ EL JUEGO. ¡GRACIAS POR TU PARTICIPACIÓN!','center', LowDisp, black);

Screen('Flip',wBr);
WaitSecs(4);

Screen('CloseAll');
ShowCursor('Arrow');

%% saving output file
save OutputMatrix.mat OutputMatrix;
movefile('OutputMatrix.mat',[ouputDirectory SubjectID '_OutputData.mat']);

clear all;



