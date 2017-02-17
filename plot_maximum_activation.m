function plot_maximum_activation(x, x_range, color_palette)
% @param x is a 784*10 matrix of the (appropriately) scaled
%   'images' generating the greatest response for each digit from 1
%   to 10
% @param range of x values to be plotted
% @param color palette to be used; can either be MATLAB default name or matrix
for k = 0:9
  subplot(2,5,k+1);
  imagesc(reshape(x(:,k+1),28,28), x_range);
  colormap(color_palette);
  title('k = '+string(k))
  axis image;
  axis off;
  drawnow;
end
end