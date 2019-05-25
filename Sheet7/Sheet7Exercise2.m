% Solutions to Exercise 7.2
% by Lukas Drexler and Leif Van Holland

% generate the signal
N = 512;
n = 0:1/N:1-1/N;
a = sin(2*pi*4*n);
r = rand(1,N)-0.5;
b = a + r;

y = DenoiseFilter(b,N,3);

% plot
ax1 = subplot(2,2,1);
plot(n,a)
title("$a$: clean signal",'Interpreter','latex')

ax2 = subplot(2,2,2);
plot(n,b)
title("$b$: noisy signal",'Interpreter','latex')

ax3 = subplot(2,2,3);
plot(n,y)
title("$\tilde{a}$: denoised signal",'Interpreter','latex')

ax4 = subplot(2,2,4);
plot(n,y-a)
title("$\tilde{a}-a$: difference signal",'Interpreter','latex')

ylim([-1.5 1.5])
linkaxes([ax1 ax2 ax3 ax4]);

% create common labels
h1=subplot(2,2,1);
h2=subplot(2,2,2);
h3=subplot(2,2,3);
h4=subplot(2,2,4);
p1=get(h1,'position');
p2=get(h2,'position');
p3=get(h3,'position');
p4=get(h4,'position');
height=p1(2)+p1(4)-p4(2);
width=p4(1)+p4(3)-p3(1);
h5=axes('position',[p3(1) p3(2) width height],'visible','off'); 
ylabel('amplitude','Interpreter','latex','visible','on')
xlabel('$k/N$ (time)','Interpreter','latex','visible','on')

% denoising function
function y = DenoiseFilter(x,fs,half_width)
    % assume only one frequency in original signal
    % use bandpass around detected frequency
    
    % detect
    X = fft(x);
    [~, max_freq] = max(abs(X));
    N = size(x,2);
    if(max_freq > N/2)
        max_freq = N-max_freq;
    end
    
    % apply bandpass
    lowerfreq = (max_freq-1-half_width);
    upperfreq = (max_freq-1+half_width);
    y = bandpass(x', [lowerfreq, upperfreq], fs, 'Steepness',0.95);
    bandpass(x', [lowerfreq, upperfreq], fs, 'Steepness',0.95);
    waitforbuttonpress;
    y = y';
end

