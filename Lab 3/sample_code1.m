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

for ii = 1:iteration
    % Lee and Seung's Muplicative Update Rule
    % H[ij] = H[ij]*((W^T*V)[ij]/(W^T*W*H)[ij])
    % W[ij] = W[ij]*((V*H^T)[ij]/(W^T*W*H)[ij])
    
    x1=repmat(sum(W,1)', 1, z);                                                             % updating rules for W, H (1e)
    H=H.*(W'*(V./(W*H)))./x1;
    x2=repmat(sum(H,2)', (x*y), 1);
    W=W.*((V./(W*H))*H')./x2;
    
    % check for convergence/stability to see if we can save CPU cycles
    
end

figure(111)
for mm = 1:rank                                                                             % show some samples of original data (2a)
    subplot(sqrt(rank), sqrt(rank), mm);imshow(data(:,:,mm));
end

% Show Factor W
figure(Factor W)
for mm = 1:rank
    
end    

% Show Factor H


% 
% figure(222)
% for mm = 1:rank
%     % xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;                                            % show the learned bases use imagesc()
%                                                                                             % function
%     colormap(gray); axis off;
% end  

