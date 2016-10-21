function [mse] = testHmmMse(hmm, feature_test)
% We consider size(hmm, 2) == size(feature_test, 1)
    
    s = zeros(size(feature_test));
    [nb_word, nb_sample] = size(feature_test);
    nb_hmm = size(hmm, 2);
    
    mse = zeros(nb_hmm, 1);
    
    for i=1:nb_word
        for j=1:nb_sample
            logP = logprob(hmm, feature_test{i, j});
            maxLogP = max(logP);
            prob = exp(logP - maxLogP);
            prob = prob ./ sum(prob);
            prob(1, i) = 1 - prob(1, i);
            prob = prob .^ 2;
            mse(:, 1) = mse(:, 1) + prob';
        end
    end

end
