function  [samples] = nondetect(X,threshold)

% iuput : X ( sample by some sampling method) , threshold : defalut = 0.03
% output : transformed X 

ind = find(any(X< threshold,2));  % find the index of the row that have value less than threshold
half_point = ceil(length(ind) / 2); % round ; the number of non-detect data
first_half_indices = ind(1:half_point); % non-detect : first 50 percent data is non-detect data
X(first_half_indices, :) = X(first_half_indices, :) .* (X(first_half_indices, :) >= threshold);

samples = X./sum(X,2); % closure