function y = overlap_reconstruct(approx,detail,b_LPF,b_HPF)

%upsampling
approx = upsample(approx,2);
detail = upsample(detail,2);

%reconstruct by overlapp add method fft 1024
y_approx = fftfilt(b_LPF,approx,1024);
y_detail = fftfilt(b_HPF,detail,1024);

%sum approximation and detail signals
y = y_approx + y_detail;

end