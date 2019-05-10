% Solutions to Exercise 5.1 (concatenation function)
% by Lukas Drexler and Leif Van Holland

function [signal] = ConcatenateSineWaves(frequencies, amplitudes, durations, sampling_rate)
    signal = [];
    n = [];
    for i = 1:size(frequencies)
        new_n = 0:1/sampling_rate:(durations(i)-1/sampling_rate);
        new_signal = amplitudes(i) * sin(2 * pi * frequencies(i) * new_n);
        if isempty(n)
            n = new_n;
        else
            n = [n, n(end)+new_n];
        end
        signal = [signal, new_signal];
    end
end

