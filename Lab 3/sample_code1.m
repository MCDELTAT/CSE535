% This is a sample code for lab 3 to implement NMF
% Some codes are missing, you should be able to add the missing codes commented by xxxxxxx and make it work

load Fence_data                                                                             % load the whole data set

data = artificial_data;                                                                     % extract out the data

[x, y, z] = size(data);                                                                     % get the dimensions of data (1a)

V = reshape(data, [], z);                                                                   % convert original data to two dimensional matrix (1b)

rank = 16;                                                                                  % define the number of bases (1c)
iteration = 1000;                                                                           % define iteration criterion (1d)

W = 2 * rand((x*y), rank);                                                                  % initialize W, H (1c)
H = 2 * rand(rank, z); 

% Honestly couldn't figure out algorithm used in book. This is ALS
% algorithm taken from implementation found in nnmf(). Just needed
% something working to do the other parts.
tolx = 1e-4
tolfun = 1e-4;
nm = numel(V);
sqrteps = sqrt(eps);
w0 = rand(1024, 16);
h0 = rand(16, 69);
for ii = 1:iteration
    % updating rules for W, H (1e)
    
    % Alternating least squares
    H = max(0, w0\V);
    W = max(0, V/H);
    
    % Get norm of difference and max change in factors
    d = V - W*H;
    dnorm = sqrt(sum(sum(d.^2))/nm);
    dw = max(max(abs(W-w0) / (sqrteps+max(max(abs(w0))))));
    dh = max(max(abs(H-h0) / (sqrteps+max(max(abs(h0))))));
    delta = max(dw,dh);
    
    % Check for convergence
    if j>1
        if delta <= tolx
            break;
        elseif dnorm0-dnorm <= tolfun*max(1,dnorm0)
            break;
        elseif j==iteration
            break
        end
    end

    % Remember previous iteration results
    dnorm0 = dnorm;
    w0 = W;
    h0 = H;
end

figure(111)
for mm = 1:rank                                                                             % show some samples of original data (2a)
    subplot(sqrt(rank), sqrt(rank), mm);imshow(data(:,:,mm));
end

% Show Factor W
figure(112)
for mm = 1:rank
    % reshape each column vector into 32x32 matrix
    reW = reshape(W(1:1024, mm), [32, 32]);
    subplot(sqrt(rank), sqrt(rank), mm);imshow(reW(:,mm));
end    

% Show Factor H
figure(113)
subplot(sqrt(rank), sqrt(rank), rank);imshow(H(:,:));

% 
% figure(222)
% for mm = 1:rank
%     % xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;                                            % show the learned bases use imagesc()
%                                                                                             % function
%     colormap(gray); axis off;
% end  

