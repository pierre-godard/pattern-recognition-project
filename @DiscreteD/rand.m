function R=rand(pD,nData)
%R=rand(pD,nData) returns random scalars drawn from given Discrete Distribution.
%
%Input:
%pD=    DiscreteD object
%nData= scalar defining number of wanted random data elements
%
%Result:
%R= row vector with integer random data drawn from the DiscreteD object pD
%   (size(R)= [1, nData]
%
%----------------------------------------------------
%Code Authors:
%----------------------------------------------------

if numel(pD)>1
    error('Method works only for a single DiscreteD object');
end;
R = zeros(1,nData);

for i=1:nData

    number = builtin('rand');
    sum = 0;
    for index=1:size(pD.ProbMass,1)
        sum = sum + pD.ProbMass(index);
        if sum > number
            R(i) = index;
            break;
        end;
    end;

end;