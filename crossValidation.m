function [s] = crossValidation(nb_part, feature, nb_state)

    % Assume that : (nb_sample % nb_part) = 0

    [nb_word, nb_sample] = size(feature);
    width = nb_sample / nb_part;
    s = zeros(nb_word, nb_sample);

    for i=1:nb_part
        
        feature_train = feature(:, [1:(i-1)*width i*width+1:end]);
        feature_test = feature(:, 1+(i-1)*width:i*width);
        
        [data_train, length_train] = convertToRightForm(feature_train);

        for j=1:nb_word
            hmm(j) = MakeLeftRightHMM(nb_state(j), GaussMixD, data_train{j}, length_train(j,:));
        end
    
        s(:, 1+(i-1)*width:i*width) = testHmm(hmm, feature_test);

    end

end