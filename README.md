This folder contains data and scripts used to compute the results of 'Strong evidence of invariant kinematics anticipation to cope with gravity and balance across landing tasks'. 

DATA: 
DATA0D.mat: Discrete values used in the results section. 
DATA1D.mat: Continous data used in the results section (from -200 to 100 ms relative to ground contact time). 


Scripts: 
Stats.m: Compute statistical analyses used in the results section, using the data from DATA0D.mat. 
Display the mean and standard deviation of each variable for each condition; the p value and the Chi-squared value for each Friedman test; and the p values of the post-hoc tests when necessary. 

PlotEMG.m: Reproduce the Figure 2 from the article, using the data from DATA1D.mat. 

PlotAngles.m: Reproduce the Figure 3 from the article, using the data from DATA1D.mat. 

PlotFoot.m Reproduce the Figure 4 from the article, using the data from DATA1D.mat.


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


% Structure: In DATA1D: 
	% Each condition (L for landing, DJ for drop-jumping, CMJ for countermovement jump)
            	
        	% Time: time vector from -200 to 100 (in ms) 

		% Hip, Knee, Ankle: Joint angle for all participants (in °)
            		% rows:  individual participants 
           		% columns: time

        	% HipVelocity, KneeVelocity, AnkleVelocity: Joint angular velocities for all participants (in deg.sec^-1)
            		% rows: individual participants 
           		% columns: time 

		% FootVerticalPosition, FootVerticalVelocity and FootVerticalAcceleration: linear position, velocity and acceleration from the midMeta point (in m, m.s^-1, m.s^-2) 
                	% rows: individual participants 
                	% columns: time 
    
            	% DistMidMeta: Horizontal distance between the center of gravity and the MidMeta (in m)
                	% rows: individual participants 
                	% columns: time 

            	% FootHorizontalVelocity and FootHorizontalAcceleration: horizontal velocity and acceleration of the midMeta point (in m.s^-1 and m.s^-2)
                	% rows: individual participants 
                	% columns: time 

		%  EMGs: EMG signals for each muscle
			% TA, SOL, GM, VM, VL, RF, BF, ST: Temporal evolution of Tibialis Anterior,  Soleus,  Gastrocnemii Medialis and Lateralis, 
            		% Vastii Medialis and Lateralis, Rectus Femoris, Biceps Femoris Long Head, and Semi-Tendinosus 
			% (in %  of the maximum amplitude recorded during the protocol). 
				% rows: individual participants 
                		% columns: time 
