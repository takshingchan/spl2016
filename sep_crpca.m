function sep_crpca(mixture,sisec,k,outDir)
% sep_crpca: Separation using Complex Robust PCA.

%	Tak-Shing Chan, 20150529

[~,name] = fileparts(mixture);
x = load_audio(mixture,sisec,true);

% Perform short-time Fourier transform
X = stft1411(x');

% Complex Robust PCA
[A,E] = inexact_alm_crpca(X,k/sqrt(length(X)),1e-7,1000);
a = istft1411(A)';
audiowrite(fullfile(outDir,[name '_A.wav']),wavnormalize(a),22050);
e = istft1411(E)';
audiowrite(fullfile(outDir,[name '_E.wav']),wavnormalize(e),22050);
