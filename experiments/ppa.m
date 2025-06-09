%%
% Proximal point algorithm
%   solve 0 \in A(x)
%
% @param RA      ; Resolvent A
% @param gamma   ; Stepsize 
% @param x0      ; Initial point
% @param rel_err ; Forward error stopping critertion
% @param maxits  ; Maximum number of iterations
function [xstar, results] = ppa(RA, gamma, x0, rel_err, maxits)
    results = {};
    for its = 1:maxits
         xnext = RA(x0, gamma);
         results{its} = xnext;
         if max(norm(xnext - x0)) / norm(x0) < rel_err
             break
         end
         x0 = xnext;
    end
    disp(['PPA finished after ' num2str(its) ' iterations'])
    xstar = xnext;
end