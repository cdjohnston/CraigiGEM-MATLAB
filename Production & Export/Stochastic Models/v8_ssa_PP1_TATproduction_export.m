%%%%%%%% v8_ssa_PP1_TATproduction_export.m
%%%%%% Craig Johnston
%
%%%% The program, v8_ssa_PP1_TATproduction_export, calls the function, 
% ssa_PP1_TATproduction_export, to plot the Stochastic mean resulting from
% the selected number of realisations of the PP1cyto & PP1peri production 
% system
%
% The values of TatBC_number and TatAconstruct_number are looped 
% simultaneously over the ranges [15,45] and [30,90] respectively for the
% selected number of realisations.
% A selection of plots are output in the figures to visualise
% the effect on PP1 production and export of increasing the number of TatBC
%  and TatAconstructs at the same time .
%
% The program also uses the plot function v6_ssa_plot_PP1_TATproduction_export.

clear
close all


realisation_number = input('Enter the number of realisations ');


%%%%%%%%%%%%%%%%% Parameters & Initial Conditions %%%%%%%%%%%%%%%%%

nA = 6.023e23;                                % Avagadro's number
vol = 1e-15;                                  % E.coli volume
                    
% (cell division time, simulations)
% set up matrices to store results
PP1cyto=zeros(1200,realisation_number);       % (cell division time, number of realisations)
PP1peri=zeros(1200,realisation_number);
var_PP1cyto = zeros(571,1);
var_PP1peri = zeros(571,1);
number_cells = zeros(571,1);
mass_cells = zeros(571,1);

number_TatBC= 15:0.5:300;
number_TatBC=number_TatBC';                   % column vector of TatAconstruct numbers

number_TatAconstructs= 30:600;
number_TatAconstructs=number_TatAconstructs'; % column vector of TatAconstruct numbers


rand('state',100)


for k=30:600

            l=k;
            
            TatAconstruct_number = k;         % TatAconstruct is a construction of 20 TatA proteins
            TatAconstruct_conc = (TatAconstruct_number/nA) / vol; 
            
            m=l/2;
            
            TatBC_number = m;                 % TatBC is a complex of TatB and TatC proteins
            TatBC_conc = (TatBC_number/nA) / vol;

            for i=1:realisation_number
                
                        j=i;
                        [PP1cyto,PP1peri,T,tnew,ynew,znew] = ssa_PP1_TATproduction_export(TatAconstruct_conc,TatBC_conc,j,PP1cyto,PP1peri); 
            end

            % calculates Stochastic mean and stores the mean end value for each 
            % TatAconstruct_number TatBC_number configuration
            PP1cyto_Stochasticmean = mean(PP1cyto,2);
            var_PP1cyto(l-29,1) =  mean(PP1cyto(1200,:));

            PP1peri_Stochasticmean = mean(PP1peri,2);
            var_PP1peri(l-29,1) =  mean(PP1peri(1200,:));
            
            %%%%%%%%%% Plots %%%%%%%%%%
            
            % figure(1) - PP1cyto vs Time

            figure(1);
                    hold on
                    
                    if l==30;
                            plot(T,PP1cyto_Stochasticmean,'LineWidth', 1.5,'Color', [0.224,0.686,0.812],'LineSmoothing','on');
                    end
                    
                    if l==60;
                            plot(T,PP1cyto_Stochasticmean,'LineWidth', 1.5,'Color', [0.922,0.235,0.545],'LineSmoothing','on');
                    end
                    
                    remainder = rem(l,100);
                    
                    % plot result for each TatAconstruct_number multiple of 100
                   
                    if remainder==0 
                            v6_ssa_plot_PP1_TATproduction_export(l,T,PP1cyto_Stochasticmean)   
                    end         

                    xlabel('Time (s)','FontSize',14)
                    ylabel('Number of PP1 in Cytoplasm','FontSize',14)
                    set(gca,'FontWeight','Bold','FontSize',12)
                    axis([0 1200, 0 ,160])

            % figure(2) - PP1peri vs Time

            figure(2);
                    hold on
                    
                    if l==30;
                            plot(T,PP1peri_Stochasticmean,'LineWidth', 1.5,'Color', [0.224,0.686,0.812],'LineSmoothing','on');
                    end
                    
                    if l==60;
                            plot(T,PP1peri_Stochasticmean,'LineWidth', 1.5,'Color', [0.922,0.235,0.545],'LineSmoothing','on');
                    end
                    

                    if remainder==0 
                            v6_ssa_plot_PP1_TATproduction_export(l,T,PP1peri_Stochasticmean)   
                    end   

                    xlabel('Time (s)','FontSize',14)
                    ylabel('Number of PP1 in Periplasm','FontSize',14)
                    set(gca,'FontWeight','Bold','FontSize',12)
                    axis([0 1200, 0 ,350])


end

hleg = legend('15:30','30:60','50:100','100:200','150:300','200:400','250:500','300:600');
htitle = get(hleg,'Title');
set(htitle,'String','TatB-C Complexes:TatA Constructs','FontWeight','Bold','FontSize',12)


%%%%%%%%%% Plots %%%%%%%%%%

% figure(3) - TatBC vs PP1peri

figure(3);
        hold on
        
        plot(number_TatBC, var_PP1peri,'LineWidth', 1.5,'Color', [0,0.329,0.651],'LineSmoothing','on');

        xlabel('Number of TatB-C Complexes','FontSize',14)
        ylabel('Number of PP1 in Periplasm','FontSize',14)
        set(gca,'FontWeight','Bold','FontSize',12)
        grid on
        
        for p=1:30:571
                    plot(number_TatBC(p),var_PP1peri(p,1),'--rs','MarkerEdgeColor','k','MarkerFaceColor',[1.000,0.525,0.365],'MarkerSize',10)
        end
        
% figure(4) - TatBC vs Mass of Cells

figure(4);
        hold on
        
        for n=1:571
                number_cells(n,1) = 1.21E15/var_PP1peri(n,1);
                mass_cells(n,1) = number_cells(n,1)*9.5e-13;
        end

        plot(number_TatBC,mass_cells,'LineWidth', 1.5,'Color', [0,0.329,0.651],'LineSmoothing','on')

        xlabel('Number of TatB-C Complexes','FontSize',14)
        ylabel('Mass of Cells (g)','FontSize',14)
        set(gca,'FontWeight','Bold','FontSize',12)
        grid on
        
        for p=1:30:571
                    plot(number_TatBC(p),mass_cells(p,1),'--rs','MarkerEdgeColor','k','MarkerFaceColor',[1.000,0.525,0.365],'MarkerSize',10)
        end

