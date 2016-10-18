function [s] = testHmm(hmm, data_test, data_length)

s = zeros(size(data_length));
nb_word = size(data_length, 1);
nb_sample = size(data_length, 2);

for j=1:nb_sample
    offset = 0;
    for i=1:nb_word
        logP = logprob(hmm,data_test{i} ... 
            (:,offset + 1:data_length(i,j) + offset));
        [~,s(i,j)] = max(logP);
    end
    offset = offset + data_length(i,j);
end

end