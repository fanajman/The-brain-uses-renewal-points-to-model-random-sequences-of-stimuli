function fundpt = FunctionDepth(which, data)
svDi = nan(1, size(data, 2));
for i = 1:size(data, 2);
	data1D = data(:, i);
	svDi(i) = Depth1D(which, data1D);
end
fundpt = mean(svDi);
