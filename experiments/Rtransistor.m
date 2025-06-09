%%
% Resolvent transistor (with ideal diodes with no residuals)
% @param vs     ; Input, should have dimensions 2 x N
% @param alpha  ; Step size resolvent
% @param alphaR ; Param transistor
% @param alphaF ; Param transistor
function resv = Rtransistor(vs, alpha, alphaR, alphaF)
    resv = zeros(size(vs));
    A = alpha * [1 -alphaR; -alphaF 1];

    for i=1:size(vs,2)
        % Solving [v1; v2] \in [x; y] + alpha [1 -alphaR; -alphaF 1] [u; v]
        % where u \in D(x) and v \in D(y)
        % Case 1: x = y = 0
        uv = A \ vs(:,i);
        if check_valid_diode_quad([0; 0], uv)
            resv(:,i) = [0; 0];
            continue
        end
    
        % Case 2: x = 0, v = 0
        uy = [alpha 0; -alpha*alphaF 1] \ vs(:,i);
        if check_valid_diode_quad([0; uy(2)], [uy(1); 0])
            resv(:,i) = [0; uy(2)];
            continue
        end
    
        % Case 3: u = 0, y = 0
        xv = [1 -alpha*alphaR; 0 alpha] \ vs(:,i);
        if check_valid_diode_quad([xv(1); 0], [0; xv(2)])
            resv(:,i) = [xv(1); 0];
            continue
        end
    
        % Case 4: u = 0, v = 0
        xy = vs(:,i);
        if check_valid_diode_quad([xy(1); xy(2)], [0; 0])
            resv(:,i) = xy;
            continue
        end

        vs
        alpha
        assert(false)
    end
end

function ok = check_valid_diode_quad(v, i)
   ok = check_valid_diode_pair(v(1),i(1)) && check_valid_diode_pair(v(2),i(2));
end

function ok = check_valid_diode_pair(v, i)
   ok = v <= 3 * eps && i >= -3 * eps && abs(i * v - eps) <= 3 * eps;
end