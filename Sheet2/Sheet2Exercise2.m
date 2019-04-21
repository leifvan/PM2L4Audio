% Solutions to Exercise 2.2
% by Lukas Drexler and Leif Van Holland

N = 512;

t = 0:1/N:1;
f = cos(2*pi*4*t) + 4*cos(2*pi*10*t) + 6*cos(2*pi*18*t);

subplot(2,1,1)
stem(t,f)
title("f (time domain)")
ylabel("amplitude")
xlabel("time [sec]")

fhat = 0*t;
fhat(4) = 0.5;
fhat(N-4) = 0.5;
fhat(10) = 2;
fhat(N-10) = 2;
fhat(18) = 3;
fhat(N-18) = 3;

subplot(2,1,2)
stem(t,fhat)
title("f (frequency domain)")
ylabel("magnitude")
xlabel("frequency")