function [a, b] = generate_ideal_diode() 
    ran = 1000;
    a = (rand - 1) * ran;
    b = rand * ran;
    ch = randi([0, 1]);
    if (ch == 1)
        a = 0;
    else
        b = 0;
    end
end