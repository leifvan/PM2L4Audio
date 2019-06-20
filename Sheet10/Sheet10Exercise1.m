% Solutions to Exercise 10.1
% by Lukas Drexler and Leif Van Holland

for p=1:127
    % check if center frequency is calculated correctly
    center_freq = 2^((p-69)/12)*440;
    calculated_p = HertzToMIDIPitch(center_freq);
    assert(p==calculated_p);
    
    % check if frequencies close to bandwidth limit are correct
    eps = 1e-05;
    p_low = p-0.5+eps;
    freq_low = 2^((p_low-69)/12)*440;
    calculated_p_low = HertzToMIDIPitch(freq_low);
    assert(p == calculated_p_low);
    
    p_high = p+0.5-eps;
    freq_high = 2^((p_high-69)/12)*440;
    calculated_p_high = HertzToMIDIPitch(freq_high);
    assert(p == calculated_p_high);
end