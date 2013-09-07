%%%%%%%% v6_ssa_plot_PP1_TATproduction_export.m
%%%%%% Craig Johnston
%
 
function[] = v6_ssa_plot_PP1_TATproduction_export(l,T,PP1var)

%%%% The function, v6_ssa_plot_PP1_TATproduction_export, 
% plots the graph, T vs PP1var, in a colour depedning on the value
% of l. 
% l must be a multiple of 100 in the range [100,600] for plot
 
%%%% Inputs
% T and PP1var are column vectors of the same size
% l is a single value


%%%% Outputs
% plots T vs PP1var


 switch l

        case 100
            plot(T,PP1var,'LineWidth', 1.5,'Color', [0.827,0.125,0.157],'LineSmoothing','on');
        case 200
            plot(T,PP1var,'LineWidth', 1.5,'Color', [0.780,0.898,0.278],'LineSmoothing','on');
        case 300
            plot(T,PP1var,'LineWidth', 1.5,'Color', [0.502,0.404,0.867],'LineSmoothing','on');
        case 400
            plot(T,PP1var,'LineWidth', 1.5,'Color', [1.000,0.525,0.365],'LineSmoothing','on');
        case 500
            plot(T,PP1var,'LineWidth', 1.5,'Color', [0,0.329,0.651],'LineSmoothing','on');
        case 600
            plot(T,PP1var,'LineWidth', 1.5,'Color', [0.447,0.447,0.447],'LineSmoothing','on');
        otherwise
            warning('Unexpected plot type. No plot created.');
                                        
 end