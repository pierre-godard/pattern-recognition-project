%
%  Pattern Recognition (EQ2340) - Assignment 3
%  Code authors:
%    Corentin Abgrall
%    Pierre Godard
%
%% A.3.1 - The Forward Algorithm - Verify the implementation
%%
%

result = runtests('forwardAlgorithm');
disp(table(result));

%% A.3.1 - The Forward Algorithm - Probability of a feature sequence
%%
%

result = runtests('probabilityFeatureSequence');
disp(table(result));

%% A.3.2 - The Backward Algorithm - Verify the implementation
%%
%

