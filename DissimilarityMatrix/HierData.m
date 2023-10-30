function [retmat, uc] = HierData(lin, crit, param)

ar = size(lin, 1)+1;
clusters = nan(ar, ar);
clusters(1, :) = [1:ar];
for i = 1:ar-1
	clusters(i+1, :) = clusters(i, :);
	clusters(i+1, find(clusters(i, :) == lin(i, 1))) = ar+i;
	clusters(i+1, find(clusters(i, :) == lin(i, 2))) = ar+i;
end
if crit == 1
	uc = clusters(ar-param+1, :);
elseif isempty(clusters(min(find(squeeze(lin(:, 3)) > param)), :))
	uc = clusters(length(lin(:, 3))+1, :);
else
	uc = clusters(min(find(squeeze(lin(:, 3)) > param)), :);
    %uc = clusters(max(find(squeeze(lin(:, 3)) < param)), :);
end
retmat = zeros(ar, ar);
for j = 1:ar-1
	for k = j+1:ar
		retmat(j, k) = sum(uc(j) ~= uc(k));
		retmat(k, j) = retmat(j, k);
	end
end
%for h = 1:size(retmat, 1)
%	retmat(h, h) = NaN;
%end