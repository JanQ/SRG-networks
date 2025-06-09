%%
% Return the resolvent of the operator A(x - z) with z constant
% where R is the resolvent of A
function nresv = resvinputshift(R, z)
    nresv = @(x, alpha) z + R(x - z, alpha);
end