function [conf] = makeConfusionMatrix(s, nb_word, nb_sample)
    conf = zeros(nb_word, nb_word);
    for j=1:nb_sample
        for i=1:nb_word
            k = s(i,j);
            conf(k,i) = conf(k,i) + 1;
        end
    end
end