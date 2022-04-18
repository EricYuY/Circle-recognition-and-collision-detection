close all
clear all
clc

i=51;
Nim = i;
tx = sprintf('Bolas3\\balls\\ball (%d).jpg',Nim);
imag=imread(tx);
imag=rgb2gray(imag);
imag=imresize(imag,[20 20]);
VC = ObtenerVC4(imag);
%shapeinputs(i,:) = VC;
figure()
plot(VC);

%%

i=441;
Nim = i;
tx = sprintf('Bolas3\\not_balls\\ball (%d).jpg',Nim);
imag=imread(tx);
imag=rgb2gray(imag);
imag=imresize(imag,[20 20]);
VC = ObtenerVC4(imag);
%shapeinputs(i,:)= VC;
figure()
plot(VC);

%%
BW1 = edge((imag),'Canny',[0,0.01]);
figure()
subplot(2,1,1)
imshow(BW1);
subplot(2,1,2)
imshow(imag)
%%
close all
clear all
clc

N = 2295; %número de datos por categoría 2295
shapeinputs = [];
shapeoutputs= [];
for i = 1:N
    Nim = i;
    tx = sprintf('Bolas3\\balls\\ball (%d).jpg',Nim);
    imag=imread(tx);
    imag=rgb2gray(imag);
    imag=imresize(imag,[20 20]);
    VC = ObtenerVC4(imag);
    shapeinputs = [shapeinputs;VC];
    shapeoutputs = [shapeoutputs;[1,0]];

    Nim = i;
    tx = sprintf('Bolas3\\not_balls\\ball (%d).jpg',Nim);
    imag=imread(tx);
    imag=rgb2gray(imag);
    imag=imresize(imag,[20 20]);
    VC = ObtenerVC4(imag);
    shapeinputs=[shapeinputs;VC];
    shapeoutputs = [shapeoutputs;[0,1]];
end

shapeinputs = shapeinputs.';
shapeoutputs = shapeoutputs.';

%% TRAIN

pp=2*N;
trainIn=shapeinputs(:,1:pp);
trainOut=shapeoutputs(:,1:pp);

net=patternnet([20,20,20]);
net=train(net,trainIn,trainOut);

%% TEST

test=shapeinputs(:,pp+1:end);
testout=shapeoutputs(:,pp+1:end);
y=net(test);
y=round(y);

%%
tx = sprintf('Fig/circle1.jpg');
imag=imread(tx);
imag=imresize(imag,[20 20]);
% imshow(imag)
VC = ObtenerVC4(imag);
y=net(VC')

%%
net3=net;
save('net3.mat')