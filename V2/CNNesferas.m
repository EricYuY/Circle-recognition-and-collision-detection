close all;
clear all;
clc

numVal=1550;
path=fullfile('Bolas');
labels={'balls','not_balls'};
imds=imageDatastore(fullfile(path,labels),'LabelSource','foldernames');
[entradaTrain,entradaVal] = splitEachLabel(imds,numVal*0.8,'randomize');

%%
layers = [imageInputLayer([27 27 3])
 convolution2dLayer(5,40)
 reluLayer
 dropoutLayer(0.4)  % probabilidad 0.4 de retirar temporalmente una neurona
 maxPooling2dLayer(2, 'Stride', 2)
 fullyConnectedLayer(2)
 softmaxLayer
 classificationLayer() ];

miniBatchSize = 100;
options = trainingOptions( 'sgdm',...
 'MiniBatchSize', miniBatchSize,...
 'ValidationData',entradaVal, ...
 'ValidationFrequency',30, ... 
 'Plots', 'training-progress','MaxEpochs', 150,'InitialLearnRate', 0.0001);
net = trainNetwork(entradaTrain, layers, options);

save('net.mat','net');
