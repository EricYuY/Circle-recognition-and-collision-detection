function [choque] = detect_col(R,O)
%% Detectar colisiones
disRad=[];
disCent=[];
colision=[];
choque=[];

for i=1:length(R)
    for j=1:length(R)
        if (i~=j)
            disRad(i,j)= R(i)+R(j);
            disCent(i,j)= pdist2(O(i,:),O(j,:));
        else
            disRad(i,j)=0;
            disCent(i,j)=0;
        end
    end
end


for i=1:length(R)
    for j=1:length(R)
        if (i~=j)
            if (disRad(i,j)>disCent(i,j))
                colision(i,j)= 1;
            else
                colision(i,j)= 0;
            end
        else
            colision(i,j)= 0;
        end
    end
end

for i=1:length(R)
    for j=i:length(R)
        if (colision(i,j)== 1 && colision(j,i)== 1)
           choqueNN = [i j];
           choque=[choque ; choqueNN];
        end     
    end
end

%colision

end

