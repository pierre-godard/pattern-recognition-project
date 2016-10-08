
%% Test 1: Finite duration HMM

% Given results
BetaHatTest = [1.0003 1.0393 0; 8.4182 9.3536 2.0822];

c = [1 0.1625 0.8266 0.0581];
featureSequence = [-0.2 2.6 1.3];
markovChain = MarkovChain([1; 0], [0.9 0.1 0; 0 0.9 0.1]);
gaussian1 = GaussD('Mean', 0, 'StDev', 1);
gaussian2 = GaussD('Mean', 3, 'StDev', 2);
gaussians = [gaussian1; gaussian2];

pX = prob(gaussians, featureSequence);

BetaHat = backward(markovChain, pX, c);

assert(isequal(BetaHatTest, round(BetaHat, 4)));

%% Test 2: Infinite duration HMM

% Fast-manually computed results
BetaHatTest = [8.0000 4.0000 2.000; 8.0000 4.0000 2.0000];

c = [0.5000 0.5000 0.5000];
featureSequence = [0 0 0];
markovChain = MarkovChain([0.5; 0.5], [0.5 0.5; 0.5 0.5]);
gaussian1 = GaussD('Mean', 0, 'StDev', 1);
gaussian2 = GaussD('Mean', 0, 'StDev', 1);
gaussians = [gaussian1; gaussian2];

pX = prob(gaussians, featureSequence);

BetaHat = backward(markovChain, pX, c);

assert(isequal(BetaHatTest, round(BetaHat, 4)));
