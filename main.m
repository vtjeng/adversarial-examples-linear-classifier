load mnistabridged;

% Specify possible labels, and size of input vector.
possible_labels=0:9;
% x_size=784;
[~, num_labels] = size(possible_labels);
[num_train_examples, ~] = size(trainlabels);


Xt=double(train)'/255;
% For R2016b and later
% Yt=double(trainlabels == possible_labels);
% In MATLAB R2016a and earlier, you need to explicitly specify that you
% want implicit expansion enabled
Yt = double(bsxfun(@eq, trainlabels, possible_labels));
% Create linear classifier Dt. (Note that we have no guarantees that Dt is
% the optimal classifier that minimizes the number of misclassifications,
% but this is not critical for demonstrating adversarial examples).
Dt=Xt\Yt;

D = Dt';

Xtest = double(test)/255;

num_rows=6;
num_columns=8;
target_label = 5;
for idx = 1:num_rows*num_columns
  % x, D, target_label, x_noisy
  x = Xtest(:, idx);
  x_adv = find_adversarial_example(x, D, target_label)
  % e(:, idx) = (x_adv-x)/255;
  test_noisy(:, idx) = x_adv;
end

noisy_classifier_labels = get_simple_classifier_labels(double(test_noisy)'/255, ...
                                                 Dt);
classifier_labels = get_simple_classifier_labels(double(test)'/255, ...
                                                 Dt);

f2 = figure(2);
view_images(test_noisy, noisy_classifier_labels, testlabels, ...
            num_rows, num_columns, 'Classifier Labels on Perturbed Images');

f3 = figure(3);
view_images(test, testlabels, testlabels, ...
            num_rows, num_columns, 'Original Labels');

f4 = figure(4);
view_images(test, classifier_labels, testlabels, ...
            num_rows, num_columns, 'Classifier Labels on Original Images');

% f5 = figure(5);
% view_errors(e, testlabels, num_rows, num_columns, 99.5, ...
%             ['Perturbations in 0-1 pixel intensity, fractional, ' ...
%              'maximum capped at 99.5 percentile perturbation']);
% 
% f6 = figure(6);
% view_errors(round(255*e), testlabels, num_rows, num_columns, 100, ...
%             ['Perturbations in 0-255 pixel intensity, integral, ' ...
%              'maximum capped at actual max perturbation']);

% f7 = figure(7);
% cdfplot(enorm);
% hold on;
% cdfplot(emax);
% legend('Norm','Maximum','Location','NW');
% hold off;
         
default_position = [100, 100, 1200, 900];
for f=[f2, f3, f4, f5, f6]
  set(f, 'Position', default_position)
end