function [x, y] = generate_transistor(alpha_R, alpha_F)
    arguments
        alpha_R = 110/111; alpha_F = 10/11;
    end
    A = [1 -alpha_R; -alpha_F 1];

    [a, b] = generate_ideal_diode();
    [c, d] = generate_ideal_diode();
    x = [a; c];
    y = A * [b; d];
end