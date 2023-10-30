function Dx = Depth1D(which, data)
candidate = data(which);
Fx = sum(data <= candidate)/length(data);
Dx = 1-2*abs((1/2)-Fx);