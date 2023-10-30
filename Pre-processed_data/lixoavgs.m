nms = {'01','02', '03', '06', '07', '08','09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20'};
svavgs2 = zeros(4, 128, 113);   
keyboard
for i = 1:18
    load(['V' nms{i} '.mat']);
    X = data.X_qua;
    [placement, Tree] = Find_Placement(X, 0:1:2, 3);
    placement = [-1 -1 placement];
    Y_all = data.Y_qua;
    for j = 1:length(evnts)
        Y = Y_all{2, j};
        %disp(str2num(evnts{j}(2:end)))
        sur = (placement == 1 | placement == 2 | placement == 5 | placement == 6);
        const = (placement == 3 | placement == 4);
        weak = (placement == 7 | placement == 8 | placement == 9 | placement == 10);
        strong = (placement == 11 | placement == 12);
        %for k = 1:12
            svavgs2(1, str2num(evnts{j}(2:end)), :) = squeeze(svavgs2(1, str2num(evnts{j}(2:end)), :))+mean(Y(:, sur), 2);
            svavgs2(2, str2num(evnts{j}(2:end)), :) = squeeze(svavgs2(2, str2num(evnts{j}(2:end)), :))+mean(Y(:, const), 2);
            svavgs2(3, str2num(evnts{j}(2:end)), :) = squeeze(svavgs2(3, str2num(evnts{j}(2:end)), :))+mean(Y(:, weak), 2);
            svavgs2(4, str2num(evnts{j}(2:end)), :) = squeeze(svavgs2(4, str2num(evnts{j}(2:end)), :))+mean(Y(:, strong), 2);
        %end
    end

end
keyboard
 svavgs2 = svavgs2/18;
 plot(linspace(0.05, 400, 113),squeeze(svavgs(5, 108, :)))