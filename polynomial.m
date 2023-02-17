% This code solves the polynomial long division problem
% given f(x) and g(x) write f(x) = g(x)q(x) + r(x) where
% the degree of r(x) is less than the degree of f(x)
% f(x) = a+bx+cx^2 as a list of coefficients would be 
% represented by [a, b, c]

% f(x)
f = [1,2]; 

% g(x)
g = [1,2,3];

[q,r]=pol_div(f,g,[0]);

% function to perform long division
function [q,r] = pol_div(f,g,q)
    if length(f) < length(g)
        r = f;
        return; % stop when deg(r) < deg(g)
    end
    matcher = match(f,g); % find match(f,g)
    q = add(q, matcher); % keep track of the matches so far
    f = add(f, -mult(matcher,g)); % subtract f(x) - match(f,g)*g(x)
    [q,r] = pol_div(f,g,q); % deg(f-match(f,g)*g) < deg(f) so recursively continue the algorithm
end

% match(f,g) is the what we multiply into g(x) so that
% it has the same leading term as f(x)
function matcher = match(f,g)
    diff = length(f)-length(g);
    if diff == 0
        matcher = f(length(f))/g(length(g));
    end
    matcher(1:diff) = 0;
    matcher(diff+1) = 1;
    matcher = (f(length(f))/g(length(g)))*matcher;
end

% function to perform polynomial addition
function res = add(f,g)
    if length(f) > length(g)
        g(length(g)+1:length(f)) = 0;
    end
    if length(g) > length(f)
        f(length(f)+1:length(g)) = 0;
    end
    res = f + g;
    res = res(1:find(res, 1, 'last'));
end

% function to perform polynomial multiplication
function res = mult(f, g)
    res = []
    for k = 1:length(f)*length(g)
        res = [res, coef(k, f, g)];
    end
    res = res(1:find(res, 1, 'last'));
end

% function to find the k-th coefficient of the product f(x)g(x)
function coef = coef(k, f, g)
    coef = 0;
    for i = 1:length(f)
        for j = 1:length(g)
            if i + j == k+1
                coef = coef + f(i)*g(j);
            end
        end
    end
end