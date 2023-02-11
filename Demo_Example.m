%%%%%%%%%% Preview a Preprocessing Example %%%%%%%%%
 A = read_database_file('C:\Users\h\Desktop\4_5877717960675559856\HMM_model\demo\PointingToolFile.lmr');
 
%%%%%%%%%%%% Define Train & Test Set %%%%%%%%%%%%%%%
 TrainingSamples = [1 2,3,4,6,7,10,13,14,15,16,17,18,19,20,22,23,24];
TestSamples     = setdiff(1:25,TrainingSamples);
 
%%%%%%%%%%%% Load all Training Files %%%%%%%%%%%%%%%
 allTrainDigits = {};
for k=1:10
 
    daux = {};
    idx = 1;
    for m=TrainingSamples
        path = strcat('C:\Users\h\Desktop\4_5877717960675559856\HMM_model\demo',num2str(k-1),'/file',num2str(k-1),'n',num2str(m),'.lmr');
        daux{idx}  = read_preprocess_and_feature_extract_digit(path);
        idx = idx +1;
    end
     allTrainDigits{k} = daux;
 end
 
%%%%%%%%%%%%%%% Train all the Models %%%%%%%%%%%%%%%%%
 train_gmm_model(allTrainDigits);
 
%%%%%%%%%%%%%%% Load all Test Files %%%%%%%%%%%%%%%%%%
 
allTestDigits = {};
for k=1:10
 
    daux = {};
    idx = 1;
    for m=TestSamples
        path = strcat('C:\Users\h\Desktop\4_5877717960675559856\HMM_model\demo',num2str(k-1),'\file',num2str(k-1),'n',num2str(m),'.lmr');
        daux{idx}  = read_preprocess_and_feature_extract_digit(path);
        idx = idx +1;
    end
        allTestDigits{k} = daux;
end
 
%%%%%%%%%%%%%%% Test all the Models %%%%%%%%%%%%%%%%%
[confusion_m_hmm,hmmProbs] = test_hmm_model(allTestDigits);
 
%%%%%%%%%%%%%%%% Apply Fusion Rule %%%%%%%%%%%%%%%%%%
[confusion_m_final,finalProbs] = apply_fusion_rule(hmmProbs);
figure(),
imagesc(confusion_m_hmm),   title('Confusion Matrix HMM'), colorbar();

