function go(action,method)
% go: Run experiments.
%
% Usage: go(action,method) performs action:
%	'separation'  - Audio separation
%       'report'      - Report results
%
% using method:
%	'rpca_ikala'  - Robust PCA (iKala)
%	'rpca_sisec'  - Robust PCA (SiSEC)
%	'crpca_ikala' - Complex Robust PCA (iKala)
%	'crpca_sisec' - Complex Robust PCA (SiSEC)
%	'qrpca_sisec' - Quaternionic Robust PCA (SiSEC)

%	Tak-Shing Chan, 20150625

addpath qtfm tools;

krange = [1.5 3];

switch method
    case 'rpca_ikala'
        label = 'Real (k = #)';
        separator = @sep_rpca;
        evaluator = @eval_ikala;
        files = importdata('ikala.txt','\n');
        mixtures = 'Datasets\iKala\Wavfile\*.wav';
        sources = 'Datasets\iKala\Wavfile\*.wav';
        outDirs = 'SPL2016\iKala\real\#';
        outName = '*';
        sisec = false;
    case 'rpca_sisec'
        label = 'Real (k = #)';
        separator = @sep_rpca;
        evaluator = @eval_sisec;
        files = importdata('sisec.txt','\n');
        mixtures = 'Datasets\MSD100\Mixtures\*\mixture.wav';
        sources = 'Datasets\MSD100\Sources\*';
        outDirs = 'SPL2016\SiSEC\real\#\*';
        outName = 'mixture';
        sisec = true;
    case 'crpca_ikala'
        label = 'Complex (k = #)';
        separator = @sep_crpca;
        evaluator = @eval_ikala;
        files = importdata('ikala.txt','\n');
        mixtures = 'Datasets\iKala\Wavfile\*.wav';
        sources = 'Datasets\iKala\Wavfile\*.wav';
        outDirs = 'SPL2016\iKala\complex\#';
        outName = '*';
        sisec = false;
    case 'crpca_sisec'
        label = 'Complex (k = #)';
        separator = @sep_crpca;
        evaluator = @eval_sisec;
        files = importdata('sisec.txt','\n');
        mixtures = 'Datasets\MSD100\Mixtures\*\mixture.wav';
        sources = 'Datasets\MSD100\Sources\*';
        outDirs = 'SPL2016\SiSEC\complex\#\*';
        outName = 'mixture';
        sisec = true;
    case 'qrpca_sisec'
        label = 'Quaternion (k = #)';
        separator = @sep_qrpca;
        evaluator = @eval_sisec;
        files = importdata('sisec.txt','\n');
        mixtures = 'Datasets\MSD100\Mixtures\*\mixture.wav';
        sources = 'Datasets\MSD100\Sources\*';
        outDirs = 'SPL2016\SiSEC\quaternion\#\*';
        outName = 'mixture';
        sisec = true;
    otherwise
        error('method not implemented');
end

switch action
    case 'separation'
        % Separate all files
        for k = krange
            disp(strrep(label,'#',num2str(k)));
            for m = 1:length(files)
                disp(['Separating ' files{m} '...']);
                mixture = strrep(mixtures,'*',files{m});
                source = strrep(sources,'*',files{m});
                outDir = strrep(strrep(outDirs,'#',num2str(k)),'*',files{m});
                [~,~] = mkdir(outDir);
                separator(mixture,sisec,k,outDir);
                evaluator(source,outDir);
            end
        end
    case 'report'
        % Report GNSDR, GSDR, GISR, GSIR, and GSAR
        NSDRs = zeros(2,length(files));
        SDRs = NSDRs;
        ISRs = NSDRs;
        SIRs = NSDRs;
        SARs = NSDRs;
        ISR = NaN(2,1); % because iKala is mono
        for k = krange
            disp(strrep(label,'#',num2str(k)));
            for m = 1:length(files)
                outDir = strrep(strrep(outDirs,'#',num2str(k)),'*',files{m});
                evalName = strrep(outName,'*',files{m});
                load(fullfile(outDir,[evalName '.mat']));
                NSDRs(:,m) = NSDR;
                SDRs(:,m) = SDR;
                ISRs(:,m) = ISR;
                SIRs(:,m) = SIR;
                SARs(:,m) = SAR;
            end
            disp([mean(NSDRs,2) mean(SDRs,2) mean(ISRs,2) mean(SIRs,2) mean(SARs,2)]);
        end
    otherwise
        error('action not implemented');
end
