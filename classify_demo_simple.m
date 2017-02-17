function classify_demo_simple

load mnistabridged;

% The least squares formulation is Ax = b, where each row 
% of A is an image, and each row of b is a 0 or 1 to say
% whether that image is a 2 (for instance)

possible_labels=0:9;

A = double(train)'/255;
b = double(trainlabels==possible_labels);
x = A\b;

figure(1);
set(gcf, 'Name', 'Images creating maximum activation');
plot_maximum_activation(x, 0.5*[-1 1], getColorPalette('RdBu_r'));

% function classifier_labels = get_simple_classifier_labels(A, x)
%   [~,classifier_labels]= max(A*x,[],2);
% end

Atest = double(test)'/255;
classifier_labels = get_simple_classifier_labels(Atest, x);

fprintf(1,'Score: %d/%d\n',sum(classifier_labels == testlabels), ...
        length(testlabels));

figure(2);
set(gcf, 'Name', 'Images with learned labels');
view_images(test, classifier_labels, testlabels, 6, 8);

end