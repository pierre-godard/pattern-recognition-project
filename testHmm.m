function [s] = testHmm(hmm, feature_test)
% Run the HMMs on the test features to determine which one does match the
% best.
%

    s = zeros(size(feature_test));
    [nb_word, nb_sample] = size(feature_test);
    
    for i=1:nb_word
        for j=1:nb_sample
            logP = logprob(hmm, feature_test{i, j});
            [~, s(i,j)] = max(logP);
        end
    end

end