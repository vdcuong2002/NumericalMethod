classdef NumMethod_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        NumericalMethodUIFigure  matlab.ui.Figure
        veButton                 matlab.ui.control.Button
        NhphmfxLabel             matlab.ui.control.Label
        nhapinput                matlab.ui.control.EditField
        pptinh                   matlab.ui.container.ButtonGroup
        chiadoi                  matlab.ui.control.RadioButton
        daycung                  matlab.ui.control.RadioButton
        tieptuyen                matlab.ui.control.RadioButton
        lapdon                   matlab.ui.control.RadioButton
        diembatdau               matlab.ui.control.EditField
        tinhtheo                 matlab.ui.container.ButtonGroup
        saiso                    matlab.ui.control.RadioButton
        vonglap                  matlab.ui.control.RadioButton
        boxSS                    matlab.ui.container.ButtonGroup
        hmt                      matlab.ui.control.RadioButton
        gtlt                     matlab.ui.control.RadioButton
        xxbd                     matlab.ui.control.RadioButton
        tinhtoan                 matlab.ui.control.Button
        NghimxpxxEditFieldLabel  matlab.ui.control.Label
        x_output                 matlab.ui.control.NumericEditField
        SaisdxLabel              matlab.ui.control.Label
        dx_output                matlab.ui.control.NumericEditField
        VnglpkLabel              matlab.ui.control.Label
        k_output                 matlab.ui.control.NumericEditField
        xn1EditFieldLabel        matlab.ui.control.Label
        xnt1_output              matlab.ui.control.NumericEditField
        x0EditFieldLabel         matlab.ui.control.Label
        x0_output                matlab.ui.control.NumericEditField
        x1dEditFieldLabel        matlab.ui.control.Label
        x1_output                matlab.ui.control.NumericEditField
        UIAxes                   matlab.ui.control.UIAxes
        dxkLabel                 matlab.ui.control.Label
        dxk                      matlab.ui.control.EditField
        minEditField_2Label      matlab.ui.control.Label
        duoi                     matlab.ui.control.EditField
        maxEditField_2Label      matlab.ui.control.Label
        tren                     matlab.ui.control.EditField
        nhapkhoang               matlab.ui.control.EditField
        nhapkhoang_2             matlab.ui.control.EditField
        pptlable                 matlab.ui.control.Label
        update                   matlab.ui.control.Button
        slogan                   matlab.ui.control.Label
        gopy                     matlab.ui.control.Button
        HngdnsdngButton          matlab.ui.control.Button
        VDC                      matlab.ui.control.Label
        dfxdxButton              matlab.ui.control.Button
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: tinhtoan
        function ok_button(app, event)
            format long;
            y = str2sym(app.nhapinput.Value);
            mychoice_1 = app.chiadoi.Value + 2*app.daycung.Value + 3 * app.tieptuyen.Value + 4 * app.lapdon.Value;
            mychoice_2 = app.saiso.Value +  2 * app.vonglap.Value;
            mychoice_3 = app.hmt.Value + 2*app.gtlt.Value + 3 * app.xxbd.Value;
            b1y = diff(y);
            b2y = diff(b1y);
            k = str2num(app.dxk.Value);
            Range = [str2num(app.duoi.Value) str2num(app.tren.Value)];
            
            
            
%/////////////////////////////////////////////////////////////
if (mychoice_1 == 1)
    if (mychoice_2 == 1)
    a = subs(y, Range(1));
    app.x0_output.Value = Range(1);
    b = subs(y, Range(2));
    app.x1_output.Value = Range(2);
    c = subs(y, (Range(1) + Range(2)) / 2);
    n = 0;
    while abs(Range(1) - Range(2)) > k
        if a == 0
            app.x_output.Value = Range(1);
            break;
        end
        if b == 0
            set(app.x_output, 'String', Range(2));
            break;
        end
        if a*c < 0
            Range(2) = (Range(1) + Range(2)) / 2;
        else
            Range(1) = (Range(1) + Range(2)) / 2;
        end
        a = subs(y, Range(1));
        b = subs(y, Range(2));
        c = subs(y, (Range(1) + Range(2)) / 2);
        n = n+ 1;
        if (n > 10000)
            break;
        end
    end
    if a ~= 0 & b~=0
        app.k_output.Value = n;
        app.dx_output.Value = abs(Range(1) - Range(2));
        app.x_output.Value = Range(1);
        app.xnt1_output.Value = Range(2);
    end
    end
 %-----------------------------   
    if (mychoice_2 == 2)
        a = subs(y, Range(1));
        app.x0_output.Value = Range(1);
        b = subs(y, Range(2));
        app.x1_output.Value = Range(2);
        c = subs(y, (Range(1) + Range(2)) / 2);
        for i = 1:1:k
            a = subs(y, Range(1));
            b = subs(y, Range(2));
            c = subs(y, (Range(1) + Range(2)) / 2);
            if a == 0
                app.x_output.Value = Range(1);
                break;
            end
            if b == 0
                set(app.x_output, 'String', Range(2));
                break;
            end
            if a*c < 0
                Range(2) = (Range(1) + Range(2)) / 2;
            else
                Range(1) = (Range(1) + Range(2)) / 2;
            end
        end
    if (a ~= 0 & b~=0)
        app.k_output.Value = k;
        app.dx_output.Value = abs(Range(1) - Range(2));
        app.x_output.Value = Range(1);
        app.xnt1_output.Value = Range(2);
    end 
    end
end  

%/////////////////////////////////////////////////////////////
%------------------------------------------------------------------
% pp day cung

            % theo sai so
if (mychoice_1 == 2 & mychoice_2 == 1) 
    %sai so ham muc tie
    
    d = Range(2);
    x0 = Range(1);
    if (subs(y, Range(1)) * subs(b2y, Range(1)) > 0)
        d = Range(1);
        x0 = Range(2);
    end
    app.x0_output.Value = x0;
    
    m = min(abs(subs(b1y, d)),  abs(subs(b1y, x0) ) );
    M = max(abs(subs(b1y, d)),  abs(subs(b1y, x0) ) );
    sd = subs(y, d);
    pre_x = double(x0);
    now_x = pre_x - (subs(y, pre_x)*(pre_x - d))/(subs(y, pre_x) - sd);
    now_x = double(now_x);
    app.x1_output.Value = now_x;
    count = 1;
    %saiso = 1;
    if (mychoice_3 == 1)
        saiso = double(abs(subs(y, now_x)/m)); % danh gia sai so theo ham muc tieu
    end
    if (mychoice_3 == 2)
        saiso = double(abs(now_x - pre_x) * (M - m) /m);
    end
    
    while (abs(saiso) > k)
        temp = now_x;
        now_x = now_x - (subs(y, now_x)*(now_x - d))/(subs(y, now_x) - sd);
        pre_x = temp;
        count  = count + 1;
        if (mychoice_3 == 1)
            saiso = double(abs(subs(y, now_x)/m)); % danh gia sai so theo ham muc tieu
        end
        if (mychoice_3 == 2)
            saiso = double(abs(now_x - pre_x) * (M - m) /m);
        end
        
    end
        now_x = double(now_x);
        pre_x = double(pre_x);
        app.k_output.Value = count;
        app.dx_output.Value = saiso;
        app.x_output.Value = now_x;
        app.xnt1_output.Value = pre_x;
end


% vong lap
if (mychoice_1 == 2 & mychoice_2 == 2)
    %sai so ham muc tieu
    d = Range(2);
    x0 = Range(1);
    if (subs(y, Range(1)) * subs(b2y, Range(1)) > 0)
        d = Range(1);
        x0 = Range(2);
    end
    app.x0_output.Value = x0;
    
    m = min(abs(subs(b1y, d)),  abs(subs(b1y, x0) ) );
    M = max(abs(subs(b1y, d)),  abs(subs(b1y, x0) ) );
    sd = subs(y, d);
    pre_x = double(x0);
    now_x = pre_x - (subs(y, pre_x)*(pre_x - d))/(subs(y, pre_x) - sd);
    now_x = double(now_x);
    app.x1_output.Value = now_x;
    if (mychoice_3 == 1)
        saiso = double(abs(subs(y, now_x)/m)); % danh gia sai so theo ham muc tieu
    end
    if (mychoice_3 == 2)
        saiso = double(abs(now_x - pre_x) * (M - m) /m);
    end
    
    for i = 1:1:(k-1)
        temp = now_x;
        now_x = now_x - (subs(y, now_x)*(now_x - d))/(subs(y, now_x) - sd);
        pre_x = temp;
        if (mychoice_3 == 1)
            saiso = double(abs(subs(y, now_x)/m)); % danh gia sai so theo ham muc tieu
        end
        if (mychoice_3 == 2)
            saiso = double(abs(now_x - pre_x) * (M - m) /m);
        end
        
    end
    now_x = double(now_x);
        pre_x = double(pre_x);
        app.k_output.Value = k;
        app.dx_output.Value = saiso;
        app.x_output.Value = now_x;
        app.xnt1_output.Value = pre_x;

end


% pp tiep tuyen
% theo sai so
if (mychoice_1 == 3 & mychoice_2 == 1)

    d = Range(2);
    x0 = Range(1);
    if (subs(y, Range(1)) * subs(b2y, Range(1)) < 0)
        d = Range(1);
        x0 = Range(2);
    end
    app.x0_output.Value = x0;
    
    m = min(abs(subs(b1y, d)),  abs(subs(b1y, x0) ) );
    M = max(abs(subs(b1y, d)),  abs(subs(b1y, x0) ) );
    pre_x = double(x0);
    now_x = pre_x - (subs(y, pre_x))/(subs(b1y, pre_x));
    now_x = double(now_x);
     app.x1_output.Value = now_x;
    count = 1;
    %saiso = 1;
    if (mychoice_3 == 1)
        saiso = double(abs(subs(y, now_x)/m)); % danh gia sai so theo ham muc tieu
    end
    if (mychoice_3 == 2)
        saiso = double((now_x - pre_x)^2 * M / (2 * m));
    end
    
    while (abs(saiso) > k)
        temp = now_x;
        now_x = now_x - (subs(y, now_x))/(subs(b1y, now_x));
        pre_x = temp;
        count  = count + 1;
        if (mychoice_3 == 1)
            saiso = double(abs(subs(y, now_x)/m)); % danh gia sai so theo ham muc tieu
        end
        if (mychoice_3 == 2)
            saiso = double((now_x - pre_x)^2 * M / (2 * m));
        end
        
    end
    now_x = double(now_x);
        pre_x = double(pre_x);
        app.k_output.Value = count;
        app.dx_output.Value = saiso;
        app.x_output.Value = now_x;
        app.xnt1_output.Value = pre_x;
end

% vong lap
if (mychoice_1 == 3 & mychoice_2 == 2 )
    d = Range(2);
    x0 = Range(1);
    if (subs(y, Range(1)) * subs(b2y, Range(1)) < 0)
        d = Range(1);
        x0 = Range(2);
    end
    app.x0_output.Value = x0;
    
    m = min(abs(subs(b1y, d)),  abs(subs(b1y, x0) ) );
    M = max(abs(subs(b2y, d)),  abs(subs(b2y, x0) ) );
    pre_x = double(x0);
    now_x = pre_x - (subs(y, pre_x))/(subs(b1y, pre_x));
    now_x = double(now_x);
    app.x1_output.Value = now_x;
    if (mychoice_3 == 1)
        saiso = double(abs(subs(y, now_x)/m)); % danh gia sai so theo ham muc tieu
    end
    if (mychoice_3 == 2)
        saiso = double((now_x - pre_x)^2 * M / (2 * m));
    end
    for i = 1:1:(k-1)
        temp = now_x;
        now_x = now_x - (subs(y, now_x))/(subs(b1y, now_x));
        pre_x = temp;
        if (mychoice_3 == 1)
        saiso = double(abs(subs(y, now_x)/m)); % danh gia sai so theo ham muc tieu
    end
    if (mychoice_3 == 2)
        saiso = double((now_x - pre_x)^2 * M / (2 * m));
    end
        
    end
    saiso = double(saiso);
    now_x = double(now_x);
        pre_x = double(pre_x);
        app.k_output.Value = k;
        app.dx_output.Value = saiso;
        app.x_output.Value = now_x;
        app.xnt1_output.Value = pre_x;
end
            
% Phÿÿng pháp Lÿp ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if (mychoice_1 == 4)
    start = app.diembatdau.Value;
        q = max(abs(subs(b1y, Range(1))), abs(subs(b1y, Range(2))));
        if (q < 1)
            if (mychoice_2 == 1)
                pre_x = start;
                now_x = subs(y, pre_x);
                deltadau = now_x - pre_x;
                saiso = 0;
                dem = 1;
                if (mychoice_3 == 3)
                    saiso = (q^dem)*abs(deltadau) / (1-q);
                end
                if (mychoice_3 == 2)
                    saiso = (q)*abs(now_x - pre_x) / (1-q);
                end
                
                while (saiso > k)
                    pre_x = now_x;
                    now_x = subs(y, pre_x);
                    dem = dem + 1;
                    if (mychoice_3 == 3)
                        saiso = (q^dem)*abs(deltadau) / (1-q);
                    end
                    if (mychoice_3 == 2)
                        saiso = (q)*abs(now_x - pre_x) / (1-q);
                    end
                    saiso = double(saiso);
                now_x = double(now_x);
                pre_x = double(pre_x);
                app.k_output.Value = dem;
                app.dx_output.Value = saiso;
                app.x_output.Value = now_x;
                app.xnt1_output.Value = pre_x;
                end
            end
            
            if (mychoice_2 == 2)
                pre_x = start;
                now_x = subs(y, pre_x);
                deltadau = now_x - pre_x;
                saiso  = 0;
                dem = 1;
                if (mychoice_3 == 3)
                    saiso = (q^dem)*abs(deltadau) / (1-q);
                end
                if (mychoice_3 == 2)
                    saiso = (q)*abs(now_x - pre_x) / (1-q);
                end
                
                for i = 1:1:(k-1)
                    pre_x = now_x;
                    now_x = subs(y, pre_x);
                    dem = dem + 1;
                    if (mychoice_3 == 3)
                        saiso = (q^dem)*abs(deltadau) / (1-q);
                    end
                    if (mychoice_3 == 2)
                        saiso = (q)*abs(now_x - pre_x) / (1-q);
                    end
                end
                
                saiso = double(saiso);
                now_x = double(now_x);
                pre_x = double(pre_x);
                app.k_output.Value = dem;
                app.dx_output.Value = saiso;
                app.x_output.Value = now_x;
                app.xnt1_output.Value = pre_x;
            end
        end
end
        end

        % Button pushed function: veButton
        function vedothi(app, event)
            y = str2sym(app.nhapinput.Value);
            a = (app.nhapkhoang.Value);
            if(isempty(a))
                x = -5:0.1:5;
                y = subs(y, x);
                plot(app.UIAxes ,x, y);
                grid(app.UIAxes, "on");
                title(app.UIAxes, app.nhapinput.Value)
            else
                m = str2num(a);
                M = str2num(app.nhapkhoang_2.Value);
                x = m:0.1:M;
                y = subs(y, x);
                plot(app.UIAxes ,x, y);
                grid(app.UIAxes, "on");
                title(app.UIAxes, app.nhapinput.Value)
            end

        end

        % Button pushed function: update
        function updatePushed(app, event)
            web('https://husteduvn-my.sharepoint.com/:f:/g/personal/cuong_vd202313_sis_hust_edu_vn/EoNr_cg0_A1MhvLLS55DYksBbAzSMDB9d-DXjBpZifz1Vw?e=BR4w7e', '-browser')
        end

        % Button pushed function: gopy
        function gopyPushed(app, event)
            web('https://www.facebook.com/vu.cuong.dz2808/', '-browser')
        end

        % Callback function
        function DonateButtonPushed(app, event)
            web('https://husteduvn-my.sharepoint.com/:t:/g/personal/cuong_vd202313_sis_hust_edu_vn/Eeq3a0ufZ_FOjilJLDAMEuwBtS2jF_OZxe_0VVFQlc4M-w?e=YG3oFe', '-browser')
        end

        % Button down function: NumericalMethodUIFigure
        function NumericalMethodUIFigureButtonDown(app, event)
            
        end

        % Key press function: NumericalMethodUIFigure
        function NumericalMethodUIFigureKeyPress(app, event)
            key = event.Key;
            if (strcmp(key, 'return'))
                ok_button(app, event);
            end
            
        end

        % Value changed function: diembatdau
        function diembatdauValueChanged(app, event)
            value = app.diembatdau.Value;
            
        end

        % Value changing function: diembatdau
        function diembatdauValueChanging(app, event)
        
        end

        % Selection changed function: pptinh
        function pptinhSelectionChanged(app, event)
            mychoice_1 = app.chiadoi.Value + 2*app.daycung.Value + 3 * app.tieptuyen.Value + 4 * app.lapdon.Value;
            if (mychoice_1 == 1)
                app.diembatdau.Enable = 'off';
                app.hmt.Enable = 'off';
                app.gtlt.Enable = 'off';
                app.xxbd.Enable = 'off';
            end
            
            if (mychoice_1 == 2)
                app.diembatdau.Enable = 'off';
                app.hmt.Enable = 'on';
                app.gtlt.Enable = 'on';
                app.xxbd.Enable = 'off';
            end
            
            if (mychoice_1 == 3)
                app.diembatdau.Enable = 'off';
                app.hmt.Enable = 'on';
                app.gtlt.Enable = 'on';
                app.xxbd.Enable = 'off';
            end
            
            if (mychoice_1 == 4)
                app.diembatdau.Enable = 'on';
                app.hmt.Enable = 'off';
                app.gtlt.Enable = 'on';
                app.xxbd.Enable = 'on';
                
            end
            
        end

        % Callback function
        function maxEditField_2ValueChanging(app, event)
          
            
        end

        % Callback function
        function maxEditField_2ValueChanged(app, event)
            
            
        end

        % Button pushed function: dfxdxButton
        function dfxdxButtonPushed(app, event)
            y = diff(str2sym(app.nhapinput.Value));
            hold(app.UIAxes, 'on')
            a = (app.nhapkhoang.Value);
            if(isempty(a))
                x = -5:0.1:5;
                y = subs(y, x);
                plot(app.UIAxes ,x, y);
                grid(app.UIAxes, "on");
                title(app.UIAxes, app.nhapinput.Value)
            else
                m = str2num(a);
                M = str2num(app.nhapkhoang_2.Value);
                x = m:0.1:M;
                y = subs(y, x);
                plot(app.UIAxes ,x, y);
                grid(app.UIAxes, "on");
                title(app.UIAxes, app.nhapinput.Value)
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create NumericalMethodUIFigure and hide until all components are created
            app.NumericalMethodUIFigure = uifigure('Visible', 'off');
            app.NumericalMethodUIFigure.Color = [0.902 0.902 0.902];
            app.NumericalMethodUIFigure.Position = [100 100 745 587];
            app.NumericalMethodUIFigure.Name = 'Numerical Method';
            app.NumericalMethodUIFigure.ButtonDownFcn = createCallbackFcn(app, @NumericalMethodUIFigureButtonDown, true);
            app.NumericalMethodUIFigure.KeyPressFcn = createCallbackFcn(app, @NumericalMethodUIFigureKeyPress, true);

            % Create veButton
            app.veButton = uibutton(app.NumericalMethodUIFigure, 'push');
            app.veButton.ButtonPushedFcn = createCallbackFcn(app, @vedothi, true);
            app.veButton.FontName = 'Consolas';
            app.veButton.Position = [472 497 100 22];
            app.veButton.Text = {'Vÿ ÿÿ thÿ'; ''};

            % Create NhphmfxLabel
            app.NhphmfxLabel = uilabel(app.NumericalMethodUIFigure);
            app.NhphmfxLabel.HorizontalAlignment = 'right';
            app.NhphmfxLabel.FontName = 'Consolas';
            app.NhphmfxLabel.Position = [94 497 111 22];
            app.NhphmfxLabel.Text = {'Nhÿp hàm f(x) = '; ''};

            % Create nhapinput
            app.nhapinput = uieditfield(app.NumericalMethodUIFigure, 'text');
            app.nhapinput.FontName = 'Consolas';
            app.nhapinput.Position = [220 497 221 22];

            % Create pptinh
            app.pptinh = uibuttongroup(app.NumericalMethodUIFigure);
            app.pptinh.SelectionChangedFcn = createCallbackFcn(app, @pptinhSelectionChanged, true);
            app.pptinh.Title = 'Chÿn phÿÿng pháp tính';
            app.pptinh.FontName = 'Consolas';
            app.pptinh.Position = [34 346 257 123];

            % Create chiadoi
            app.chiadoi = uiradiobutton(app.pptinh);
            app.chiadoi.Text = {'Chia ÿôi'; ''};
            app.chiadoi.FontName = 'Consolas';
            app.chiadoi.Position = [11 77 75 22];
            app.chiadoi.Value = true;

            % Create daycung
            app.daycung = uiradiobutton(app.pptinh);
            app.daycung.Text = 'Dây cung';
            app.daycung.FontName = 'Consolas';
            app.daycung.Position = [11 55 75 22];

            % Create tieptuyen
            app.tieptuyen = uiradiobutton(app.pptinh);
            app.tieptuyen.Text = 'Tiÿp tuyÿn';
            app.tieptuyen.FontName = 'Consolas';
            app.tieptuyen.Position = [11 33 88 22];

            % Create lapdon
            app.lapdon = uiradiobutton(app.pptinh);
            app.lapdon.Text = {'Lÿp ÿÿn    ÿiÿm bÿt ÿÿu: '; ''};
            app.lapdon.FontName = 'Consolas';
            app.lapdon.Position = [12 10 187 22];

            % Create diembatdau
            app.diembatdau = uieditfield(app.pptinh, 'text');
            app.diembatdau.ValueChangedFcn = createCallbackFcn(app, @diembatdauValueChanged, true);
            app.diembatdau.ValueChangingFcn = createCallbackFcn(app, @diembatdauValueChanging, true);
            app.diembatdau.Enable = 'off';
            app.diembatdau.Position = [200 10 34 22];

            % Create tinhtheo
            app.tinhtheo = uibuttongroup(app.NumericalMethodUIFigure);
            app.tinhtheo.Title = 'Tính theo';
            app.tinhtheo.FontName = 'Consolas';
            app.tinhtheo.Position = [331 345 163 123];

            % Create saiso
            app.saiso = uiradiobutton(app.tinhtheo);
            app.saiso.Text = 'Sai sÿ';
            app.saiso.FontName = 'Consolas';
            app.saiso.Position = [11 77 62 22];
            app.saiso.Value = true;

            % Create vonglap
            app.vonglap = uiradiobutton(app.tinhtheo);
            app.vonglap.Text = 'Vòng lÿp';
            app.vonglap.FontName = 'Consolas';
            app.vonglap.Position = [11 55 75 22];

            % Create boxSS
            app.boxSS = uibuttongroup(app.NumericalMethodUIFigure);
            app.boxSS.Title = 'Sai sÿ theo';
            app.boxSS.FontName = 'Consolas';
            app.boxSS.Position = [521 345 180 123];

            % Create hmt
            app.hmt = uiradiobutton(app.boxSS);
            app.hmt.Enable = 'off';
            app.hmt.Text = 'Hàm mÿc tiêu';
            app.hmt.FontName = 'Consolas';
            app.hmt.Position = [11 77 101 22];
            app.hmt.Value = true;

            % Create gtlt
            app.gtlt = uiradiobutton(app.boxSS);
            app.gtlt.Enable = 'off';
            app.gtlt.Text = 'Giá trÿ liên tiÿp';
            app.gtlt.FontName = 'Consolas';
            app.gtlt.Position = [11 55 134 22];

            % Create xxbd
            app.xxbd = uiradiobutton(app.boxSS);
            app.xxbd.Enable = 'off';
            app.xxbd.Text = 'Xÿp xÿ ban ÿÿu (lÿp)';
            app.xxbd.FontName = 'Consolas';
            app.xxbd.Position = [11 31 154 22];

            % Create tinhtoan
            app.tinhtoan = uibutton(app.NumericalMethodUIFigure, 'push');
            app.tinhtoan.ButtonPushedFcn = createCallbackFcn(app, @ok_button, true);
            app.tinhtoan.FontName = 'Consolas';
            app.tinhtoan.Position = [463 298 100 22];
            app.tinhtoan.Text = 'Tính toán';

            % Create NghimxpxxEditFieldLabel
            app.NghimxpxxEditFieldLabel = uilabel(app.NumericalMethodUIFigure);
            app.NghimxpxxEditFieldLabel.HorizontalAlignment = 'right';
            app.NghimxpxxEditFieldLabel.FontName = 'Consolas';
            app.NghimxpxxEditFieldLabel.Position = [34 244 125 22];
            app.NghimxpxxEditFieldLabel.Text = 'Nghiÿm xÿp xÿ x = ';

            % Create x_output
            app.x_output = uieditfield(app.NumericalMethodUIFigure, 'numeric');
            app.x_output.ValueDisplayFormat = '%.8f';
            app.x_output.FontName = 'Consolas';
            app.x_output.Position = [174 244 117 22];

            % Create SaisdxLabel
            app.SaisdxLabel = uilabel(app.NumericalMethodUIFigure);
            app.SaisdxLabel.HorizontalAlignment = 'right';
            app.SaisdxLabel.FontName = 'Consolas';
            app.SaisdxLabel.Position = [34 209 125 22];
            app.SaisdxLabel.Text = 'Sai sÿ       dx = ';

            % Create dx_output
            app.dx_output = uieditfield(app.NumericalMethodUIFigure, 'numeric');
            app.dx_output.ValueDisplayFormat = '%.8f';
            app.dx_output.FontName = 'Consolas';
            app.dx_output.Position = [174 209 117 22];

            % Create VnglpkLabel
            app.VnglpkLabel = uilabel(app.NumericalMethodUIFigure);
            app.VnglpkLabel.HorizontalAlignment = 'right';
            app.VnglpkLabel.FontName = 'Consolas';
            app.VnglpkLabel.Position = [34 172 125 22];
            app.VnglpkLabel.Text = 'Vòng lÿp      k = ';

            % Create k_output
            app.k_output = uieditfield(app.NumericalMethodUIFigure, 'numeric');
            app.k_output.ValueDisplayFormat = '%.0f';
            app.k_output.FontName = 'Consolas';
            app.k_output.Position = [174 172 117 22];

            % Create xn1EditFieldLabel
            app.xn1EditFieldLabel = uilabel(app.NumericalMethodUIFigure);
            app.xn1EditFieldLabel.HorizontalAlignment = 'right';
            app.xn1EditFieldLabel.FontName = 'Consolas';
            app.xn1EditFieldLabel.Position = [88 134 72 22];
            app.xn1EditFieldLabel.Text = 'x (n-1) = ';

            % Create xnt1_output
            app.xnt1_output = uieditfield(app.NumericalMethodUIFigure, 'numeric');
            app.xnt1_output.ValueDisplayFormat = '%.8f';
            app.xnt1_output.FontName = 'Consolas';
            app.xnt1_output.Position = [175 134 116 22];

            % Create x0EditFieldLabel
            app.x0EditFieldLabel = uilabel(app.NumericalMethodUIFigure);
            app.x0EditFieldLabel.HorizontalAlignment = 'right';
            app.x0EditFieldLabel.FontName = 'Consolas';
            app.x0EditFieldLabel.Position = [122 98 38 22];
            app.x0EditFieldLabel.Text = 'x0 = ';

            % Create x0_output
            app.x0_output = uieditfield(app.NumericalMethodUIFigure, 'numeric');
            app.x0_output.ValueDisplayFormat = '%.8f';
            app.x0_output.FontName = 'Consolas';
            app.x0_output.Position = [175 98 117 22];

            % Create x1dEditFieldLabel
            app.x1dEditFieldLabel = uilabel(app.NumericalMethodUIFigure);
            app.x1dEditFieldLabel.HorizontalAlignment = 'right';
            app.x1dEditFieldLabel.FontName = 'Consolas';
            app.x1dEditFieldLabel.Position = [94 59 65 22];
            app.x1dEditFieldLabel.Text = 'x1 (d) = ';

            % Create x1_output
            app.x1_output = uieditfield(app.NumericalMethodUIFigure, 'numeric');
            app.x1_output.ValueDisplayFormat = '%.8f';
            app.x1_output.FontName = 'Consolas';
            app.x1_output.Position = [174 59 117 22];

            % Create UIAxes
            app.UIAxes = uiaxes(app.NumericalMethodUIFigure);
            title(app.UIAxes, 'Title')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            app.UIAxes.Position = [317 45 384 234];

            % Create dxkLabel
            app.dxkLabel = uilabel(app.NumericalMethodUIFigure);
            app.dxkLabel.HorizontalAlignment = 'right';
            app.dxkLabel.FontName = 'Consolas';
            app.dxkLabel.Position = [37 299 51 22];
            app.dxkLabel.Text = 'dx/k = ';

            % Create dxk
            app.dxk = uieditfield(app.NumericalMethodUIFigure, 'text');
            app.dxk.FontName = 'Consolas';
            app.dxk.Position = [86 298 100 22];

            % Create minEditField_2Label
            app.minEditField_2Label = uilabel(app.NumericalMethodUIFigure);
            app.minEditField_2Label.HorizontalAlignment = 'right';
            app.minEditField_2Label.FontName = 'Consolas';
            app.minEditField_2Label.Position = [208 299 45 22];
            app.minEditField_2Label.Text = 'min = ';

            % Create duoi
            app.duoi = uieditfield(app.NumericalMethodUIFigure, 'text');
            app.duoi.FontName = 'Consolas';
            app.duoi.Position = [251 299 45 22];

            % Create maxEditField_2Label
            app.maxEditField_2Label = uilabel(app.NumericalMethodUIFigure);
            app.maxEditField_2Label.HorizontalAlignment = 'right';
            app.maxEditField_2Label.FontName = 'Consolas';
            app.maxEditField_2Label.Position = [318 298 45 22];
            app.maxEditField_2Label.Text = 'max = ';

            % Create tren
            app.tren = uieditfield(app.NumericalMethodUIFigure, 'text');
            app.tren.FontName = 'Consolas';
            app.tren.Position = [362 298 45 22];

            % Create nhapkhoang
            app.nhapkhoang = uieditfield(app.NumericalMethodUIFigure, 'text');
            app.nhapkhoang.Position = [583 497 34 22];

            % Create nhapkhoang_2
            app.nhapkhoang_2 = uieditfield(app.NumericalMethodUIFigure, 'text');
            app.nhapkhoang_2.Position = [629 497 35 22];

            % Create pptlable
            app.pptlable = uilabel(app.NumericalMethodUIFigure);
            app.pptlable.HorizontalAlignment = 'center';
            app.pptlable.FontName = 'Consolas';
            app.pptlable.FontSize = 18;
            app.pptlable.FontWeight = 'bold';
            app.pptlable.FontColor = [1 0 0];
            app.pptlable.Position = [1 548 741 23];
            app.pptlable.Text = {'PHÿÿNG PHÁP TÍNH'; ''};

            % Create update
            app.update = uibutton(app.NumericalMethodUIFigure, 'push');
            app.update.ButtonPushedFcn = createCallbackFcn(app, @updatePushed, true);
            app.update.FontName = 'Consolas';
            app.update.Position = [614 12 100 22];
            app.update.Text = {'Cÿp nhÿt'; ''};

            % Create slogan
            app.slogan = uilabel(app.NumericalMethodUIFigure);
            app.slogan.HorizontalAlignment = 'center';
            app.slogan.FontName = 'Consolas';
            app.slogan.FontAngle = 'italic';
            app.slogan.Position = [281 527 183 22];
            app.slogan.Text = {'ÿÿc kÿ HDSD trÿÿc khi dùng!'; ''};

            % Create gopy
            app.gopy = uibutton(app.NumericalMethodUIFigure, 'push');
            app.gopy.ButtonPushedFcn = createCallbackFcn(app, @gopyPushed, true);
            app.gopy.FontName = 'Consolas';
            app.gopy.Position = [461 12 121 22];
            app.gopy.Text = 'Góp ý và Liên hÿ';

            % Create HngdnsdngButton
            app.HngdnsdngButton = uibutton(app.NumericalMethodUIFigure, 'push');
            app.HngdnsdngButton.FontName = 'Consolas';
            app.HngdnsdngButton.Position = [600 548 127 22];
            app.HngdnsdngButton.Text = 'Hÿÿng dÿn sÿ dÿng';

            % Create VDC
            app.VDC = uilabel(app.NumericalMethodUIFigure);
            app.VDC.HorizontalAlignment = 'center';
            app.VDC.FontName = 'Consolas';
            app.VDC.Position = [11 12 84 22];
            app.VDC.Text = 'Vÿ ÿÿc Cÿÿng';

            % Create dfxdxButton
            app.dfxdxButton = uibutton(app.NumericalMethodUIFigure, 'push');
            app.dfxdxButton.ButtonPushedFcn = createCallbackFcn(app, @dfxdxButtonPushed, true);
            app.dfxdxButton.FontName = 'Consolas';
            app.dfxdxButton.Position = [597 299 100 23];
            app.dfxdxButton.Text = 'df(x)/dx';

            % Show the figure after all components are created
            app.NumericalMethodUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = NumMethod_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.NumericalMethodUIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.NumericalMethodUIFigure)
        end
    end
end