function featureShuffled = shuffle(feature)

nb_word = size(feature,1);
nb_sample = size(feature,2);

featureShuffled = cell(size(feature));
for i=1:nb_word
    p = randperm(nb_sample);
    featureShuffled(i,:) = feature(i,p);
end


end