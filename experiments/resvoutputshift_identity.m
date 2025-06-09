%%
% Return the resolvent of the operator A(x) + c * x
% where R is the resolvent of A
function nresv = resvoutputshift_identity(R, shift)
    nresv = @(x, alpha) R(x / (1 + alpha * shift), alpha / (1 + shift * alpha));
end