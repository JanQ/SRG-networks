%%
% Resolvent resistor
function resv = RR(i, alpha, R, offset)
    resv = (i + alpha * offset) ./ (alpha * R + 1);
end