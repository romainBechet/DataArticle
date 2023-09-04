clear; 
%% 
% Program to run the stats of the article 
% INPUTS: DATA0D, discrete data from each participant 
% Stucuture: In DATA0D: 
    % Each condition (L for landing, DJ for drop-jumping, CMJ for countermovement jump)
        % AirTime: Time between takeoff and landing 
        % HipFlexionTiming, KneeFlexionTiming: Hip and Knee flexion onset (in ms, before ground contact) 
        % FootUpwardTiming: onset when the foot increases gravity (in ms, before ground contact)
        % HipAnkleMinus200, KneeAngleMinus200, AnkleAngleMinus200: Hip, Knee and Ankle angle 200 ms before ground contact (in °)
        % HipAngleGC, KneeAngleGC, AnkleAngleGC: Hip, Knee and Ankle angle at ground contact (in °)
        % FootVelocityGC, PelvisVelocityGC, COMvelocityGC : Vertical Velocity of the MidMeta, of the Pelvis and of the whole-body Centre of Mass at ground contact (in m.s^-1)
            % The Pelvis velocity is computed at its Centre of Mass.
            % Whole-Body Centre of Mass is computed using a 12 segments models, without hands) from Dumas et al., 2007, J Biomech. 
        % DistMidMetaGC: horizontal distance between the MidMeta and the whole-body Centre of mass (in m)
        % TimingTA, TimingSOL, TimingGM, TimingGL, TimingVM, TimingVL, TimingRF, TimingBF, TimingST: 
            % Timing of muscle activation of the Tibialis Anterior, the Soleus, the Gastrocnemii Medialis and Lateralis, 
            % the Vastii Medialis and Lateralis, the Rectus Femoris,the Biceps Femoris Long Head, and the Semi-Tendinosus (in ms before ground contact). 
            % The timing was computed using a double-threshold method (Hodges & Bui 1996, Clin. Neurophysiol. Mot. Control): To be considered active, the
            % muscle signal must be larger than a threshold during at least 50 ms. 

                % Each row represents an individual participant. 

%  OUTPUTS: tableStats: a table with one row per variable. For each variable: 
    % meanLanding, stdLanding, meanDJ, stdDJ, meanCMJ, stdCMJ: mean and standard deviation for Landing, Drop-jumping and Countermovement jump, respectively. 

    % pValue and F are the probability of the null hypothesis and the Chi-squared value from the Friedman test, respectively. 
    % postHocLvsDJ, postHocLvsCMJ and postHocDJvsCMJ: the probability of the null hypothesis for each post-hoc test 
    % (Landing vs. Drop-Jumping, Landing vs. Countermovement jump and Drop-Jumping vs. Countermovement jump), performed with Bonferroni correction. 
    % When the null hypothesis of the Friedman test was not rejected, all post-hoc tests were filled with '1'. 
   
alpha = 0.05; 
load("DATA0D.mat"); 

variables = fields(DATA0D.L); 
nbVariables = size(variables, 1); 

meanLanding = zeros(nbVariables, 1); 
stdLanding = zeros(nbVariables, 1);  
meanDJ = zeros(nbVariables, 1); 
stdDJ = zeros(nbVariables, 1); 
meanCMJ = zeros(nbVariables, 1);  
stdCMJ = zeros(nbVariables, 1); 
pValue = zeros(nbVariables, 1); 
F = zeros(nbVariables, 1); 
postHocLvsDJ = zeros(nbVariables, 1); 
postHocLvsCMJ = zeros(nbVariables, 1); 
postHocDJvsCMJ = zeros(nbVariables, 1); 

tableStats = table(variables, meanLanding, stdLanding, meanDJ, stdDJ, meanCMJ, stdCMJ, pValue, F, postHocLvsDJ, postHocLvsCMJ, postHocDJvsCMJ);

for v = 1 : nbVariables
    [p,tbl,stats] = friedman([DATA0D.L.(variables{v}), DATA0D.DJ.(variables{v}),DATA0D.CMJ.(variables{v})], 1, 'off'); % 'off' to not display graphics
    [c,~,~,~] = multcompare(stats, 'alpha', alpha,'ctype','bonferroni', 'display', 'off'); % 'display' 'off' to not display graphics 

    tableStats.meanLanding(v) = mean(DATA0D.L.(variables{v}));
    tableStats.stdLanding(v) = std(DATA0D.L.(variables{v}));
    tableStats.meanDJ(v) = mean(DATA0D.DJ.(variables{v}));
    tableStats.stdDJ(v) = std(DATA0D.DJ.(variables{v}));
    tableStats.meanCMJ(v) = mean(DATA0D.CMJ.(variables{v}));
    tableStats.stdCMJ(v) = std(DATA0D.CMJ.(variables{v}));

    tableStats.pValue(v) = p;
    tableStats.F(v) = tbl{2, 5}; 

    if p < alpha 
        tableStats.postHocLvsDJ(v) = c(1, end); 
        tableStats.postHocLvsCMJ(v) = c(2, end); 
        tableStats.postHocDJvsCMJ(v) = c(3, end); 
    else 
        tableStats.postHocLvsDJ(v) = 1; 
        tableStats.postHocLvsCMJ(v) = 1;  
        tableStats.postHocDJvsCMJ(v) = 1;  
    end

end
