function [path] = CalcOptimalWarp(X,Y)
    %calculate C and D
    C = zeros(length(X),length(Y));
    D = zeros(length(X),length(Y));
    for i=1:length(X)
        for j=1:length(Y)
            C(i,j) = abs(X(i)-Y(j));
            if i == 1 && j == 1
                D(1,1) = C(1,1);
            elseif i == 1
                D(1,j) = D(1,j-1) + C(1,j);
            elseif j == 1
                D(i,1) = D(i-1,1) + C(i,1);
            else
                D(i,j) = min([D(i-1,j),D(i,j-1),D(i-1,j-1)]) + C(i,j);
            end
        end
    end

    l = 1;
    n = length(X);
    m = length(Y);

    path = [];
    path(1,1:2) = [n,m];
    while ~(n == 1 && m == 1)
        l = l + 1;
        if n == 1
            m = m-1;
        elseif m == 1
            n = n-1;
        else
            [~, i] = min([D(n-1,m),D(n,m-1),D(n-1,m-1)]);
            if i == 1 || i == 3
                n = n-1;
            end
            if i == 2 || i == 3
                m = m-1;
            end
        end
        path(l,1:2) = [n,m];
    end
end

