function eval_sisec(source,outDir)
% eval_sisec: SiSEC evaluation.

%	Tak-Shing Chan, 20150609

s1 = load_audio(fullfile(source,'bass.wav'),true,false);
s2 = repmat(s1,[1,3-size(s1,2)]);
s1 = load_audio(fullfile(source,'drums.wav'),true,false);
s2 = s2+repmat(s1,[1,3-size(s1,2)]);
s1 = load_audio(fullfile(source,'other.wav'),true,false);
s2 = s2+repmat(s1,[1,3-size(s1,2)]);
s1 = load_audio(fullfile(source,'vocals.wav'),true,false);
s1 = repmat(s1,[1,3-size(s1,2)]);
s12 = [s1(:,1)';s2(:,1)'];
s12 = cat(3,s12,[s1(:,2)';s2(:,2)']);
x = s2+s1;
xx = [x(:,1)';x(:,1)'];
xx = cat(3,xx,[x(:,2)';x(:,2)']);

% Load separation results
se1 = audioread(fullfile(outDir,'mixture_E.wav'));
se1 = repmat(se1,[1,3-size(se1,2)]);
se1 = [se1;zeros(length(s1)-length(se1),2)];
se2 = audioread(fullfile(outDir,'mixture_A.wav'));
se2 = repmat(se2,[1,3-size(se2,2)]);
se2 = [se2;zeros(length(s2)-length(se2),2)];
se12 = [se1(:,1)';se2(:,1)'];
se12 = cat(3,se12,[se1(:,2)';se2(:,2)']);

% Normalize to prevent artificial boosting
[SDR,ISR,SIR,SAR] = bss_eval_images(se12/norm(mean(sum(se12),3)),s12/norm(mean(sum(s12),3)));
[NSDR,NISR,NSIR,NSAR] = bss_eval_images(xx/norm(mean(sum(xx),3)),s12/norm(mean(sum(s12),3)));
NSDR = SDR-NSDR;
NISR = ISR-NISR;
NSIR = SIR-NSIR;
NSAR = SAR-NSAR;
save(fullfile(outDir,'mixture.mat'),'SDR','ISR','SIR','SAR','NSDR','NISR','NSIR','NSAR');
