original_Image = imread('ctscan.jpg')

if size(original_Image, 3) == 3
    original_Image = rgb2gray(original_Image);
end

noisy_Image =  imnoise(original_Image, 'gaussian', 0, 0.03);

net = denoisingNetwork('DnCNN');
denoised_Image = denoiseImage(noisy_Image, net);

montage({original_Image, noisy_Image, denoised_Image})
title("denoised")