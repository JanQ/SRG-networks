%%
% Return the resolvent of the operator A(x) + shift
% where R is the resolvent of A
function nresv = resvoutputshift(R, shift)
    nresv = @(x, alpha) R(x - alpha * shift, alpha);
end