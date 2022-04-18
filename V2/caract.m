function desc = caract(imag,ur1,ur2,uv1,uv2,Np)

g = (imag(:,:,1) > ur1) & (imag(:,:,1) < ur2) & (imag(:,:,2) > uv1) & (imag(:,:,2) < uv2);
% figure(3)
% imshow(g)
% title('Binarizado')

se1 = strel('disk',2);
o = imopen(g,se1);

se1 = strel('disk',2);
c = imclose(o,se1);

% figure(4)
% imshow(c)
% title('image open and close')

[L,num] = bwlabel(c);

% figure(5)
% imshow(L,[0 5])
% title('image etiquetada')
% num

%Elegimos el de mayor tamaño
nx = 0;
for j = 1:num
    [ro,co] = find(L==j);
    if length(ro) > nx
        nx = length(ro);
        kx = j;
        rm = mean(ro);
        cm = mean(co);
    end
end

imseg = (L == kx);

% figure(6)
% imshow(imseg);

H = edge(imseg,'sobel');

%figure(7)
%imshow(H)

[ri,ci] = find(H > 0);
sa = atan2d(rm-ri,cm-ci);
sr = sqrt((cm-ci).^2+(rm-ri).^2);

[osa,I] = sort(sa);
osr = sr(I);

%figure, plot(osa,osr)


% figure
% plot(srd)

tam = length(osr);

Int = floor(tam/Np);

desc = osr(1:Int:Int*Np); %Se extrae solo Np puntos (descriptor)

% figure,
% plot(srd_d,'o')

