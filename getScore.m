% Return the error rate
function [s] = getScore(confusionMatrix)

nWord = size(confusionMatrix,1);

prod = ones(nWord) - eye(nWord);

s = sum(sum(prod.*confusionMatrix));
total = sum(sum(confusionMatrix));

s = s / total;



end