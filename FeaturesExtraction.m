%[ features ] = featuresExtraction( sample, sampleRate, windowLength, numberCoefficients )
%
%Function to calculate all the static and dynamic MFFCs features and then
%normalize them.
%
%Input:
%sample=             vector containing sampled signal values
%sampleRate=         sampling frequency of signal in Hz
%windowLength=       length of the analysis window in seconds
%numberCoefficients= number of cepstral coefficients to return (including order 0)
%
%Result:
%features=  matrix containing normalized mel frequency cepstral static and
%           dynamic coefficients. Each column corresponds to the cepstral
%           coefficients of a single frame, with the zeroth order
%           coefficent at the top.

function [ features ] = FeaturesExtraction( sample, sampleRate, windowLength, numberCoefficients )

    % Extracting the MFFCs
    [mfccs] = GetSpeechFeatures(sample, sampleRate, windowLength, numberCoefficients);

    % Velocity
    d = diff(mfccsMale, 1, 2);
    % Acceleration
    dd = diff(d, 1, 2);

    % Concatenate the three matrix
    features = cat(1, mfccs(:,1:end-2), d(:,1:end-1), dd);

    % Normalization of the matrix
    numberCoefficients = size(features,2);
    means = repmat(mean(features, 2), 1, numberCoefficients);
    stds = repmat(std(features, 0, 2), 1, numberCoefficients);
    features = (features - means) ./ stds;

end

