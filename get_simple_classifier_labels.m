function classifier_labels = get_simple_classifier_labels(A, x)
  [~,index]= max(A*x,[],2);
  classifier_labels = index - 1;
end