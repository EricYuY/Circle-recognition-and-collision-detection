function VC = ObtenerVC(imag)
BW1 = edge((imag),'Canny',[0,0.3]);
% imshow(imag);
% figure(2);
% imshow(BW1);

[L, W] = size(BW1);
N = 1;
for i = 1:L
    for j = 1:W
        if BW1(i,j)==1
            Pi(N)= i;
            Pj(N)= j;
            N = N+1;
        end
    end
end

C = [L/2 W/2];
C = round(C);

VC=zeros(60,1);

for i=1:N-1

    VC(i)= pdist2(C,[Pj(i),Pi(i)]); 
end

VC=hist(VC,40);
VC=VC/sum(VC);

end

