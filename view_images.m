function view_images(x, assigned_labels, correct_labels, num_rows, ...
                     num_columns, title_text)

for i=1:num_rows*num_columns
  subplot(num_rows, num_columns, i);
  imagesc(reshape(x(:,i),28,28), [0, 255]);
  colormap gray;
  if assigned_labels(i) == correct_labels(i)
    color = '\color{black}';
  else
    color = '\color{red}';
  end
  title(strcat(color, num2str(assigned_labels(i))), 'FontName', 'FixedWidth');
  axis image;
  axis off;
end

suptitle(title_text);