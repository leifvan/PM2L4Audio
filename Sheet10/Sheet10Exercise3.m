% Solutions to Exercise 10.3
% by Lukas Drexler and Leif Van Holland

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

imagesc(Slog);
axis xy;
colormap(flipud(gray));
xticks(0:8:size(S,2));
xticklabels(0:size(pitches,2));
xlabel("time (sec)");
ylabel("MIDI pitch");
title("log-frequency spectrum");
waitforbuttonpress;

% convert log spectrogram to chromagram
Schroma = zeros(12,size(S,2));
for i=1:128
   Schroma(mod(i-1,12)+1,:) = Schroma(mod(i-1,12)+1,:) + Slog(i,:);
end

imagesc(Schroma);
axis xy;
colormap(flipud(gray));
xticks(0:8:size(S,2));
xticklabels(0:size(pitches,2));
yticks(1:12);
yticklabels({'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'});
xlabel("time (sec)");
ylabel("chroma");
title("chromagram");