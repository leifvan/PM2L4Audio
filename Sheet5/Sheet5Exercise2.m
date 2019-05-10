% Solutions to Exercise 5.2
% by Lukas Drexler and Leif Van Holland

sampling_rate = 5000;
n = 0:1/sampling_rate:3-1/sampling_rate;

x = ConcatenateSineWaves([1000,200]',[1,2]',[1,2]',sampling_rate);
x = x + ConcatenateSineWaves([50,1600]',[2,5]',[2,1]',sampling_rate);

plot(x);
subplot(3,1,1);
Spectrogram(x, 500, 100, 'rectangular', sampling_rate);
title("rectangular window")
subplot(3,1,2);
Spectrogram(x, 500, 100, 'triangular', sampling_rate);
title("triangular window")
subplot(3,1,3);
Spectrogram(x, 500, 100, 'hann', sampling_rate);
title("hann window")