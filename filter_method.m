function [approx,detail] = filter_method(y,b_LPF,b_HPF)
Y_approx = filter(b_LPF,[1],y);
Y_detail = filter(b_HPF,[1],y);

approx = downsample(Y_approx,2);
detail = downsample(Y_detail,2);

end