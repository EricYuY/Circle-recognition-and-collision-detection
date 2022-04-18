close all
clear all
clc
%%
Oini = zeros(30,2);
VID = VideoReader('video1.mp4');
while hasFrame(VID)
    img = readFrame(VID);
    img=imresize(img,0.2);
    rmin=6;
    rmax=50;
    rrange=[rmin,rmax]; %Rango de radios
    [O,R,M]=imfindcircles(edge(rgb2gray(img)),rrange,'Sensitivity',0.9); %circular Hough
    imshow(img);
    viscircles(O,R,'EdgeColor','b'); %Mostrar circulos
    if length(O)>0
        if length(O(:,1))>0
            if length(O(:,1))~= length(Oini(:,1)) 
                Oini = O;
            end
            Oiniaux = Oini;
            dist =pdist2(Oiniaux,O);
            for i = 1:length(O(:,1))
                j = find(dist(i,:)==min(dist(i,:)));
                Oini(i,:)= Oiniaux(j,:);
            end
            velocity = 0.01*round(100*[(O(:,1))-Oini(:,1),(O(:,2))-Oini(:,2)]);
            hold on
            quiver(O(:,1),O(:,2),velocity(:,1),velocity(:,2),0.5,'r');
    %       quiver(O(1,1),O(1,2),velocity(1,1),velocity(1,2),'r');
            hold off
            Oini = O;
        end
    end
    pause(0.01);
end;
