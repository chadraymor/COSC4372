original_Image = imread('ctscan.jpg')

if size(original_Image, 3) == 3 %3 refers to color channels(rgb). this converts image to grayscale if its rgb
    original_Image = rgb2gray(original_Image);
end

noisy_Image =  imnoise(original_Image, 'gaussian', 0, 0.03);%.03 refers to amount of noise added

net = denoisingNetwork('DnCNN');% denoise CNN network
denoised_Image = denoiseImage(noisy_Image, net);

montage({original_Image, noisy_Image, denoised_Image})
title("original, with noise, denoised")