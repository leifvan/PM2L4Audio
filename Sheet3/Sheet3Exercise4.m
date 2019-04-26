% Solutions to Exercise 3.4
% by Lukas Drexler and Leif Van Holland

x = [2 3 -1 1].';
X = CooleyTukey(x)

function X = CooleyTukey(x)
    N = length(x);
    M = N/2;
    halfDFT = zeros(M,M);
    for i = 0:M-1
        for j = 0:M-1
            halfDFT(i+1,j+1) = exp(-2*pi*1j/M)^(i*j);
        end
    end
    
    n = 0:M-1;
    delta = diag(exp(-2*pi*1j*n/N));

    x0 = x(1:2:end);
    x1 = x(2:2:end);
    X0 = halfDFT*x0;
    X1 = halfDFT*x1;
    
    X = zeros(N,1);
    X(1:M) = X0 + delta * X1;
    X(M+1:end) = X0 - delta * X1;
end