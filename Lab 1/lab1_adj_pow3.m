% An application to calculate the 3rd power of the adjacency matrix
% The general form of each matrix entity is given by SUM(AikAklAlj),
% where k,l=1 to n. Given that this a double summation, there are far
% too many permutations to calculate by hand (36?), thus this program

% define the adjacency matrix
A=[0 1 0 0 0 0;1 0 1 0 0 1;0 1 0 1 0 0;0 0 1 0 1 1;0 0 0 1 0 1;0 1 0 1 1 0]

% attempt to calculate A^2 since it's simpler
A2=zeros(6,6) % init 6x6 matrix with zeroes
for i = 1:6 % loop over column
   for j = 1:6 % loop over row
       val = 0
       for k = 1:6 % loop over k for custom summation 
          val = val + (A(i, k).*A(k, j)) 
       end    
       A2(i, j) = val
   end    
end

% now calculate the more complicated A^3
A3=zeros(6,6) % init 6x6 matrix with zeroes
for i = 1:6 % loop over column
   for j = 1:6 % loop over row
       val = 0
       for k = 1:6 % loop over k for custom summation
          for l = 1:6 % loop over l in summation 
            val = val + (A(i, k).*A(k, l).*A(l, j))
          end  
       end    
       A3(i, j) = val
   end    
end