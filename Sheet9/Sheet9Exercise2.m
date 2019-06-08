% Solutions to Exercise 9.2
% by Lukas Drexler and Leif Van Holland

% read audio files
db1 = audioread("database_1.wav");
db2 = audioread("database_2.wav");
db3 = audioread("database_3.wav");
[query, Fs] = audioread("query.wav");

% get constellation maps
kappa = 3;
tau = 3;
winsize = 2*Fs;
constellation_db1 = ExtractPeaks(db1, kappa, tau, winsize);
constellation_db2 = ExtractPeaks(db2, kappa, tau, winsize);
constellation_db3 = ExtractPeaks(db3, kappa, tau, winsize);
constellation_query = ExtractPeaks(query, kappa, tau, winsize);

% get inverted lists
L_db1 = ComputeInvertedLists(constellation_db1);
L_db2 = ComputeInvertedLists(constellation_db2);
L_db3 = ComputeInvertedLists(constellation_db3);

% compute matching functions
[~, mfn1] = ComputeMatchingFunction(L_db1,constellation_query, size(constellation_db1, 2));
[~, mfn2] = ComputeMatchingFunction(L_db2,constellation_query, size(constellation_db2, 2));
[~, mfn3] = ComputeMatchingFunction(L_db3,constellation_query, size(constellation_db3, 2));

% find matching with maximum value
max_val = zeros(1,3);
max_idx = zeros(1,3);
[max_val(1), max_idx(1)] = max(mfn1);
[max_val(2), max_idx(2)] = max(mfn2);
[max_val(3), max_idx(3)] = max(mfn3);

[~, matched_db_idx] = max(max_val);
"Matching song has index "+matched_db_idx

% song 3 matches the query, calculate start sample and play

start_sample = (max_idx(3)+1)*winsize/2-size(query,1)
sound(db3(start_sample:start_sample+size(query,1)), Fs);