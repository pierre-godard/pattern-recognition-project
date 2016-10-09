
%% Test 1: Finite duration HMM

% Given results
logPTest = -9.1877;

featureSequence = [-0.2 2.6 1.3];
markovChain = MarkovChain([1; 0], [0.9 0.1 0; 0 0.9 0.1]);
gaussian1 = GaussD('Mean', 0, 'StDev', 1);
gaussian2 = GaussD('Mean', 3, 'StDev', 2);
gaussians = [gaussian1; gaussian2];
hmm = HMM(markovChain, gaussians);


logP = logprob(hmm, featureSequence);

assert(isequal(logPTest, round(logP, 4)));
