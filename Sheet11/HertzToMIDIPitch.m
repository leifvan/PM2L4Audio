% Solutions to Exercise 10.1
% by Lukas Drexler and Leif Van Holland

function [pitch] = HertzToMIDIPitch(frequency)
    % calculate pitch value algebraically
    pitch = 12*log2((4/55) * 2^(3/4) * frequency);
    pitch = round(pitch);
end

