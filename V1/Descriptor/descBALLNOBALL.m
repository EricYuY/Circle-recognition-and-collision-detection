N = 1000; %número de datos por categoría
shapeinputs = zeros(2*N,40);
for i = 1:N
    Nim = i;
    tx = sprintf('Bolas\\Balls\\ball_%d.png',Nim);
    imag=imread(tx);
    VC = ObtenerVC(imag);
    shapeinputs(i,:) = VC;
end
for i = 1:N
    Nim = i;
    tx = sprintf('Bolas\\not_balls\\ball_%d.png',Nim);
    imag=imread(tx);
    VC = ObtenerVC(imag);
    shapeinputs(i+N,:) = desc;
end

shapeoutputs = zeros(2*N,2);
for i = 1:N
    if i <= N
        shapeoutputs(i,:) = [1,0];
    else 
        shapeoutputs(i,:) = [0,1];
    end
end
shapeinputs = shapeinputs.';
shapeoutputs = shapeoutputs.';
