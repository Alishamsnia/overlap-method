function [approx,detail] = overlap(y,b_LPF,b_HPF)

%overlap add method by fft and n=1024
Y_approx = fftfilt(b_LPF,y,1024);
Y_detail = fftfilt(b_HPF,y,1024);

%downsampling
approx = downsample(Y_approx,2);
detail = downsample(Y_detail,2);

end


