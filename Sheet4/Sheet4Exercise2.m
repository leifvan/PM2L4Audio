% Solutions to Exercise 4.2
% by Lukas Drexler and Leif Van Holland

% generate the signal
N = 512;
n = 0:1/N:1-1/N;
a = sin(2*pi*4*n);
r = rand(1,N)-0.5;

% get noise threshold from spectrum of r
R_max = max(abs(fft(r)));
theta = R_max*1.1;

b = a + r;
y = Denoise(b,theta);

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
function y = Denoise(x, theta)
    X = fft(x);
    X(abs(X)<theta) = 0;
    y = ifft(X);
end

