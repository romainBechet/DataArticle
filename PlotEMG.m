clear; 
%%
% Reproduce figure 2 from the article. 
% Inputs: DATA1D: 1 dimension data from each participant and each condition. 
% Structure: In DATA1D 
    % Each condition (L for landing, DJ for drop-jumping, CMJ for countermovement jump)
        % EMGs: structure containing all EMG data 
            % TA, SOL, GM, VM, VL, RF, BF, ST: Temporal evolution of Tibialis Anterior,  Soleus,  Gastrocnemii Medialis and Lateralis, 
            %  Vastii Medialis and Lateralis, Rectus Femoris, Biceps Femoris Long Head, and Semi-Tendinosus (in %  of the maximum amplitude recorded during the protocol). 
                % rows:  individual participants 
                % columns: time
                
    % Time: time vector from -200 to 100 (in ms) 

load("DATA1D.mat"); 

t = DATA1D.L.Time; 

EMGs = fields(DATA1D.L.EMGs); 
nbEMGs = size(EMGs, 1); 
colors = {'b', 'r', 'k'}; 
conditions = fields(DATA1D); 

figure 
for n = 1 : nbEMGs

    subplot(9, 3, (n - 2) + 2 * n)
    hold on
    
    for c = 1 : 3
        plot(t, mean(DATA1D.(conditions{c}).EMGs.(EMGs{n})), colors{c}, 'LineWidth', 2)
    end 

    ylim([0 50])
    yticks([0 50])
    box off
    
    ylabel(EMGs{n}, 'FontSize', 15)

    if n == 1 
        xticklabels([])
        title("EMG envelops (%)", 'FontSize', 14)
    elseif n == nbEMGs
        xlabel("Time (ms)", 'FontSize', 15)     
    elseif n == 2
        gcText = text(-7, 25, "Ground Contact");
        set(gcText,'Rotation',90, 'FontSize', 9);
        xticklabels([])
    else 
        xticklabels([])
    end 
end 

set(gca,'Clipping','Off')
h = line([0 0],[0 610]);
set(h, 'color', 'k')
lgd.Layout.Tile = 'south';
legend boxoff  
legend("Landing", "Drop-jumping", "CMJ", 'FontSize', 15, 'NumColumns', 3)
