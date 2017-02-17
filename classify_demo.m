function classify_demo

load mnistabridged;

% The least squares formulation is Ax = b, where each row 
% of A is an image, and each row of b is a 0 or 1 to say
% whether that image is a 2 (for instance)

possible_labels = 0:9;

A = double(train)'/255; % rescale A to be between 0 or 1
u0 = mean(A);
A = A-repmat(u0,size(A,1),1); % de-mean A
A = [A,ones(size(A,1),1)]; % add a column of 1s to allow for each
                           % classifier to have an offset term

% de-meaning A seems to improve performance slightly (but not significantly!)


b = double(trainlabels==possible_labels);
x = A\b; % x is the classifier, with x(:, k+1) corresponding
         % to the classifier for the digit k

figure(1);
set(gcf, 'Name', 'Images creating maximum activation');
for k = 0:9
  d = x(1:end-1,k+1);
  y0 = x(end,k+1);
  % we used to add u0', the mean of A, but removed it.
  nom(:, k+1) = pinv(d')*(1-y0);% nom is the output that maximizes the
                        % activation of the classifier for k.
                        % it looks like pinv here is effectively
                        % just scaling by norm(d)^2
end  

plot_maximum_activation(nom, [0, 0.002], gray);
     
Atest = double(test)'/255 - repmat(u0,size(test,2),1);
Atest = [Atest,ones(size(Atest,1),1)];

[~,label]= max(Atest*x,[],2);
% [~,label]= max(repmat(x(end,:),size(Atest,1),1)+Atest*x(1:end-1,:),[],2);

fprintf(1,'Score: %d/%d\n',sum((label-1) == testlabels),length(testlabels));
end