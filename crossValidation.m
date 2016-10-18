function [s] = crossValidation(nb_part, feature, nb_state)

% Assume that : (nb_sample % nb_part) = 0

nb_word = size(feature,1);
nb_sample = size(feature,2);
width = nb_sample / nb_part;
s = zeros(nb_word, nb_sample);

for i=1:nb_part
    p = false(1,nb_sample);
    p(1 + (i-1)*width:i * width) = true;
    [train_data, train_length] = convertToRightDataForm(feature(:,not(p)));
    [test_data, test_length] = convertToRightDataForm(feature(:,p));
    for j=1:nb_word
        hmm(j) = MakeLeftRightHMM(nb_state(j), GaussMixD, train_data{j}, train_length(j,:));
    end
    s(:,1 + (i-1)*width:i * width) = testHmm(hmm, test_data, test_length);
    
end

end