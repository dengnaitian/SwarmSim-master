function [kernelMatrix] = gaussian_kernel(ta,tb,h,dim)
% this file is used to generate a kernel value
% this kernel considers the 'dim-' pos and 'dim-' vel

%% callculate different kinds of kernel
kt_t=exp(-h*(ta-tb)*(ta-tb)); % k(ta,tb)

kernelMatrix=zeros(2*dim,2*dim);
D = dim*2;
for i=1:D
    kernelMatrix(i,i)=kt_t;
end

end