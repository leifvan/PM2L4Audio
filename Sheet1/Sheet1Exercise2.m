% Solutions to Exercise 1.2
% by Lukas Drexler and Leif Van Holland

SAMPLING_RATE = 44100; % samples / second (Hz)
FREQ = 1000; % in Hz
DURATION = 1; % in seconds

% create sine and cosine wave
n = 0:1/SAMPLING_RATE:1;
x_sin = sin(FREQ*2*pi*n);
x_cos = cos(FREQ*2*pi*n);

% create a plot with two spectrograms
subplot(1,2,1);
spectrogram(x_sin,[],[],[],SAMPLING_RATE, 'yaxis')
subplot(1,2,2);
spectrogram(x_cos,[],[],[],SAMPLING_RATE, 'yaxis')

% export to audio file
audiowrite('signal.wav', x_sin, SAMPLING_RATE)
