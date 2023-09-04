clear;
%% 
% Reproduce figure 3 from the article. 
% Inputs: DATA1D: 1 dimension data from each participant and each condition. 
% Structure: In DATA1D 
    % Each condition (L for landing, DJ for drop-jumping, CMJ for countermovement jump)
        % Hip, Knee, Ankle: Joint angle for all participants (in deg)
            % rows:  individual participants 
            % columns: time

        % HipVelocity, KneeVelocity, AnkleVelocity: Joint angular velocities (in deg.sec^-1)
        % for all participants 
            % rows: individual participants 
            % columns: time 

        % Time: time vector from -200 to 100 (in ms) 

        
load("DATA1D.mat");

t = DATA1D.L.Time; % Time Vector 

colors = {'b', 'r', 'k'};
conditions = fields(DATA1D);
joints = {'Hip'; 'Knee'; 'Ankle'};

limitsAngles = [[0 100]; [0 100];  [-50 50]]; % Y limits for each joint angle 
limitsVelocity = [-500 1500]; % Y limits for all three joint velocities 

letters = {'A'; 'B'; 'C'};

figure
for j = 1 :3
    % Joint angle part of the graph (left part) 
    subplot(3, 6, (j - 5) + 5 * j)
    hold on
    for c = 1 : 3 % Plot the average of each condition 
        meanCond = mean(DATA1D.(conditions{c}).(joints{j}));
        plot(t, meanCond, colors{c}, 'LineWidth', 2)
    end

    for c = 1 : 3 % Plot the standard deviation for each condition 
        meanCond = mean(DATA1D.(conditions{c}).(joints{j}));
        stdCond = std(DATA1D.(conditions{c}).(joints{j}));

        plot(t, meanCond + stdCond, colors{c}, 'LineStyle', ':')
        plot(t, meanCond - stdCond, colors{c}, 'LineStyle', ':')
    end

    xline(0)
    ylim(limitsAngles(j, :))
    box off

    set(gca,'Clipping','Off')
    letter = text(-275, limitsAngles(j, 2) - 0.1 * (limitsAngles(j, 2) + abs(limitsAngles(j, 1))), letters{j});
    set(letter, 'FontSize', 25);

    if j == 1
        gcText = text(-15, 45, "Ground Contact");
        set(gcText,'Rotation',90, 'FontSize', 12);
        title("Angle (°)", 'FontSize', 14)

    end


    if j == 3
        ylabel([joints{j} 'Dorsiflexion'])
        xlabel("Time (ms)", 'FontSize', 14)
    else
        ylabel([joints{j} 'Flexion'])
    end

    % Joint Velocity part of the graph (right part) 
    subplot(3, 6, (j - 4) + 5 * j)
    hold on
    for c = 1 : 3 % Plot the average of each condition first, to put the legend
        variableName = [joints{j} 'Velocity'];
        meanCond = mean(DATA1D.(conditions{c}).(variableName));

        plot(t, meanCond, colors{c}, 'LineWidth', 2)
    end
    
    for c = 1 : 3 % Plot the standard deviation of each condition 
        variableName = [joints{j} 'Velocity'];
        meanCond = mean(DATA1D.(conditions{c}).(variableName));
        stdCond = std(DATA1D.(conditions{c}).(variableName));

        plot(t, meanCond + stdCond, colors{c}, 'LineStyle', ':')
        plot(t, meanCond - stdCond, colors{c}, 'LineStyle', ':')

    end

    xline(0)
    yline(0)
    ylim(limitsVelocity)
    box off 

    if j == 1
        title("Angular Velocity (°.s^{-1})", 'FontSize', 14)
    elseif j == 3
        xlabel("Time (ms)", 'FontSize', 14)
    end
end

lgd.Layout.Tile = 'south';
legend boxoff  
legend("Landing", "Drop-jumping", "CMJ", 'FontSize', 15, 'NumColumns', 3)