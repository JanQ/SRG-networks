%%
% Plot numerical SRG of an operator
% @param gen_input_output ; Function which outputs a sample input output pair
% @param N                ; Number of points to sample
function plot_srg(gen_input_output, N)
    maxang = 0;
    pts = zeros(2*N, 2);
    for i = 1:N
        [x, u] = gen_input_output();
        [y, v] = gen_input_output();
        outputdiff = norm(u - v);
        inputdiff = norm(x - y);
        if inputdiff == 0
            continue
        end
        angle = getang(u, v, x, y);
        maxang = max(maxang, angle);
        c = outputdiff / inputdiff * exp(1i * angle);
        pts(2*i-1, :) = [real(c) imag(c)];
        pts(2*i, :) = [real(c) -imag(c)];
    end
    disp(['Maximum angle is ' num2str(maxang)])
    figure; set(gcf, 'color', 'white')
    scatter(pts(:,1), pts(:,2), 40, 'markeredgealpha',0.3, 'MarkerFaceColor', [0.0,0.6056031611752245,0.9786801175696073], 'markerfacealpha', 0.3)
    set(gca, 'TickLabelInterpreter', 'latex', 'fontsize', 17)
    xlabel('Re $z$', 'interpreter', 'latex', 'fontsize', 19)
    ylabel('Im $z$', 'interpreter', 'latex', 'fontsize', 19)
end

%%
% Calculate the incremental angle between input pair (x,y) and output pair (u,v)
function ang = getang(u, v, x, y)
    a = u - v;
    b = x - y;
    if norm(a) * norm(b) == 0
        ang = 0;
    else
        ang = acos(dot(a,b) / (norm(a) * norm(b)));
    end
end