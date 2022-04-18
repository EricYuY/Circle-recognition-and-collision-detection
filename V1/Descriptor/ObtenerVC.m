function VC = ObtenerVC(imag)
BW1 = edge(rgb2gray(imag),'prewitt');
imshow(BW1);
[L, W] = size(BW1);
N = 1;
for i = 1:L
    for j = 1:W
        if BW1(i,j)==1
            Pi(N)= i;
            Pj(N) = j;
            N = N+1;
        end
    end
end
N_VC = 40;
Nx = length(Pi)/N_VC;
Pix = Pi(1:Nx:length(Pi));
Pjx = Pj(1:Nx:length(Pj));
VC = zeros(1,N_VC);
for i=1:N_VC
    C = [L/2 W/2];
    C = round(C);
    VC(i)= pdist2(C,[Pjx(i),Pix(i)]); 
end
VC = sort(VC);
end

