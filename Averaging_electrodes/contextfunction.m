function [c, idx] = contextfunction(past, contexts)
%CONTEXTFUNCTION return the context associated to a given sequence (past sequence)
% 
% Inputs
%
% 	past      : sequence
% 	contexts  : set of contexts (context tree)
% 
% Outputs
%
% 	c         : context associated to the sequence [past]
% 	idx       : index (position) of the context [c] in [contexts] 
%
% Usage
%			ctxs = {0, [0 1], [1 1], 2};
%			past = [0 1 1 0 1 2 0 1];
%			[c, idx] = contextfunction(past, ctxs);
%

%Author : Noslen Hernandez (noslenh@gmail.com), Aline Duarte (alineduarte@usp.br)
%Date   : 05/2019


n_contexts = size(contexts, 2);
idx = -1;
c = [];

i = 1;

while (i <= n_contexts)&&...
        ( (size(contexts{i},2) > size(past,2)) || ...
            (sum(contexts{i} ~= past(end-size(contexts{i},2)+1 : end)) ~= 0) )
    i = i + 1;
end

if (i <= n_contexts)
    c = contexts{i};
    idx = i;
end

end