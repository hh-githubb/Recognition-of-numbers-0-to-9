function [confusion_matrix,finalProbs]=apply_fusion_rule(hmmProbs)

    confusion_matrix = zeros(10);
    finalProbs = {};
    %FeatureList is a list of all the digits features organized
    %by two index FeatureList{1}{10} access to the 10th sample
    %of the 1st class (digit 0)
    for k=1:10
       for m=1:length(hmmProbs{k})
           
            %Chose a Fusion rule to get the result
            [finalProb]=simple_fusion_rule(hmmProbs{k}{m});

            test_label      = find(finalProb==max(finalProb));
            
            confusion_matrix(k,test_label) = confusion_matrix(k,test_label) + 1;
            finalProbs{k}{m} = finalProb;
            
       end
    end
end