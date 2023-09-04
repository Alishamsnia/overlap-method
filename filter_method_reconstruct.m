function y = filter_method_reconstruct(approx,detail,b_LPF,b_HPF)

approx = upsample(approx,2);
detail = upsample(detail,2);

y_approx = filter(b_LPF,[1],approx);
y_detail = filter(b_HPF,[1],detail);

y = y_approx + y_detail;

end