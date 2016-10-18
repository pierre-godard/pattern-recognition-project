function [data, data_length] = convertToRightForm(feature)

nb_word = size(feature,1);
nb_sample = size(feature,2);

data_length = zeros(nb_word,nb_sample);
data = cell(nb_word,1);

for i=1:nb_word
    word_temp = [];
    for j=1:nb_sample
        word_temp = cat(2,word_temp, feature{i,j});
        data_length(i,j) = size(feature{i,j},2);
    end
    data{i} = word_temp;    
end


end