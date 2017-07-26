function stats_sisec
% stats_sisec: Perform t-tests and report significant results.
%
%	Usage: stats_sisec

%	Tak-Shing Chan, 20151029

outDirs = {'SPL2016\SiSEC\real\3\*','SPL2016\SiSEC\complex\3\*','SPL2016\SiSEC\quaternion\3\*'};
methods = {'rpca','crpca','qrpca'};
files = importdata('sisec.txt','\n');

% Load GNSDR, NSDR, GISR, GSIR, and GSAR
GNSDR = zeros(2,length(methods));
GSDR = GNSDR;
GISR = GNSDR;
GSIR = GNSDR;
GSAR = GNSDR;
NSDRs = zeros(2,length(methods),length(files));
ISRs = NSDRs;
SIRs = NSDRs;
SARs = NSDRs;
for n = 1:length(methods)
    for m = 1:length(files)
        outDir = strrep(outDirs{n},'*',files{m});
        load(fullfile(outDir,'mixture.mat'));
        NSDRs(:,n,m) = NSDR;
        SDRs(:,n,m) = SDR;
        ISRs(:,n,m) = ISR;
        SIRs(:,n,m) = SIR;
        SARs(:,n,m) = SAR;
    end
    GNSDR(:,n) = mean(NSDRs(:,n,:),3);
    GSDR(:,n) = mean(SDRs(:,n,:),3);
    GISR(:,n) = mean(ISRs(:,n,:),3);
    GSIR(:,n) = mean(SIRs(:,n,:),3);
    GSAR(:,n) = mean(SARs(:,n,:),3);
end

% Bonferroni correction
alpha = 0.05/2;

% Report significant results
if ttest(NSDRs(1,2,:),NSDRs(1,1,:),alpha,'right')
    disp('NSDR (E): Complex > Real');
end
if ttest(NSDRs(2,2,:),NSDRs(2,1,:),alpha,'right')
    disp('NSDR (A): Complex > Real');
end
if ttest(SDRs(1,2,:),SDRs(1,1,:),alpha,'right')
    disp('SDR (E): Complex > Real');
end
if ttest(SDRs(2,2,:),SDRs(2,1,:),alpha,'right')
    disp('SDR (A): Complex > Real');
end
if ttest(ISRs(1,2,:),ISRs(1,1,:),alpha,'right')
    disp('ISR (E): Complex > Real');
end
if ttest(ISRs(2,2,:),ISRs(2,1,:),alpha,'right')
    disp('ISR (A): Complex > Real');
end
if ttest(SIRs(1,2,:),SIRs(1,1,:),alpha,'right')
    disp('SIR (E): Complex > Real');
end
if ttest(SIRs(2,2,:),SIRs(2,1,:),alpha,'right')
    disp('SIR (A): Complex > Real');
end
if ttest(SARs(1,2,:),SARs(1,1,:),alpha,'right')
    disp('SAR (E): Complex > Real');
end
if ttest(SARs(2,2,:),SARs(2,1,:),alpha,'right')
    disp('SAR (A): Complex > Real');
end
if ttest(NSDRs(1,3,:),NSDRs(1,2,:),alpha,'right')
    disp('NSDR (E): Quaternion > Complex');
end
if ttest(NSDRs(2,3,:),NSDRs(2,2,:),alpha,'right')
    disp('NSDR (A): Quaternion > Complex');
end
if ttest(SDRs(1,3,:),SDRs(1,2,:),alpha,'right')
    disp('SDR (E): Quaternion > Complex');
end
if ttest(SDRs(2,3,:),SDRs(2,2,:),alpha,'right')
    disp('SDR (A): Quaternion > Complex');
end
if ttest(ISRs(1,3,:),ISRs(1,2,:),alpha,'right')
    disp('ISR (E): Quaternion > Complex');
end
if ttest(ISRs(2,3,:),ISRs(2,2,:),alpha,'right')
    disp('ISR (A): Quaternion > Complex');
end
if ttest(SIRs(1,3,:),SIRs(1,2,:),alpha,'right')
    disp('SIR (E): Quaternion > Complex');
end
if ttest(SIRs(2,3,:),SIRs(2,2,:),alpha,'right')
    disp('SIR (A): Quaternion > Complex');
end
if ttest(SARs(1,3,:),SARs(1,2,:),alpha,'right')
    disp('SAR (E): Quaternion > Complex');
end
if ttest(SARs(2,3,:),SARs(2,2,:),alpha,'right')
    disp('SAR (A): Quaternion > Complex');
end
