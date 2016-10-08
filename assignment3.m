%
%  Pattern Recognition (EQ2340) - Assignment 3
%  Code authors:
%    Corentin Abgrall
%    Pierre Godard
%
%%
% This file run some test scripts you can found in the folder tests.
% Please add the test folder to your path before running this script.
%
%%
%
result = runtests('forwardAlgorithm');
result = [result runtests('probabilityFeatureSequence')];
result = [result runtests('backwardAlgorithm')];
disp(table(result));
