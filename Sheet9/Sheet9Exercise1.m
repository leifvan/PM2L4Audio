% Solutions to Exercise 9.1
% by Lukas Drexler and Leif Van Holland

% data from chapter 4, slide 16
D = [1 1 0 1 0 1 0; 0 0 1 0 1 0 0; 1 0 0 1 0 1 0; 0 0 0 1 1 0 0];
Q = [0 0 0; 1 0 1; 0 1 0; 0 1 1];
correct_indfns = [0 0 0 0 1 0 1 0 0 0; 0 1 0 0 1 0 1 0 0 0; 0 0 0 0 1 1 0 0 0 0; 0 0 1 0 1 0 0 0 0 0; 0 0 0 1 1 0 0 0 0 0];
correct_mfn = [0 1 1 1 5 1 2 0 0 0];

% compute indicator and matching function(s)
L = ComputeInvertedLists(D);
[indfns, mfn] = ComputeMatchingFunction(L,Q,7);

% check if our result is equal to correct results
all(correct_indfns == indfns, 'all')
all(correct_mfn == mfn, 'all')
