
%read the files
filename = '607946-392-1.wav';
[y,Fs]= audioread(filename);

%filter paramethers
b_LPF=[-0.01060, 0.03288, 0.03084, -0.18703, -0.02798, 0.63088, 0.71485, 0.23038];
b_HPF=[0.23038, -0.71485, 0.63088, 0.02798, -0.18703, -0.03084, 0.03288, 0.01060];
b_LPF_g = [0.23038, 0.71485, 0.63088, -0.02798, -0.18703, 0.03084, 0.03288, -0.01060];
b_HPF_g = [0.01060, 0.03288, -0.03084, -0.18703,0.02798, 0.63088, -0.71485, 0.23038];

%threshold paramethers
N=100;
sigma = mad(y(1:N))/0.6745;
T = sigma*sqrt(2*log(N));

tic;

%wavelet packet decomposition
%level_1
[approx_1,detail_1] = overlap(y,b_LPF,b_HPF);

%level_2
[approx_21,detail_21] = overlap(approx_1,b_LPF,b_HPF);
[approx_22,detail_22] = overlap(detail_1,b_LPF,b_HPF);

%level_3
[approx_31,detail_31] = overlap(approx_21,b_LPF,b_HPF);
[approx_32,detail_32] = overlap(detail_21,b_LPF,b_HPF);
[approx_33,detail_33] = overlap(approx_22,b_LPF,b_HPF);
[approx_34,detail_34] = overlap(detail_22,b_LPF,b_HPF);

%thresholding 
decomposed = [approx_31,detail_31,approx_32,detail_32,approx_33,detail_33,approx_34,detail_34]';
%decomposed = threshold(decomposed,T,'MH');

approx_21 = overlap_reconstruct(approx_31,detail_31,b_LPF_g,b_HPF_g);
detail_21 = overlap_reconstruct(approx_32,detail_32,b_LPF_g,b_HPF_g);
approx_22 = overlap_reconstruct(approx_33,detail_33,b_LPF_g,b_HPF_g);
detail_22 = overlap_reconstruct(approx_34,detail_34,b_LPF_g,b_HPF_g);

approx_21 = overlap_reconstruct(decomposed(1,:),decomposed(2,:),b_LPF_g,b_HPF_g);
detail_21 = overlap_reconstruct(decomposed(3,:),decomposed(4,:),b_LPF_g,b_HPF_g);
approx_22 = overlap_reconstruct(decomposed(5,:),decomposed(6,:),b_LPF_g,b_HPF_g);
detail_22 = overlap_reconstruct(decomposed(7,:),decomposed(8,:),b_LPF_g,b_HPF_g);


approx_1 = overlap_reconstruct(approx_21,detail_21,b_LPF_g,b_HPF_g);
detail_1 = overlap_reconstruct(approx_22,detail_22,b_LPF_g,b_HPF_g);

y_new_FftOverlapAddMethod_method = overlap_reconstruct(approx_1,detail_1,b_LPF_g,b_HPF_g);

toc;

%play the sound and write it
sound(y_new_FftOverlapAddMethod_method,Fs)
audiowrite('overlap_method.wav',y_new_FftOverlapAddMethod_method,Fs);




