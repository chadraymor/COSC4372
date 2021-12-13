% Requires Imaging Processing Toolbox
% Requires Deep Learning Toolbox

% logan 1 is the original image
logan1 = phantom('Modified Shepp-Logan',256);

% Gets the maximum signal value of the original, grayscale image
sMax = max(logan1(:));
fprintf('\n Max Signal Value of Grayscale Image is %0.5f', sMax);

% Pretrained Denoising Convolutional Neural Network
net = denoisingNetwork('DnCNN');

% To change ammount of noise density to apply to the image, change the fourth
% argument. i.e. 0.03 applies noise density of 0.03
% logan2 is the original image with added noise
% logan2 = imnoise(logan1, 'gaussian', 0, 0.03);

hold on
for i = [0.01, 0.05, 0.10, 0.15, 0.30, 0.60, 0.90]
    logan2 = imnoise(logan1, 'gaussian', 0, i);
    
    % Noisy image is denoised by the pretrained network
    logan3 = denoiseImage(logan2, net);
    
    % Displays the original, noisy, and denoised images
    montage({logan1, logan2, logan3}, 'size', [1 NaN]);
    title("logan1: original, logan2: added noise, logan3: denoised");
    figure()
end

hold on
for j = [0.01, 0.05, 0.10, 0.15, 0.30, 0.60, 0.90]
    logan2 = imnoise(logan1, 'gaussian', 0, j);
    
    % Noisy image is denoised by the pretrained network
    logan3 = denoiseImage(logan2, net);
    
    % Calculates peak Signal-to-Noise Ratio and Signal-to-Noise Ratio of
    % Noisy and Denoised images
    [peaksnr, snr] = psnr(logan2, logan3);
    
    % Plots a SNR vs. Noise level graph
    plot(j,snr,'--bo');
    xlabel('Noise Level')
    ylabel('SNR')
    title('SNR vs Noise Level')
    
    % Prints the Peak Signal-to-Noise Ratio and Signal-to-Noise Ratio of
    % Noisy and Denoised images
    fprintf('\n PSNR value is %0.5f', peaksnr);
    fprintf('\n SNR value is %0.5f \n', snr);
end