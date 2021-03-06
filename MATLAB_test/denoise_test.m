% Requires Imaging Processing Toolbox
% Requires Deep Learning Toolbox

% logan 1 is the original image
logan1 = phantom('Modified Shepp-Logan',256);

% Gets the maximum signal value of the original, grayscale image
sMax = max(logan1(:));
fprintf('\n Max Signal Value of Grayscale Image is %0.5f', sMax);

% To change ammount of noise density to apply to the image, change the fourth
% argument. i.e. 0.03 applies noise density of 0.03
% logan2 is the original image with added noise
logan2 = imnoise(logan1, 'gaussian', 0, 0.03);

% Pretrained Denoising Convolutional Neural Network
net = denoisingNetwork('DnCNN');

% Noisy image is denoised by the pretrained network
logan3 = denoiseImage(logan2, net);

% Displays the original, noisy, and denoised images
montage({logan1, logan2, logan3}, 'size', [1 NaN]);
title("logan1: original, logan2: added noise, logan3: denoised");

% Prints the Peak Signal-to-Noise Ratio and Signal-to-Noise Ratio of
% Noisy and Denoised images
[peaksnr, ssnr] = psnr(logan2, logan3);
fprintf('\n PSNR value is %0.5f', peaksnr);
fprintf('\n SNR value is %0.5f \n', ssnr);

