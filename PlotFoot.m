clear; 
%% 
% Reproduce figure 4 from the article. 
% Inputs: 1 dimension data from each participant and each condition. 
% Structure: In DATA1D 
    % Each condition (L for landing, DJ for drop-jumping, CMJ for countermovement jump)
            % Time vector, from -200 to 100 (in ms). 

            % FootVerticalPosition, FootVerticalVelocity and FootVerticalAcceleration: linear position, velocity and acceleration from the midMeta point (in m, m.s^-1, m.s^-2) 
                % rows: individual participants 
                % columns: time 
    
            % DistMidMeta: Horizontal distance between the center of gravity and the MidMeta (in m)
                % rows: individual participants 
                % columns: time 

            % FootHorizontalVelocity and FootHorizontalAcceleration:
            % horizontal velocity and acceleration of the midMeta point (in m.s^-1 and m.s^-2)
                % rows: individual participants 
                % columns: time 

                
load("DATA1D.mat"); 

t = DATA1D.L.Time;  % Time vector 

colors = {'b', 'r', 'k'}; 
conditions = fields(DATA1D); 
vertical = {'FootVerticalPosition'; 'FootVerticalVelocity'; 'FootVerticalAcceleration'};
horizontal = {'DistMidMeta'; 'FootHorizontalVelocity'; 'FootHorizontalAcceleration'};

limitsVertical = [[0 0.25]; [-3 0];  [-50 200]]; 
limitsHorizontal = [[-0.05 0.15]; [-1 1.5]; [-100 100]]; 

letters = {'A'; 'B'; 'C'}; 
lettersH = {'D', 'E', 'F'}; 
% Specify the X-axis limits
limitsXAxis = [-50 30]; 

% Indices for begin and end computations
idxB = find(t == limitsXAxis(1)); 
idxE = find(t == limitsXAxis(2)); 
setXticks = limitsXAxis(1):20:limitsXAxis(2);  % Set the xTicks for each subplot

t = t(idxB:idxE); 
figure 
for j = 1 :3 % For each row of the graph 

    % Vertical part of the graph 
    subplot(3, 6, (j - 5) + 5 * j)
    hold on 
    for c = 1 : 3 % For each condition, we plot the average and standard deviation for the 20 subjects 
        meanCond = mean(DATA1D.(conditions{c}).(vertical{j})(:,idxB:idxE)); 
        stdCond = std(DATA1D.(conditions{c}).(vertical{j})(:,idxB:idxE)); 

        plot(t, meanCond, colors{c}, 'LineWidth', 2)  % Average 
        plot(t, meanCond + stdCond, colors{c}, 'LineStyle', ':') % Std
        plot(t, meanCond - stdCond, colors{c}, 'LineStyle', ':') % Std
    end 
    
    xline(0)  
    xticks(setXticks)
    xlim(limitsXAxis)
    ylim(limitsVertical(j, :))
    box off

    letter = text(-30, limitsVertical(j, 2) - 0.1 * (limitsVertical(j, 2) + abs(limitsVertical(j, 1))), letters{j});
    set(letter, 'FontSize', 25);

    if j == 1
        gcText = text(-5, 0.11, "Ground Contact");
        set(gcText,'Rotation',90, 'FontSize', 12);
        title("Vertical", 'FontSize', 14)
        ylabel("Position (m)", 'FontSize', 14)

    elseif j == 2 
        ylabel("Velocity (m.s^{-1})", 'FontSize', 14)

    elseif j == 3 
        ylabel("Acceleration (m.s^{-2})", 'FontSize', 14)
        xlabel("Time (ms)", 'FontSize', 14)
        yline(-9.81, '--k', 'LineWidth',2)
    end

    % Horizontal part of the graph  
    subplot(3, 6, (j - 4) + 5 * j)
    hold on 
     for c = 1 : 3  % Plot the average of three conditions first, to put the legend 
        meanCond = mean(DATA1D.(conditions{c}).(horizontal{j})(:,idxB:idxE)); 
        plot(t, meanCond, colors{c}, 'LineWidth', 2)  
     end 

     for c = 1 : 3  % Plot the standard deviations 
        meanCond = mean(DATA1D.(conditions{c}).(horizontal{j})(:,idxB:idxE)); 
        stdCond = std(DATA1D.(conditions{c}).(horizontal{j})(:,idxB:idxE)); 

        plot(t, meanCond + stdCond, colors{c}, 'LineStyle', ':')
        plot(t, meanCond - stdCond, colors{c}, 'LineStyle', ':')
     end 


     xline(0)
     xticks(setXticks)

     xlim(limitsXAxis)
     ylim(limitsHorizontal(j,:))
     box off

     letter = text(-30, limitsHorizontal(j, 2) - 0.1 * (limitsHorizontal(j, 2) + abs(limitsHorizontal(j, 1))), lettersH{j});
     set(letter, 'FontSize', 25);

     if j == 1 
        title("Horizontal", 'FontSize', 14)
     elseif j == 3 
         xlabel("Time (ms)", 'FontSize', 14)
         yline(0)
     end 

    
end 

lgd.Layout.Tile = 'south';
legend boxoff  
legend("Landing", "Drop-jumping", "CMJ", 'FontSize', 15, 'NumColumns', 3)