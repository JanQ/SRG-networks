%%
% Chambolle-Pock Algorithm
%   solve 0 \in [A(x); B(y)] + [0 M^T; -M 0][x; y]
%
% @param RA     ; Resolvent A
% @param RB     ; Resolvent B
% @param M      ; M (as a functor)
% @param Mt     ; M transpose (as a functor)
% @param gamma    ; Stepsize resolvent A
% @param tau  ; Stepsize resolvent B
% @param x0     ; Initial guess x
% @param y0     ; Initial guess y
% @param eps    ; Stopping criterion
% @param maxits ; Maximum number of iterations
% @param lambda ; Relaxation parameter
% @param verbose; Enable verbosity
function [xstar, ystar] = cpa(RA, RB, M, Mt, gamma, tau, x0, y0, eps, maxiters, lambda, verbose)
    arguments
        RA; RB; M; Mt; gamma; tau; x0; y0; eps; maxiters; lambda = 1; verbose = false;
    end
    for its = 1:maxiters
        xbarnext = RA(x0 - gamma * Mt(y0), gamma);
        ybarnext = RB(y0 + tau * M(2 * xbarnext - x0), tau);
        xnext = x0 + lambda * (xbarnext - x0);
        ynext = y0 + lambda * (ybarnext - y0);
        rel_err_x = norm(x0 - xnext) / norm(x0);
        rel_err_y = norm(y0 - ynext) / norm(y0);
        if max(rel_err_x, rel_err_y) < eps
            break;
        end
        x0 = xnext;
        y0 = ynext;
    end
    if verbose
        disp(['Chambolle Pock stopped after ' num2str(its) ' iterations'])
    end
    xstar = xnext;
    ystar = ynext;
end