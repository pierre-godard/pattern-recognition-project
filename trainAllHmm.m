function [HmmArray] = trainAllHmm(nb_state, train_data, train_length, Distrib)

nb_word = size(train_data, 1);

for j=1:nb_word
    HmmArray(j) = MakeLeftRightHMM(nb_state(j), Distrib, train_data{j}, train_length(j,:));
end

end