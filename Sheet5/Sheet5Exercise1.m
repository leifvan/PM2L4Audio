% Solutions to Exercise 5.1
% by Lukas Drexler and Leif Van Holland

sampling_rate = 5000;

x = ConcatenateSineWaves([1 5]', [1 1]', [3 3]', sampling_rate);
h = hann(2 * sampling_rate)';

for i=1:length(h):length(x)
    y = x(i:i+length(h)-1);
    wx = y .* h;
    fx = fft(wx);
    n = i:i+length(h)-1;
    n = n / sampling_rate;
    
    plot_idx = floor((i/length(h))*3);
    subplot(3,3,plot_idx+1);
    hold on
    pn = 0:1/sampling_rate:(length(x)-1)/sampling_rate;
    plot(pn,x);
    
    if(plot_idx == 0)
        ph = [h, zeros(size(h)), zeros(size(h))];
    elseif(plot_idx == 3)
        ph = [zeros(size(h)), h, zeros(size(h))];
        ylabel("Amplitude / Magnitude");
    elseif(plot_idx == 6)
        ph = [zeros(size(h)), zeros(size(h)), h];
        xlabel("Time (s)");
    end
    
    plot(pn, ph);
    hold off
    
    subplot(3,3,plot_idx+2);
    plot(n,wx);
    
    if(plot_idx == 6)
        xlabel("Time (s)")
    end
    
    subplot(3,3,plot_idx+3);
    plot((0:length(h)-1)/2,abs(fx));
    xlim([0,20]);
    
    if(plot_idx == 6)
        xlabel("Frequency (Hz)")
    end
end