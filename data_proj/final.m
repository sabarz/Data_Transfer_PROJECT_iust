clc
clear
% initial part 
rgbimage = imread("rgbpic.jpg")
imshow(rgbimage)

% part 3 & 4 (rgb to grayscale)
grayImage = rgb2gray(rgbimage)
imshow(grayImage)
imwrite(grayImage , "gray.png" , "png")

% part 5
gray_double = double(grayImage)
energy = sum(gray_double(:).^2)
fprintf("energy --> %f\n" , energy)

% part 6
variance = 0.01
noisy_image = imnoise(grayImage , 'gaussian' , 0 , variance)
imshow(noisy_image)
% part 6 - B
noisy_double = double(noisy_image)
SNR = snr(noisy_double , noisy_double - gray_double)
fprintf("SNR --> %f" , SNR)


% part 7
abs_ff2_noisy_image = abs(fft2(im2double(noisy_image)))
ft = fftshift(log(abs_ff2_noisy_image))
imshow(ft ,[])


% part 8
denoised_image = medfilt2(noisy_image)
imshow(denoised_image)
imwrite(denoised_image , 'denoised_image.png')
psnr1 = psnr(noisy_image , grayImage)
psnr2 = psnr(denoised_image , grayImage)

fprintf('PSNR before adding noise --> %f\n' ,psnr1)
fprintf('PSNR after adding noise --> %f\n' , psnr2)

% another denoising approach
filterKernel = fspecial("average" , 5)
denoised_image2 = imfilter(noisy_image , filterKernel)
imshow(denoised_image2)
imwrite(denoised_image2 , "denoised_image2.png")


psnr1_b = psnr(noisy_image , grayImage)
psnr2_b = psnr(denoised_image2 , grayImage)

fprintf('PSNR before adding noise --> %f\n' ,psnr1_b)
fprintf('PSNR after adding noise --> %f\n' , psnr2_b)


% final result

subplot(1 , 5 , 1) ,title("original image"),imshow(rgbimage)
subplot(1 , 5 , 2) , title("gray scaled image") ,imshow(grayImage)
subplot(1 , 5 , 3) , title("noisy image") ,imshow(noisy_image)
subplot(1 , 5 , 4) ,title("denoised image of first algorithm") ,imshow(denoised_image)
subplot(1 , 5 , 5),title("denoised image of second algorithm"),imshow(denoised_image2)


















