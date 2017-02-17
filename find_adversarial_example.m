function x_adv = find_adversarial_example(x, D, y_target)
% FIND_ADVERSARIAL_EXAMPLE Given a linear classifier, finds the 
%   adversarial example with minimum Euclidean distance to the original
%   example with a specified target label.
%
% @param x Original example, specified as n*1 double.
% @param D k*n double matrix representing linear classifier where output 
%   label is y=argmax(D*x)_i
% @param y_target Target label for adversarial example.
% @returns x_adv Example which linear classifier classifies in
%   y_target with minimum Euclidean distance to original example.
  
  x_size = size(x, 1)
  y = D*x;
  
  % For R2016b and later
  % A = D - D(y_target+1, :);
  % For R2016a and earlier
  A = bsxfun(@minus, D, D(y_target+1, :));
  
  margin = sum(abs(A), 2)/(2); % deals with shift in relative values
                                   % due to rounding
  
  b = -(y - y(y_target+1)) - margin;
  lb = -x;
  ub = 255-x;
  % you do have to specify min and max!!
  
  %% use gurobi solver
  model.A = sparse(A);
  model.rhs = b;
  model.obj = zeros(x_size, 1);
  model.lb = lb;
  model.ub = ub;
  model.sense = '<';
  model.modelsense = 'min';
  model.modelname = 'Adversarial example finder';
  model.Q = sparse(eye(x_size));
  
  result = gurobi(model);
  x_adv = uint16(clamp(x + result.x, 0, 255));
end