clear;
load mnistabridged;

D = find_linear_classifier(train, trainlabels, possible_labels);

Xtest=double(test);

num_rows=2;
num_columns=3;
num_samples=num_rows*num_columns;
target_label=0;
for idx = 1:num_samples
  x = Xtest(:, idx);
  x_adv = find_adversarial_example(x, D, target_label)
  e(:, idx) = double(x_adv)-x;
  Xtest_noisy(:, idx) = double(x_adv);
end

noisy_classifier_labels = get_simple_classifier_labels(D, Xtest_noisy);
classifier_labels = get_simple_classifier_labels(D, Xtest);

f2 = figure(2);
view_images(Xtest_noisy, noisy_classifier_labels, testlabels, ...
            num_rows, num_columns, 'Classifier Labels on Perturbed Images');

f3 = figure(3);
view_images(test, testlabels, testlabels, ...
            num_rows, num_columns, 'Original Labels');

f4 = figure(4);
view_images(test, classifier_labels, testlabels, ...
            num_rows, num_columns, 'Classifier Labels on Original Images');

f5 = figure(5);
view_errors(e/255, testlabels, num_rows, num_columns, 99.5, ...
            ['Perturbations in 0-1 pixel intensity, fractional, ' ...
             'maximum capped at 99.5 percentile perturbation']);

f6 = figure(6);
% TODO: In visualization, make number of discrete colors mach number of
% error slots for easier visibility.
view_errors(e, testlabels, num_rows, num_columns, 100, ...
            ['Perturbations in 0-255 pixel intensity, integral, ' ...
             'maximum capped at actual max perturbation']);
         
default_position = [100, 100, 1200, 900];
for f=[f2, f3, f4, f5, f6]
  set(f, 'Position', default_position)
end