function [measures, nStates] = nbStatePerWord(feature, nb_state_start, nb_state_end, threshold, measure_function)
% Try to find the best number of states for each word. Make use of the MSE.
% Once the MSE value of a word is below the threshold, we do not increase the number
% of states for that word.
    
    nb_part = 4;
    [nb_word, nb_sample] = size(feature);
    width = nb_sample / nb_part;
    
    measures = zeros(nb_word, nb_state_end - nb_state_start + 1);
    
    for k=nb_state_start:nb_state_end+1
        % Not doing any computation at k=nb_state_end as it is the fallback
        % number of states.
        
        disp(['#states ', k]);

        measures_temp = zeros(nb_word, nb_part);

        for i=1:nb_part

            feature_train = feature(:, [1:(i-1)*width i*width+1:end]);
            feature_test = feature(:, 1+(i-1)*width:i*width);

            [data_train, length_train] = convertToRightForm(feature_train);

            for j=1:nb_word
                hmm(j) = MakeLeftRightHMM(k, GaussMixD, data_train{j}, length_train(j,:));
            end
            
            measures_temp(:, i) = measure_function(hmm, feature_test);

        end

        measures(:, k - nb_state_start + 1) = mean(measures_temp, 2);

    end
    
    measures_temp2 = [abs(diff(measures, 2, 2)) log(zeros(nb_word, 1))];
    
    disp(measures_temp2);
    
    [~, nStates] = max(measures_temp2 < threshold, [], 2);
    
    nStates = nStates' + nb_state_start - 1;
    
end