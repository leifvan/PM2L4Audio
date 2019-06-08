function [indicatorFunctions, matchingFunction] = ComputeMatchingFunction(invertedLists,queryConstellation,dataLen)
    [I,J] = ind2sub(size(queryConstellation), find(queryConstellation));
    queryPoints = cat(2,J-1,I);
    queryLen = size(queryConstellation, 2);
    
    indicatorFunctions = zeros(size(queryPoints,1),dataLen+queryLen);
    for i=1:size(queryPoints,1)
        m = queryPoints(i,1);
        k = queryPoints(i,2);
        L = invertedLists(k);
        L = L{1}-m;
        for n=-queryLen+1:dataLen
            if ismember(n,L)
                indicatorFunctions(i,n+queryLen-1) = 1;
            end
        end
    end
    matchingFunction = sum(indicatorFunctions, 1);
end

