function [A,E,iter] = inexact_alm_crpca(X,lambda,tol,maxiter)
%% inexact_alm_crpca.m
% Complex Robust Principal Component Analysis
%   solve min |A|_*+lambda|E|_1 s.t. X = A+E
%   using the inexact augmented Lagrangian method (IALM)
% ----------------------------------
% Tak-Shing Chan 16-Jul-2015
% takshingchan@gmail.com
% Copyright: Music and Audio Computing Lab, Academia Sinica, Taiwan
%%

[m,n] = size(X);

% initialization
A = zeros(m,n);
X_2 = svds(X,1,'L');
X_inf = norm(X(:),inf);
X_fro = norm(X(:));

% parameters from Lin et al. (2009; can be tuned)
mu = 1.25/X_2;
Y = X/max(X_2,X_inf/lambda);
rho = 1.5;

for iter = 1:maxiter
    %% update E
    E = X-A+Y/mu;
    E = max(1-(lambda/mu)./abs(E),0).*E;

    %% update A
    [U,S,V] = svd(X-E+Y/mu,'econ');
    S = diag(S)-1/mu;
    r = length(find(S>0));
    A = U(:,1:r)*diag(S(1:r))*V(:,1:r)';

    R = X-A-E;

    Y = Y+mu*R;
    mu = rho*mu;

    %% check for convergence
    if norm(R(:))/X_fro<tol
        return
    end
end
disp('Maximum iterations exceeded');
