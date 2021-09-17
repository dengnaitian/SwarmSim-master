function model = init_GMM_distanceBased(Data, model)
% This function initializes the parameters of a Gaussian Mixture Model
% (GMM) by splitting the data into equal bins (time-based clustering).
% Inputs -----------------------------------------------------------------
%   o Data:     D x N array representing N datapoints of D dimensions.
%   o nbStates: Number K of GMM components.
% Outputs ----------------------------------------------------------------
%   o Priors:   1 x K array representing the prior probabilities of the
%               K GMM components.
%   o Mu:       D x K array representing the centers of the K GMM components.
%   o Sigma:    D x D x K array representing the covariance matrices of the
%               K GMM components.


[nbVar, nbData] = size(Data);
%diagRegularizationFactor = 1E-2; %Optional regularization term
diagRegularizationFactor = 1E-8; %Optional regularization term

TimingSep = linspace(min(Data(2,:)), max(Data(2,:)), model.nbStates+1);

for i=1:model.nbStates
	idtmp = find( Data(2,:)>=TimingSep(i) & Data(2,:)<TimingSep(i+1));
	model.Priors(i) = length(idtmp);
	model.Mu(:,i) = mean(Data(:,idtmp)');
	model.Sigma(:,:,i) = cov(Data(:,idtmp)');
	%Optional regularization term to avoid numerical instability
	model.Sigma(:,:,i) = model.Sigma(:,:,i) + eye(nbVar)*diagRegularizationFactor;
end
model.Priors = model.Priors / sum(model.Priors);
