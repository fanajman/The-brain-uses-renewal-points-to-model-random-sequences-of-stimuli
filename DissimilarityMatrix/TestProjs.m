function resul = TestProjs(data, browns, placement, w1, w2, varargin)
%% Alocate memory for the results.
resul = nan(6, size(browns, 1));
l1 = length(find(placement == w1));
l2 = length(find(placement == w2));
d = (data' * browns')';
if isempty(varargin)
	alpha = 0.05;
else
	alpha = varargin{1};
end

%%%% Normalization test
% for i = 1:5000
%     vm = max(abs(browns(i, :)));
%     browns(i, :) = browns(i, :)/vm;
% end

for i = 1:size(browns, 1)
    %disp(num2str(i))
%	d1 = [];
%	d2 = [];
	%keyboard
%	if isempty(find(placement == w1)) | isempty(find(placement == w2))
%		keyboard
%	end
%	d1 = (data(:, placement == w1)' * browns(i, :)')';
%	d2 = (data(:, placement == w2)' * browns(i, :)')';

    d1 = d(i, placement == w1);
	d2 = d(i, placement == w2);
    %%%Normaliztion test
    %dscale = (max(abs([d1 d2])));
    %d1 = d1/(max(abs([d1 d2])));
    %d2 = d2/(max(abs([d1 d2])));

    %mid = mean([d1 d2]);
    %d1 = d1/mean(d1);
    %d2 = d2/mean(d2);

    [a] = kstest2(d1, d2, 'alpha', alpha);
    dataproj = [-inf, sort([d1 d2]), inf];
	%keyboard
	H1 = histc(d1 , dataproj);
	H2 = histc(d2 , dataproj);
	C1 = cumsum(H1)./sum(H1);
	C2 = cumsum(H2)./sum(H2);
    c = max(abs(C1-C2));
	k = max(abs(C1-C2))*sqrt(length(d1)*length(d2)/(length(d1)+length(d2)));
	n = sqrt(l1*l2/(l1+l2));
    %ud = dataproj(2:end-1);
    %uC1 = C1(2:end-1);
    %uC2 = C2(2:end-1);
    %cvm = 1/2*(abs(uC1(2:end)-uC2(2:end))+abs(uC1(1:end-1)-uC2(1:end-1)))*diff(ud)';
    %valus = sort(unique([unique(C1) unique(C2)]));

    %hordists = [];
    %sd1 = sort(d1);
    %sd2 = sort(d2);
    %for hor = valus
    %    p1 = find(C1 > hor, 1, 'first');
    %    p2 = find(C2 > hor, 1, 'first');
    %    if ~isempty(p1) && ~isempty(p2)
    %        whdt1 = sd1(find(sd1 == dataproj(p1), 1, 'first'));
    %        whdt2 = sd2(find(sd2 == dataproj(p2), 1, 'first'));
    %        hordists = [hordists abs(whdt1-whdt2)];
    %    end
    %end 
    
	%critMATLAB = max((sqrt(n) + 0.12 + 0.11/sqrt(n)) * c , 0);
	%if i == 2925 | i == 4364
	%	keyboard
	%end

    crit = sqrt(-log(alpha/2)/2);
	%resul(1, i) = a;
	%resul(2, i) = c;
	%resul(4, i) = c*n;
    resul(3, i) = c*n > crit;
    %resul(3, i) = c*n > 1.3581;
    %resul(5, i) = cvm/sqrt(sum((browns(i, :)).^2));
    %resul(5, i) = cvm/(sum(abs(browns(i, :))));
    %resul(6, i) = max(hordists);

end
