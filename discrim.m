function g = discrim(x,p,q)
    g = 0;

    for i = 1 : 256
        g = g + x(i) * log(p(i)/q(i)) + (1 - x(i)) * log((1-p(i))/(1-q(i)));
    end
end