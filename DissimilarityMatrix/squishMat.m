function v = squishMat(mat)
v = [];
for i = 2:length(mat)
	v = [v mat(i-1, i:end)];
end
