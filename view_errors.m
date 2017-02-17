function view_errors(e, labels, num_rows, num_columns, max_percentile, title_text)
% :param: max_percentile the maximum percentile of error we wish to view

e_flat = reshape(e, [prod(size(e)), 1]);
emax = prctile(e_flat, max_percentile);

for i=1:num_rows*num_columns
  subplot(num_rows, num_columns, i);
  imagesc(reshape(e(:,i),28,28), emax*[-1, 1]);
  colormap(getColorPalette('RdBu_r'));
  title(num2str(labels(i)), 'FontName', 'FixedWidth')
  axis image;
  axis off;
  
  axes('Position', [0.20 0.05 0.70 0.90], 'Visible', 'off');
  colorbar();
  caxis(emax*[-1, 1])
end

suptitle(title_text);
