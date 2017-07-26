function sep_rpca(mixture,sisec,k,outDir)
% sep_rpca: Separation using Robust PCA.

%	Tak-Shing Chan, 20150531

[~,name] = fileparts(mixture);
x = load_audio(mixture,sisec,true);

% Perform short-time Fourier transform
X = stft1411(x');
P = angle(X);

% Robust PCA
[A,E] = inexact_alm_crpca(abs(X),k/sqrt(length(X)),1e-7,1000);
a = istft1411(recon(A,P))';
audiowrite(fullfile(outDir,[name '_A.wav']),wavnormalize(a),22050);
e = istft1411(recon(E,P))';
audiowrite(fullfile(outDir,[name '_E.wav']),wavnormalize(e),22050);
