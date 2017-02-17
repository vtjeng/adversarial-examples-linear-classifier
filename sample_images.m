function sample_images

load mnistabridged.mat;

figure(2);
set(gcf, 'Name', 'Images with correct labels');
view_images(train, trainlabels, trainlabels, 6, 8);