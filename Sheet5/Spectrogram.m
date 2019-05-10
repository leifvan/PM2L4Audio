% Solutions to Exercise 5.2 (spectrogram function)
% by Lukas Drexler and Leif Van Holland

function [] = Spectrogram(signal, win_length, step_size, win_fn, sampling_rate)
    if win_fn == "rectangular"
        win = ones(1,win_length);
    elseif win_fn == "triangular"
        win = 1 - abs(-win_length/2:win_length/2-1);
    elseif win_fn == "hann"
        win = hann(win_length)';
    end
    
    num_frames = floor((length(signal)-win_length)/step_size);
    values = zeros(win_length,num_frames);
    for p=1:step_size:length(signal)-win_length
       y = signal(p:p+win_length-1);
       wx = y .* win;
       values(:,(p-1)/step_size+1) = fft(wx);
    end
    time =4*step_size:step_size:(num_frames+4)*step_size;
    time = time / sampling_rate;
    freqs = 0:sampling_rate/win_length:sampling_rate/2-1;
    time = time(1:size(values,2));
    
    fig = pcolor(time, freqs ,db(abs(values(1:size(values,1)/2,:)), 'power'));
    set(fig, 'EdgeColor', 'none');
    c = colorbar;
    c.Label.String = 'Power (dB)';
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
end
