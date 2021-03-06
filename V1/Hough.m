close all
clear all
clc

img=imread('Fig/billar.png');
figure(1)
%imshow(img);

img2=rgb2gray(img);
%figure(2)
%imshow(img2);
[bordes,th]=edge(img2,'prewitt'); %Filtro
%figure(3)
imshow(bordes)
[L, W] = size(bordes);

rmin=10;
rmax=400;
rrange=[rmin,rmax]; %Rango de radios

[O,R,M]=imfindcircles(bordes,rrange,'Sensitivity',0.9); %circular Hough

centersStrong5 = O(:,:); 
radiiStrong5 = R(:); 
metricStrong5 = M(:);
viscircles(centersStrong5, radiiStrong5,'EdgeColor','b'); %Mostrar circulos
% viscircles(O,2*ones(length(R),1),'EdgeColor','b'); 

%% Segmentación
Nim=1;
for i=17:length(O(:,1))
    Nim=i;
    C=O(i,:);
    radio=R(i);
    pos_rect = [C(1)-radio-10,C(2)-radio-10,2*(radio+10),2*(radio+10)]; %[xmin, ymin, width, height]
    pos_rect = round(pos_rect);
    % Select part of the image
    img_cropped = img2(pos_rect(2) + (0:pos_rect(4)), pos_rect(1) + (0:pos_rect(3)));
    figure(2)
    imshow(img_cropped)
    tx = sprintf('Dataset\\circle%d.jpg',Nim);
    imwrite(img_cropped,tx);
    % viscircles([C],80,'EdgeColor','b');
end


%%
N = 1; %contador
for i = 1:L
    for j = 1:W
        if bordes(i,j)==1
            Pi(N)= i;
            Pj(N)= j;
            N = N+1; %contador
        end
    end
end
% P = [Pi;Pj].';  %No sirve de nada este vector chafo
% viscircles([Pj(15),Pi(15)],10,'EdgeColor','b');
N_VC = 40;
Nx = length(Pi)/N_VC;
Pix = Pi(1:Nx:length(Pi));
Pjx = Pj(1:Nx:length(Pj));

viscircles([20,400],10,'EdgeColor','b');


%% Vector característico
VC = zeros(1,N_VC);
for i=1:N_VC
    VC(i)= pdist2(C,[Pjx(i),Pix(i)]); 
end
VC = sort(VC);

%% Detector de colision
coll = detect_col(R,O)

