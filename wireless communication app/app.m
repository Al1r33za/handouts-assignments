function app

% ---------- GUI Setup ----------
fig = figure('Name','Path Loss Models Simulator',...
    'NumberTitle','off','Color',[0.95 0.95 0.95],...
    'Position',[300 150 950 580]);

% Model selector
uicontrol(fig,'Style','text','String','Path Loss Model:',...
    'Position',[40 520 110 20],'BackgroundColor',[0.95 0.95 0.95]);
modelMenu = uicontrol(fig,'Style','popupmenu',...
    'String',{'Free Space','Hata','COST231','Single-Slope','Multi-Slope','Okumura','Ten-Ray'},...
    'Position',[160 520 160 25]);

% Frequency input
uicontrol(fig,'Style','text','String','Frequency (MHz):',...
    'Position',[40 480 110 20],'BackgroundColor',[0.95 0.95 0.95]);
freqEdit = uicontrol(fig,'Style','edit','String','900',...
    'Position',[160 480 110 25]);

% Distance input
uicontrol(fig,'Style','text','String','Distance (km):',...
    'Position',[40 440 110 20],'BackgroundColor',[0.95 0.95 0.95]);
distEdit = uicontrol(fig,'Style','edit','String','10',...
    'Position',[160 440 110 25]);

% Heights
uicontrol(fig,'Style','text','String','Tx Height (m):',...
    'Position',[40 400 110 20],'BackgroundColor',[0.95 0.95 0.95]);
txEdit = uicontrol(fig,'Style','edit','String','30',...
    'Position',[160 400 110 25]);

uicontrol(fig,'Style','text','String','Rx Height (m):',...
    'Position',[40 360 110 20],'BackgroundColor',[0.95 0.95 0.95]);
rxEdit = uicontrol(fig,'Style','edit','String','1.5',...
    'Position',[160 360 110 25]);

% Shadowing and Hold checkboxes
shadowCheck = uicontrol(fig,'Style','checkbox','String','Shadowing (σ=4 dB)',...
    'Position',[40 310 160 25],'BackgroundColor',[0.95 0.95 0.95],'Value',0);
holdCheck = uicontrol(fig,'Style','checkbox','String','Hold on (overlay curves)',...
    'Position',[40 280 170 25],'BackgroundColor',[0.95 0.95 0.95],'Value',0);

% ---------- Buttons ----------
computeBtn = uicontrol(fig,'Style','pushbutton','String','Compute',...
    'FontWeight','bold','Position',[70 220 130 35],'Callback',@computeCallback);
exportBtn = uicontrol(fig,'Style','pushbutton','String','Export CSV',...
    'Position',[70 170 130 30],'Callback',@exportCallback);

% Result Label
resultLabel = uicontrol(fig,'Style','text','String','Result will appear here.',...
    'HorizontalAlignment','left','Position',[40 130 300 25],...
    'FontSize',10,'BackgroundColor',[0.95 0.95 0.95]);

% Plot Axes
ax = axes('Parent',fig,'Units','pixels','Position',[360 100 550 430]);
xlabel(ax,'Distance (km)'), ylabel(ax,'Path Loss (dB)');
grid(ax,'on'); title(ax,'Path Loss Model Plot');

% =====================================================================
% CALLBACKS
% =====================================================================
    function computeCallback(~,~)
        try
            freq = str2double(freqEdit.String);
            distMax = str2double(distEdit.String);
            hTx = str2double(txEdit.String);
            hRx = str2double(rxEdit.String);
            model = modelMenu.String{modelMenu.Value};

            % Distance vector
            dVec = linspace(0.1,distMax,200);
            PL = arrayfun(@(d)calcPathLoss(freq,d,hTx,hRx,model),dVec);

            % Apply shadowing
            if shadowCheck.Value
                sigma = 4;  % standard deviation (dB)
                PL = PL + sigma .* randn(size(PL));
            end

            % Convert to negative path loss convention
            PL = -abs(PL);

            % Hold On management
            if holdCheck.Value
                hold(ax,'on');
            else
                cla(ax);
                hold(ax,'off');
            end

            % Plot
            plot(ax,dVec,PL,'LineWidth',2);
            legend(ax,model,'Location','best');
            xlabel(ax,'Distance (km)'), ylabel(ax,'Path Loss (dB)');
            grid(ax,'on'); title(ax,'Path Loss Models');

            % Display last value
            resultLabel.String = sprintf('PL(%.2f km) = %.2f dB',distMax,PL(end));

        catch ME
            errordlg(['Error: ' ME.message],'Compute Error');
        end
    end

    function exportCallback(~,~)
        try
            freq = str2double(freqEdit.String);
            distMax = str2double(distEdit.String);
            hTx = str2double(txEdit.String);
            hRx = str2double(rxEdit.String);
            model = modelMenu.String{modelMenu.Value};
            dVec = linspace(0.1,distMax,200);
            PL = arrayfun(@(d)calcPathLoss(freq,d,hTx,hRx,model),dVec);

            if shadowCheck.Value
                sigma = 4; 
                PL = PL + sigma .* randn(size(PL));
            end

            PL = -abs(PL); % negative representation

            tbl = table(dVec',PL','VariableNames',{'Distance_km','PathLoss_dB'});
            [file,path] = uiputfile('PathLossResults.csv','Save Results As');
            if isequal(file,0)
                return;
            end
            writetable(tbl,fullfile(path,file));
            msgbox('Data exported successfully!','Export');
        catch ME
            errordlg(['Export failed: ' ME.message],'Export Error');
        end
    end
end


% =====================================================================
% INTERNAL: Path Loss Model Formulas
% =====================================================================
function PL = calcPathLoss(freq,dist,hTx,hRx,model)
    switch model
        case 'Free Space'
            PL = 32.44 + 20*log10(dist) + 20*log10(freq);

        case 'Hata'
            ahr = (1.1*log10(freq) - 0.7)*hRx - (1.56*log10(freq) - 0.8);
            PL = 69.55 + 26.16*log10(freq) - 13.82*log10(hTx) ...
                - ahr + (44.9 - 6.55*log10(hTx))*log10(dist);

        case 'COST231'
            ahr = (1.1*log10(freq) - 0.7)*hRx - (1.56*log10(freq) - 0.8);
            C = 3;
            PL = 46.3 + 33.9*log10(freq) - 13.82*log10(hTx) ...
                - ahr + (44.9 - 6.55*log10(hTx))*log10(dist) + C;

        case 'Single-Slope'
            d0 = 1; n = 3;
            PL0 = 32.44 + 20*log10(d0) + 20*log10(freq);
            PL = PL0 + 10*n*log10(dist/d0);

        case 'Multi-Slope'
            PL0 = 32.44 + 20*log10(1) + 20*log10(freq);
            n = 2; 
            if dist > 1, n = 3; end
            PL = PL0 + 10*n*log10(dist/1);

        case 'Okumura'
            A = 20*log10(freq) + 29;
            B = 21*log10(dist) + 14;
            C = -3*log10(hTx) - 4*log10(hRx);
            PL = A + B + C;

        case 'Ten-Ray'
            % Approximate Ten-Ray model:
            % Starts from FSPL and adds multipath interference factor.
            lambda = 3e8 / (freq*1e6); % wavelength (m)
            d_m = dist * 1000;         % convert km to m
            PL_fspl = 32.44 + 20*log10(dist) + 20*log10(freq);
            % Ten-ray interference approximation:
            phase_rand = 2*pi*rand(1,10);
            ray_sum = sum(cos(phase_rand)); % coherent power variation
            multipath_factor = 10*log10(abs(ray_sum/10) + 1); % mild ripple
            PL = PL_fspl + multipath_factor;

        otherwise
            PL = NaN;
    end
end
