%hhvar = [];
%hhvar2 = [];
%for h = 1:100
%%
asd = 100;
savemaxs = cell(4,asd);
max1 = [];
max2 = [];
for numericalrep = 1:asd
%%
n = 100;
parameterA = 0.2;
EEGA = nan(n,80);
EEGA(:,1) = 0;
for i = 1:n
    for j = 2:80
        EEGA(i,j) = parameterA*EEGA(i,j-1)+normrnd(0,1);
    end
end

parameterB = -parameterA;
EEGB = nan(n,80);
EEGB(:,1) = 0;
for i = 1:n
    for j = 2:80
        EEGB(i,j) = parameterB*EEGB(i,j-1)+normrnd(0,1);
    end
end


EEGC = nan(n,80);
EEGC(:,1) = 0;
for i = 1:n
    for j = 2:80
        EEGC(i,j) = parameterA*EEGC(i,j-1)+normrnd(0,1);
    end
end

crv = linspace(0,1,500);
ksds = [];
pvs = [];
for j = 1:500
    brown = browns(j, :);
    ZA = EEGA*brown';
    ZB = EEGB*brown';
    [a,b,c] = kstest2(ZA,ZB);
    ksds = [ksds c];
    pvs = [pvs b];
end
pc = [];bound = [];
for i = 1:500
    if n < 458
        %delta = (-0.07/n)+(40/n^2)-(399/n^3);
        pc = [pc sum(ksds>crv(i))/500];bound = [bound min(1,2.71828*e^(-n*crv(i)^2))];
        %pc = [pc sum(ksds>crv(i))/500];bound = [bound min(1,4*e^(-(n/2)*crv(i)^2))];
    else
        pc = [pc sum(ksds>crv(i))/500];bound = [bound min(1,2*e^(-n*crv(i)^2))];
        %pc = [pc sum(ksds>crv(i))/500];bound = [bound min(1,4*e^(-(n/2)*crv(i)^2))];
    end
end
%%
% % figure;plot(crv,pc)
% % hold
% % plot(crv,bound)
%%
ksds2 = [];
pvs2 = [];
for j = 1:500
    brown = browns(j, :);
    ZA = EEGA*brown';
    ZC = EEGC*brown';
    [a,b,c] = kstest2(ZA,ZC);
    ksds2 = [ksds2 c];
    pvs2 = [pvs2 b];
end
pc2 = [];bound2 = [];
for i = 1:500
        if n < 458
        %delta = (-0.07/n)+(40/n^2)-(399/n^3);
        pc2 = [pc2 sum(ksds2>crv(i))/500];bound2 = [bound2 min(1,2.71828*e^(-n*crv(i)^2))];
        %pc2 = [pc2 sum(ksds2>crv(i))/500];bound2 = [bound2 min(1,4*e^(-(n/2)*crv(i)^2))];
    else
        pc2 = [pc2 sum(ksds2>crv(i))/500];bound2 = [bound2 min(1,2*e^(-n*crv(i)^2))];
        %pc2 = [pc2 sum(ksds2>crv(i))/500];bound2 = min(1,[bound2 4*e^(-(n/2)*crv(i)^2))];
    end
end

%% Section of the numerical repetitions
savemaxs{1, numericalrep} = pc;
savemaxs{2, numericalrep} = pc2;
max1 = [max1 max(pc-bound)];
max2 = [max2 max(pc2-bound2)];
disp(num2str(numericalrep))
end
savemaxs{3, numericalrep} = max1;
savemaxs{4, numericalrep} = max2;
figure;hist(max1,15)
xlim([0 1])
figure
hist(max2,15)
xlim([0 1])
figure
plot(sort(max1))
hold
plot(sort(max2))
sum(max1>0.1)/100
sum(max2>0.1)/100
%%
figure;plot(crv,pc2)
hold
plot(crv,bound2)
figure
plot(pc2-bound2)
hold
plot(pc2)
plot(bound2)
max(pc2-bound2)
% % 
% % figure
% % plot(pc-bound)
% % hold
% % plot(pc2-bound2)
% % hold
%%


%hhvar = [hhvar max(pc-bound)];
%hhvar2 = [hhvar2 max(pc2-bound2)];

%end

%nline = sqrt(n)*(crv-pvs)./sqrt(pvs.*(1-pvs));

%figure
%plot(sort(pvs))
%hold
%plot(crv*j,crv)
%figure
%plot(sort(pvs2))
%hold
%plot(crv*j,crv)
%hold
%parameterA
%parameterB

%usebound = find(bound<=1);
%stat1 = max(pc-bound)
%stat2 = max(pc2-bound2)

%hc1 = max(sort(pvs)-crv)
%hc2 = max(sort(pvs2)-crv)