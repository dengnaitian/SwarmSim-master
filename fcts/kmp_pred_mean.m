function [Mu,Y] = kmp_pred_mean(t,sampleData,N,kh,Kinv,dim)
% mean: k*inv(K+lamda*Sigma)*Y

D=2*dim;

for i=1:N
    % time_drive kernel
%     k(1:D,(i-1)*D+1:i*D)=kernel_extend(t,sampleData(i).t,kh,dim);
    % gaussian kernel
    k(1:D,(i-1)*D+1:i*D)=gaussian_kernel(t,sampleData(i).t,kh,dim);
    for h=1:D
        Y((i-1)*D+h,1)=sampleData(i).mu(h); % [px py ... vx vy ...]'
    end
end
    
Mu=k*Kinv*Y;% [px py ... vx vy ...]'

end

