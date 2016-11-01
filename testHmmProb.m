function [error] = testHmmProb(hmm, feature_test)
% We consider size(hmm, 2) == size(feature_test, 1)
    
    [nb_word, nb_sample] = size(feature_test);
    nb_hmm = size(hmm, 2);
    
    error = zeros(nb_hmm, 1);
    
    for i=1:nb_word
        for j=1:nb_sample
            logP = logprob(hmm(i), feature_test{i, j});
            error(i, 1) = error(i, 1) + logP';
        end
    end
    
    error(:, 1) = error(:, 1) / nb_sample;

end
