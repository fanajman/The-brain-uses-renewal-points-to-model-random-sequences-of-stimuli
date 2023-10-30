function browns = CreateBrown(n, smp, seeduse)
if seeduse ~= 0
    rng(seeduse)
end
browns = nan(n, smp);
for proj = 1:n
	%if typedir == 1
			browns(proj, :) = Brownian_Brigde(smp);
	%elseif typedir == 2
			%browns(proj, :) = Haar_Combination(smp);
	%elseif typedir == 3
			%browns(proj, :) = ProcessFunGen(smp, 1, 0.7);
	%elseif typedir == 4
			%browns(proj, :) = ZeroOneFunGen(smp, 0.7);
	%elseif typedir == 5
			%browns(proj, :) = JumpFunGen(smp, 0.9);
	%end
end

%plot(browns')