% Solutions to Exercise 11.2
% by Lukas Drexler and Leif Van Holland

l = 3;  % length of smoothing window
d = 3;   % downsampling factor
epsilon = 0.1; % threshold for normalization

% use the same signal as in exercise 10.3

% generate signal (D5, A6, D6, E5, B6, D6, D5, F6, C6)
pitches = [ 74 93 86 76 95 86 74 89 84 ];
freqs = 2.^((pitches-69)/12)*440;

% choose 2*F(127) as sampling rate
fs = ceil(2^((127-69)/12+1)*440);

x = 0:1/fs:length(pitches)-1/fs;
y = zeros('like',x);
for i=1:length(pitches)
    "from "+((i-1)*fs+1)+" to "+(i*fs);
    y((i-1)*fs+1:(i*fs)) = sin(2*pi*freqs(i)*(0:1/fs:1-1/fs));
end

% add some noise
y = y + 0.1*rand(1,length(y));

% get linear spectrogram
[S,w,t] = spectrogram(y,hann(fs/4),fs/8,[],fs);
S = abs(S).^2; % get magnitudes

% convert spectrogram into log
Slog = zeros(128,size(S,2));

for i=2:size(S,1)
   p = HertzToMIDIPitch(w(i));
   if (0 <= p) && (p <= 127)
       Slog(p+1,:) = Slog(p+1,:) + S(i,:);
   end
end

% convert log spectrogram to chromagram
Schroma = zeros(12,size(S,2));
for i=1:128
   Schroma(mod(i-1,12)+1,:) = Schroma(mod(i-1,12)+1,:) + Slog(i,:);
end

% ----- start calculation of CENS ------

norm_Schroma = zeros(12,size(S,2));

% Normalize vectors
for i=1:size(S,2)
    norm_val = norm(Schroma(:,i));
    if norm_val > epsilon
        norm_Schroma(:,i) = Schroma(:,i) ./ norm_val;
    else
        norm_Schroma(:,i) = 1;
        norm_Schroma(:,i) = norm_Schroma(:,i) ./ norm(norm_Schroma(:,i));
    end
end

% Step 1: Quantize
% 0: [0,0.05) 1: [0.05,0.1) 2: [0.1, 0.2) 3: [0.2, 0.4) 4: [0.4, 1]
quant_Schroma = zeros(12, size(S,2));

quantize_limits = [0.05, 0.1, 0.2, 0.4, inf];
for i=1:length(norm_Schroma)
    for j=1:length(quantize_limits)
        if norm_Schroma(i) < quantize_limits(j)
            quant_Schroma(i) = j-1;
            break
        end
    end
end

% Step 2: Smooth
smooth_Schroma = zeros(12, size(S,2));
for i=1:12
    smooth_Schroma(i,:) = conv(norm_Schroma(i,:), hann(l), 'same');
end

% Step 3: Downsample
CENS = smooth_Schroma(:,1:d:end);

% Plot CENS
names = {'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
axs = [];
for i=1:12
    axs(i) = subplot(12,1,12-i+1);
    hold on
    bar(0:d/8:(size(S,2)-1)/8, CENS(i,:))
    plot(0:1/8:(size(S,2)-1)/8,norm_Schroma(i,:))
    hold off
    ylim([0,1])
    ylabel(names(i))
    if i ~= 1
        xticks([])
    else
        xlabel('time (s)')
    end
end
title("CENS of node sequence D5, A6, D6, E5, B6, D6, D5, F6, C6")