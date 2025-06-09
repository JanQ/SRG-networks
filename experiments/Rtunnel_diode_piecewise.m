
function resv = Rtunnel_diode_piecewise(is, alpha, Vbar, G1, G2)
    arguments
        is; alpha; Vbar = 0.5; G1 = 1/100; G2 = 1/900;
    end
    resv = zeros(size(is));
    for i=1:length(is)
        curri = is(i);

        if curri < -alpha * Vbar + G2 * Vbar
            resv(i) = G2 * Vbar + (1 / (1 + alpha / G1)) * (curri + alpha * Vbar - G2 * Vbar); 
        elseif curri <= alpha * Vbar - G2 * Vbar
            resv(i) = (1 / (1 - alpha / G2)) * curri;
        else
            resv(i) = -G2 * Vbar + (1 / (1 + alpha / G1)) * (curri - alpha * Vbar + G2 * Vbar);
        end
    end
end