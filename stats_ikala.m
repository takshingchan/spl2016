function stats_ikala
% stats: Perform t-tests and report significant results.
%
%	Usage: stats_ikala

%	Tak-Shing Chan, 20151029

outDirs = {'SPL2016\iKala\real\1.5','SPL2016\iKala\complex\1.5'};
methods = {'rpca','crpca'};
files = importdata('ikala.txt','\n');

% Load GNSDR, NSDR, GSIR, and GSAR
GNSDR = zeros(2,length(methods));
GSDR = GNSDR;
GSIR = GNSDR;
GSAR = GNSDR;
NSDRs = zeros(2,length(methods),length(files));
SIRs = NSDRs;
SARs = NSDRs;
for n = 1:length(methods)
    for m = 1:length(files)
        load(fullfile(outDirs{n},[files{m} '.mat']));
        NSDRs(:,n,m) = NSDR;
        SDRs(:,n,m) = SDR;
        SIRs(:,n,m) = SIR;
        SARs(:,n,m) = SAR;
    end
    GNSDR(:,n) = mean(NSDRs(:,n,:),3);
    GSDR(:,n) = mean(SDRs(:,n,:),3);
    GSIR(:,n) = mean(SIRs(:,n,:),3);
    GSAR(:,n) = mean(SARs(:,n,:),3);
end

% Report significant results
if ttest(NSDRs(1,2,:),NSDRs(1,1,:),[],'right')
    disp('NSDR (E): Complex > Real');
end
if ttest(NSDRs(2,2,:),NSDRs(2,1,:),[],'right')
    disp('NSDR (A): Complex > Real');
end
if ttest(SDRs(1,2,:),SDRs(1,1,:),[],'right')
    disp('SDR (E): Complex > Real');
end
if ttest(SDRs(2,2,:),SDRs(2,1,:),[],'right')
    disp('SDR (A): Complex > Real');
end
if ttest(SIRs(1,2,:),SIRs(1,1,:),[],'right')
    disp('SIR (E): Complex > Real');
end
if ttest(SIRs(2,2,:),SIRs(2,1,:),[],'right')
    disp('SIR (A): Complex > Real');
end
if ttest(SARs(1,2,:),SARs(1,1,:),[],'right')
    disp('SAR (E): Complex > Real');
end
if ttest(SARs(2,2,:),SARs(2,1,:),[],'right')
    disp('SAR (A): Complex > Real');
end
