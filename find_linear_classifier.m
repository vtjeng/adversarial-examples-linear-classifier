function D = find_linear_classifier(X, Y, possible_labels)
    Xt=double(X)';
    % For R2016b and later
    % Yt=double(trainlabels == possible_labels);
    % In MATLAB R2016a and earlier, you need to explicitly specify that you
    % want implicit expansion enabled
    Yt=double(bsxfun(@eq, Y, possible_labels));
    % Create linear classifier Dt. (Note that we have no guarantees that Dt is
    % the optimal classifier that minimizes the number of misclassifications,
    % but this is not critical for demonstrating adversarial examples).
    Dt=Xt\Yt;

    D = Dt';
end