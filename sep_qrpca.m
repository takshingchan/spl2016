function sep_qrpca(mixture,sisec,k,outDir)
% sep_qrpca: Separation using Quaternionic Robust PCA.

%	Tak-Shing Chan, 20150529

[~,name] = fileparts(mixture);
x = load_audio(mixture,sisec,false);

% Perform short-time Fourier transforms
X1 = stft1411(x(:,1)');
X2 = stft1411(x(:,2)');

% Quaternionic Robust PCA
[A,E] = inexact_alm_qrpca(quaternion(real(X1),imag(X1),real(X2),imag(X2)),k/sqrt(length(X1)),1e-7,1000);
a = [istft1411(complex(A.w,A.x))' istft1411(complex(A.y,A.z))'];
audiowrite(fullfile(outDir,[name '_A.wav']),wavnormalize(a),22050);
e = [istft1411(complex(E.w,E.x))' istft1411(complex(E.y,E.z))'];
audiowrite(fullfile(outDir,[name '_E.wav']),wavnormalize(e),22050);
