function [constellationMap] = ExtractPeaks(signal, kappa, tau, winsize)
    S = spectrogram(signal, hann(winsize));
    constellationMap = zeros(size(S));
    for i=1:size(S,1)
        for j=1:size(S,2)
            window = S(max(1,i-kappa):min(size(S,1),i+kappa), max(1,j-tau):min(size(S,2),j+tau));
            window(kappa+1, tau+1) = 0;
            if abs(S(i,j)) > max(abs(window))
                constellationMap(i,j) = 1;
            end
        end
    end
end

