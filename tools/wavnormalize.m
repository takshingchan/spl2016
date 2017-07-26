function y = wavnormalize(x)
% takshingchan 2015may29.  Added colon for stereo normalization

y = x./(max(abs(x(:)))+1e-4);
