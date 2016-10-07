
%% Test 1: Finite duration HMM

% Given results
AlfaHatTest = [1.0000 0.3847 0.4189; 0 0.6153 0.5811];
cTest = [1.0000 0.1625 0.8266 0.0581];

featureSequence = [-0.2 2.6 1.3];
markovChain = MarkovChain([1; 0], [0.9 0.1 0; 0 0.9 0.1]);
gaussian1 = GaussD('Mean', 0, 'StDev', 1);
gaussian2 = GaussD('Mean', 3, 'StDev', 2);
gaussians = [gaussian1; gaussian2];

pX = prob(gaussians, featureSequence);

[AlfaHat, c] = forward(markovChain, pX);

assert(isequal(AlfaHatTest, round(AlfaHat, 4)));
assert(isequal(cTest, round(c, 4)));

%% Test 2: Infinite duration HMM

% Fast-manually computed results
AlfaHatTest = [0.5000 0.5000 0.5000; 0.5000 0.5000 0.5000];
cTest = [1.0000 1.0000 1.0000];

featureSequence = [0 0 0];
markovChain = MarkovChain([0.5; 0.5], [0.5 0.5; 0.5 0.5]);
gaussian1 = GaussD('Mean', 0, 'StDev', 1);
gaussian2 = GaussD('Mean', 0, 'StDev', 1);
gaussians = [gaussian1; gaussian2];

pX = prob(gaussians, featureSequence);

[AlfaHat, c] = forward(markovChain, pX);

assert(isequal(AlfaHatTest, round(AlfaHat, 4)));
assert(isequal(cTest, round(c, 4)));
