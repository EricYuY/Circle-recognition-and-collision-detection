close all
clear all
clc

load('net3.mat')
img=imread('Fig/billar3.png');
% v = VideoReader('VideosBillar/video.mp4');
% img = read(v,95); %frame de video
figure(1)
%imshow(img);

img2=rgb2gray(img);
%figure(2)
imshow(img2);
[bordes,th]=edge(img2,'prewitt'); %Filtro
%figure(3)
%imshow(bordes)
[L, W] = size(bordes);

rmin=14;
rmax=400;
rrange=[rmin,rmax]; %Rango de radios

[O,R,M]=imfindcircles(bordes,rrange,'Sensitivity',0.9); %circular Hough

centersStrong5 = O(:,:); 
radiiStrong5 = R(:); 
metricStrong5 = M(:);

O1=O;
R1=R;
k = 0;
for i=1:length(M)
    if M(i) < 0.1
        O1(i-k,:)=[];
        R1(i-k,:)=[];
        k = k+1;
    end
end
viscircles(O1,R1,'EdgeColor','r'); %Mostrar circulos
% viscircles(O,2*ones(length(R),1),'EdgeColor','b'); 

%% Segmentación
O2=O1;
R2=R1;
k=0;
delay = 3;
for i=1:length(O1(:,1))
    C=O1(i,:);
    radio=R1(i);
    if ((C(1)+radio >= W-delay) || (C(1)-radio <= delay) || (C(2)+radio >= L-delay) || (C(2)-radio <= delay))
        O2(i-k,:)=[];
        R2(i-k,:)=[];
        k = k+1;
    else
        pos_rect = [C(1)-radio-delay,C(2)-radio-delay,2*(radio+delay),2*(radio+delay)]; %[xmin, ymin, width, height]
        pos_rect = round(pos_rect);
        % Seleccionar parte de la imagen
        img_cropped = img2(pos_rect(2) + (0:pos_rect(4)), pos_rect(1) + (0:pos_rect(3)));
        img_cropped=imresize(img_cropped,[20 20]);
%         figure()
%         imshow(img_cropped);
        VC = ObtenerVC4(img_cropped);
        y=net3(VC.');
        if y(2) > 0.2
            O2(i-k,:)=[];
            R2(i-k,:)=[];
            k = k+1;
        end
    end
%     tx = sprintf('bola %d.jpg',i);
%     imwrite(img_cropped, tx);
end

    figure()
    imshow(img2)
    viscircles(O2, R2,'EdgeColor','r');

%% Detector de colision
coll = detect_col(R2,O2);
coll_v = reshape(coll, 1, []);
O3=[]
R3=[]
for i=coll_v
    O3=[O3;O2(i,:)]
    R3=[R3;R2(i,:)]
end

figure(3)
imshow(img2)
viscircles(O3, R3,'EdgeColor','g');

%%
%%
% %%
% %%
% close all
% [BW1,thresh] = edge((img_cropped),'Canny',[0,0.01]);
% imshow(img_cropped)
% figure()
% imshow(BW1)
% thresh
% figure()
% plot(VC)
% 
% %% Guardar imag
% O2=O1;
% R2=R1;
% k=0;
% delay = 3;
% for i=1:length(O1(:,1))
%     C=O1(i,:);
%     radio=R1(i);
%     if ((C(1)+radio >= W-delay) || (C(1)-radio <= delay) || (C(2)+radio >= L-delay) || (C(2)-radio <= delay))
%         O2(i-k,:)=[];
%         R2(i-k,:)=[];
%         k = k+1;
%     else
%         pos_rect = [C(1)-radio-delay,C(2)-radio-delay,2*(radio+delay),2*(radio+delay)]; %[xmin, ymin, width, height]
%         pos_rect = round(pos_rect);
%         % Seleccionar parte de la imagen
%         img_cropped = img(pos_rect(2) + (0:pos_rect(4)), pos_rect(1) + (0:pos_rect(3)),:);
%         img_cropped=imresize(img_cropped,[20 20]);
%     end
%     tx = sprintf('bola %d.jpg',i);
%     imwrite(img_cropped, tx);
% end
%     