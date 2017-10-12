% set the range of n
n = 1:10
x = n + 1 % values for which gamma is calculated
n = sqrt(2.*pi.*n).*((n./exp(1)).^n) % stirling approx.
fac = gamma(x) % gamma(x) = (x-1)!

% get absolute error
abs = n - fac

% get the relative error
rel = abs ./ fac

% findings: For the absolute error, the error increases
% as n increases. Interestingly, the error increases at a rate
% that can be modeled as: abs[i+1] = abs[i] * i

% For the relative error, the error decreases as n increases. 
% This is related to the fact that while both the factorial and 
% approximation values are linearly increasing, the factorial is 
% ahead by i = 1. I.E. to get from 3! to 4! we multiply by 4, whereas
% the error is only multiplying by 3 at that same index