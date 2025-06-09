%%
% Return the resolvent of A^-1 given R the resolvent of A
function nresv = resvinv(R)
    nresv = @(x, alpha) x - alpha * R(x/alpha, 1/alpha);
end