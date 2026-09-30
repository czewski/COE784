% Lista 2 - Image Sampling and Interpolation
clear; clc; close all; 
disp('Lista 2 - Image Sampling and Interpolation')
disp('Eduardo Henrique Banaczewski')
disp('I - Amostragem'); 
pause; 

disp('I.1)')
img = imread('zelda_s.tif');
figure('Name', 'Zelda')
imshow(img);
axis on;
colormap(gray(256));
colorbar;

disp('Resolução da imagem: ')
size(img)

pause;
close all;

disp('I.2) ')
figure('Name', 'Zelda subamostrada (fator 2)')
img_2 = img(1:2:end,1:2:end);
imshow(img_2);
axis on;
truesize;
colorbar;

disp('Usando o slicing para subamostrar... (1:2:end)')
disp('Resolução, imagem subamostrada em 2: ')
size(img_2)

pause;
close all;

disp('I.3) ')
img_4 = img(1:4:end,1:4:end);
img_8 = img(1:8:end,1:8:end);
img_16 = img(1:16:end,1:16:end);
img_32 = img(1:32:end,1:32:end);

figure('Name', 'Subamostragem da imagem', 'Position',[500,500,800,600]);
subplot(2,2,1);
imshow(img_4);
axis on;
title('1/4 da resolução');

subplot(2,2,2);
imshow(img_8);
axis on;
title('1/8 da resolução');

subplot(2,2,3);
imshow(img_16);
axis on;
title('1/16 da resolução');

subplot(2,2,4);
imshow(img_32);
axis on;
title('1/32 da resolução');
truesize;

disp('Nessa visualização é necessário aumentar o tamanho da janela manualmente, devido ao uso do comando truesize.')
pause;
close all; 


disp('Imagem / Espectro de frequências: ')
imgs = {img_2, img_4, img_8, img_16, img_32};
for i = 1:length(imgs)
    disp(['Mostrando figura: ' int2str(i)]);
    figure('Name', 'Subamostragem', 'Position', [100, 300, 800, 600]);
    imshow(imgs{i}, []);
    truesize;
    axis on;
    
    figure('Name', 'Frequencia', 'Position', [920, 300, 800, 600]);
    F = fft2(imgs{i});
    magnitude = log(abs(fftshift(F)) + 1);
    imshow(magnitude, []);
    truesize;
    axis on;
    
    pause;
    close all;
end

disp('O espectro de frequência para uma imagem subamostrada, compartilha da mesma resolução (observamos o efeito de pixelização tanto na ')
disp(' imagem, quanto no espectro, ao aumentar o fator). ')
disp('Exemplo: Na imagem original, a resolução é 288x360, seu espectro segue a mesma resolução.  ')
disp('Tambem observamos que: ao reduzir em fator R, temos uma resolução M/R x N/R, o que consequentemente gera uma nova taxa de amostragem (1/R). ')
disp('Com essa nova taxa, nem todas frequências conseguem ser conservadas. ')

pause;
close all; 

disp('I.4) ')
disp('Para esse exercicio estou usando a função repelem() do matlab, com parametros (R,R), dado Rs = [2,4,8,16,32]')
Rs = [2,4,8,16,32];
for i = 1:length(imgs)
    R = Rs(i);
    figure('Name', 'Imagem expandida: ', 'Position', [100, 300, 800, 600]);
    img_upsampled = repelem(imgs{i}, R, R);
    imshow(img_upsampled);
    title(['Img expandida R=' num2str(R)]);
    axis on;
    truesize;
    colorbar;
    pause;
end

disp('Nesse caso ainda observamos a pixelização, porém a resolução da imagem segue a da original (MxN)')
pause; 
close all;

disp('II.1 - Geração de Zoneplates ')
disp('II.1.a) ')
disp('Utilizando a função zoneplate() que se encontra no final do script. ')
figure('Name', 'Zoneplate B=1, M=256', 'Position', [500, 300, 800, 600]);
img = zoneplate(256, 1);
imshow(img);
axis on;
truesize;
colormap('gray');
colorbar;

pause;

disp('II.1.b)')
figure('Name', 'Zoneplate B=0.5, M=256', 'Position', [100, 300, 800, 600]);
img = zoneplate(256, 0.5);
imshow(img);
axis on;
truesize;
colormap('gray');
colorbar;

figure('Name', 'Zoneplate B=2, M=256', 'Position', [920, 300, 800, 600]);
img = zoneplate(256, 2);
imshow(img);
axis on;
truesize;
colormap('gray');
colorbar;

disp('Inicialmente consigo observar que os circulos do zoneplate, tem uma frequência maior conforme se distanciam do centro da imagem. ')
disp('Quando B=1, observo pequenas repetições de circulos nas 4 extremidades (norte sul leste oeste).')
disp('Essa repetição dos circulos, é dada devido ao efeito de aliasing, ')
disp('Quando B=0.5, observo circulos limpos, largos no centro e mais finos nas extremidades. ')
disp('Sem aliasing nesse caso. Pesquisei que a frequencia maxima de uma imagem MxM é 0.5 ciclos/pixel. ')
disp('Para calcular essa frequencia, foi preciso derivar a fase em relação a (sqrt(x^2 + y^2)), obtendo f=B*(dist)/2M')
disp('assim, a frequencia maxima ocorre nos cantos da imagem. Com dist max = M/sqrt(2)')
disp('Fmax = B/2*sqrt(2) ')
disp('Calculando a frequência maxima da função de zoneplate com B=0.5, encontro ~0,177 ciclos/pixel')
disp('Sem aliasing para B=0.5.')
disp('Para B=2, usando Fmax, encontro ~0,707 ciclos/pixel, então existe aliasing ')
disp('Visualmente esse aliasing pode ser visto com sobreposição dos aneis, onde estão mais fortes no eixo cruz, e mais fracos nas diagonais. ')
disp('Assim, o efeito de B controla a frequência no caso da função de zoneplate, maior B resulta em frequências mais altas e maior chance de aliasing. ')
pause;
close all;

disp('II.2 - Observação de aliasing ')
disp('II.2.1.a)')
img = zoneplate(256, 1);
img_2 = img(1:2:end,1:2:end);
figure('Name', 'Zoneplate Original 256, 1', 'Position', [100, 200, 800, 600]);
imshow(img);
truesize;
axis on;
title('Zoneplate b=1 m=256')
colormap('gray');
colorbar;

figure('Name', 'Subamostra (2): Zoneplate 256, 1', 'Position', [500, 500, 800, 600]);
imshow(img_2);
title('subamostrado: fator 2')
truesize;
axis on;
colormap('gray');
colorbar;

pause;
close all;

disp('II.2.1.b)')
img_upsampled = repelem(img_2, 2, 2);
figure('Name', 'Expansão', 'Position', [920, 300, 800, 600]);
imshow(img_upsampled);
truesize;
axis on; 
truesize;

figure('Name', 'Zoneplate Original', 'Position', [100, 200, 800, 600]);
imshow(img);
truesize;
axis on; 
truesize;

figure('Name', 'Zoneplate Subamostrado 2', 'Position', [500, 500, 800, 600]);
imshow(img_2);
truesize;
axis on; 
truesize;

%COMMENT
disp('Observado: as duas imagens apesar de possuirem o mesmo tamanho e padrão de repetição, uma delas tem aliasing (expansão) e outra não (original)')
disp('aliasing nesse caso além das leves repetições dos aneis nas extremidades e eixo cruz, é visto em pequenas distorções nos aneis')
disp('Subamostrar por um fator de 2 é basicamente descartar amostras da imagem.')
disp('ao expandir com expansão de pixeis (fator 2), as frequencias se "espalham", criando copias periodicas do espectro')
disp('as frequencias originais são somadas nas frequencias mais baixas, criando componentes nao desejadas.  ')
disp('Expandir por repetição, é o mesmo de usar um filtro de reconstrução "zero order hold", nao remove alias mas suavizas blocos. ')
disp('Comparando com o zoneplate subamostrado, teve uma certa "redução" nos efeitos do aliasing, que é essa "suavização"')
pause;
close all;

disp('II.2.2)')
F = [0, 0.4, 0.5, 1];
A = [1,1,0,0];
H1d = remez(10, F, A);
H2d = H1d' * H1d;

img = zoneplate(256, 1);
img_filtered = filter2(H2d,img);
figure('Name', 'Filtered Zoneplate', 'Position', [100, 200, 800, 600]);
imshow(img_filtered);
axis on; 
truesize;

% subamostragem em 2
img_2 = img_filtered(1:2:end,1:2:end);
img_upsampled_filtered = repelem(img_2, 2, 2);
figure('Name', 'Filtro > Subamostra 2 > Expansão', 'Position', [500, 500, 800, 600]);
imshow(img_upsampled_filtered);
truesize;
axis on; 
truesize;

figure('Name', 'Zoneplate subamostra 2 > expansão (sem filtro)', 'Position', [920, 300, 800, 600]);
imshow(img_upsampled);
truesize;
axis on; 
truesize;

%COMMENT
disp('Esse filtro pode ser considerado um passa-baixa. ')
disp('Na Figura 2 (filtro, subamostra, expansão) observamos que ainda temos aliasing em comparação a Figura 3 que não utiliza o filtro. ')
disp('Acredito que a frequência de corte não foi o suficiente para filtrar as frequencias indesejadas. ')
disp('Porém as imagens filtradas tiveram os pixeis de valor branco alterados também, deixando a imagem em um geral com aspecto mais escuro. ')
pause;
close all;

disp('III - Interpolação')
disp('III.1) ')
img = imread('lena_256.tif');
figure('Name',  'Lena Original', 'Position', [500, 700, 800, 600]);
imshow(img);
colormap(gray(256));
truesize;
axis on;
colorbar;

img_2 = img(1:2:end,1:2:end);
figure('Name',  'Lena Subamostra fator 2','Position', [500, 300, 800, 600]);
imshow(img_2);
colormap(gray(256));
truesize;
axis on;
colorbar;

pause;
close all;

disp('III.2) ')
% upsampling por inserção de zeros
figure('Name', 'Upsampling por inserção de zeros', 'Position', [500, 500, 800, 600]);
img_zeros = kron(double(img_2), [1 0; 0 0]);
colormap(gray(256));
imshow(img_zeros, []);
axis on;
colorbar;

% Espectro
figure('Name', 'Espectro Imagem com Upsampling', 'Position', [500, 700, 800, 600]);
F = fft2(img_zeros);
magnitude = log(abs(fftshift(F)) + 1);
imshow(magnitude, []);
truesize;
axis on;

figure('Name', 'Espectro Imagem Subamostrada', 'Position', [500, 900, 800, 600]);
F = fft2(img_2);
magnitude = log(abs(fftshift(F)) + 1);
imshow(magnitude, []);
truesize;
axis on;

disp('Essa técnicas de upsampling nao cria informações novas. ')
disp('Upsampled: Xu(u,v) -> subamostrada: Xs(2u,2v)')
disp('No espectro subamostrado tem apenas o pico branco central (componente DC). ')
disp('No espectro da imagem com os zeros, observo picos brancos repetidos periodicamente, em todas extremidades do espectro. ')
pause;
close all;

disp('III.3) ')
disp('III.3.a)')
h0 = [0.5 0.5];
h1 = conv(h0, h0);
h2 = conv(h1, h1);

disp('H0: ')
disp(h0);
disp('H1: ')
disp(h1);
disp('H2: ')
disp(h2);

pause;
close all;

disp('III.3.b)')
hh0 = 4*(h0')*h0;
hh1 = 4*(h1')*h1;
hh2 = 4*(h2')*h2;

disp('hh0: ')
disp(hh0);
disp('hh1: ')
disp(hh1);
disp('hh2: ')
disp(hh2);

% Filtrando lena original
img = imread('lena_256.tif');
figure('Name',  'Lena Original Filtrada hh0', 'Position', [500, 200, 800, 600]);
img_filtered_hh0 = filter2(hh0,img);
imshow(img_filtered_hh0, []);
axis on;
colorbar;

figure('Name',  'Lena Original Filtrada hh1', 'Position', [500, 500, 800, 600]);
img_filtered_hh1 = filter2(hh1,img);
imshow(img_filtered_hh1, []);
axis on;
colorbar;

figure('Name',  'Lena Original Filtrada hh2', 'Position', [500, 900, 800, 600]);
img_filtered_hh2 = filter2(hh2,img);
imshow(img_filtered_hh2, []);
axis on;
colorbar;

%COMMENT
disp('Todos esses filrtos são simétricos e separaveis. ')
disp('hh0: esse filtro (2x2) aplica [0.5 0.5] nas linhas e nas colunas, é como se fosse uma média movel 2d. ')
disp('hh1: esse filtro (3x3) é como se fosse uma aproximação gaussiana, ele suaviza melhor que o filtro de média movel.')
disp('hh2: esse filtro (5x5) tambem é uma aproximação gaussiana, porém é mais suave que o hh1. ')

disp('O fator 4 faz com que a soma dos componentes do filtro somem 4 ao invés de 1. ')
soma_filtro = sum(hh2);
disp('soma linhas filtro hh2: ')
disp(int2str(soma_filtro));
disp('soma final hh2: ')
disp(int2str(sum(soma_filtro)));

disp('Esse fator acaba compensando a redução do brilho da imagem com upsampling (devido aos pixeis com valor 0, o filtro acabaria tendendo a valores ')
disp(' próximos de cores mais escuras')
disp('O fator 4 compensa os valores desse upsampling. ')

pause;
close all;

disp('III.4) ')
figure('Name', 'Frequencia para filtros 1d');
freqz(h0, 1, 512);
hold on;
freqz(h1, 1, 512);
freqz(h2, 1, 512);
legend('h0', 'h1', 'h2');
grid on;

disp('No gráfico de magnitude desses filtros, podemos observar que são passa-baixa: ')
disp('Deixam passar as frequências baixas e filtram as mais altas. ')
disp('nesse caso, h0 é o mais suave em relação a atenuação de altas frequencias (-50db). ')

pause;
close all;

disp('III.5) ')
figure('Name', 'Frequencia para filtros 2d',  'Position', [30, 200, 800, 600]);

subplot(2,2,1);
freqz2(hh0, [32,32]);  
title('hh0');
colorbar;
grid on;

subplot(2,2,2);
freqz2(hh1, [32,32]);
title('hh1');
colorbar;
grid on;

subplot(2,2,3);
freqz2(hh2, [32,32]);
title('hh2');
colorbar;
grid on;

subplot(2,2,4);
freqz2(H2d, [32,32]);
title('H2d');
colorbar;
grid on;

disp('O produto de dois filtros 1D, gera filtros separaveis. ')
disp('Isso traz uma simetria no plano da frequencia. ')
disp('Ainda são filtros passa baixa. ')
pause;
close all;

disp('III.6) ')
img_H0 = filter2(hh0, img_zeros);
img_H1 = filter2(hh1, img_zeros);
img_H2 = filter2(hh2, img_zeros);
img_Hremez = filter2(H2d, img_zeros);

% Espectros
F0 = fft2(img_H0); F0_shift = fftshift(F0); mag0 = log(abs(F0_shift) + 1);
F1 = fft2(img_H1); F1_shift = fftshift(F1); mag1 = log(abs(F1_shift) + 1);
F2 = fft2(img_H2); F2_shift = fftshift(F2); mag2 = log(abs(F2_shift) + 1);
Frem = fft2(img_Hremez); Frem_shift = fftshift(Frem); mag_rem = log(abs(Frem_shift) + 1);


figure('Name', 'Filtro hh0', 'Position', [50, 520, 700, 500]);
subplot(1,2,1); imshow(img_H0, []); title('hh0 - Imagem'); colorbar; axis on;
subplot(1,2,2); imshow(mag0, []); title('hh0 - Espectro'); colorbar; axis on;

figure('Name', 'Filtro hh1', 'Position', [780, 520, 700, 500]);
subplot(1,2,1); imshow(img_H1, []); title('hh1 - Imagem'); colorbar; axis on;
subplot(1,2,2); imshow(mag1, []); title('hh1 - Espectro'); colorbar; axis on;

figure('Name', 'Filtro hh2', 'Position', [50, 30, 700, 500]);
subplot(1,2,1); imshow(img_H2, []); title('hh2 - Imagem'); colorbar; axis on;
subplot(1,2,2); imshow(mag2, []); title('hh2 - Espectro'); colorbar; axis on;

figure('Name', 'Filtro Hremez (H2d)', 'Position', [780, 30, 700, 500]);
subplot(1,2,1); imshow(img_Hremez, []); title('H2d - Imagem'); colorbar; axis on;
subplot(1,2,2); imshow(mag_rem, []); title('H2d - Espectro'); colorbar; axis on;


disp('Visualmente para mim, o filtro h2d produz a melhor resposta na questão de nitidez, porem com algumas linhas visiveis. ')
disp('o hh1 e hh2 a imagem fica um pouco borrada, e o h2d com linhas horizontais e verticais. ')
disp('Filtro h2d, teoricamente falando é o melhor. ')
disp('Analisando o dominio da frequência, todos eles possuem a forte componente central, ')
disp('hh2: perda de frequencias altas, resultando em uma imagem mais borrada. ')
disp('hh1: tambem possui um pouco de borrão (corte de altas frequencias) ')
disp('hh0: a imagem parece mais quadriculada (padrão de repetição (no espectro) como se fosse aliasing, filtro não funciona tao bem) ')
disp('H2d: remove completamente o borrão porem adiciona uma pequena visualização de listras. ')
disp('No espectro de H2d, podemos ver alta remoção das frequencias altas (e quase sem aliasing). ')
disp('Esse corte das frequências pode ser visualizado de forma muito mais clara na questão 7. ')
pause;
close all;


disp('III.7) ')
img = zoneplate(128, 1);

img_H0 = filter2(hh0, img);
img_H1 = filter2(hh1, img);
img_H2 = filter2(hh2, img);
img_Hremez = filter2(H2d, img);

F0 = fft2(img_H0); F0_shift = fftshift(F0); mag0 = log(abs(F0_shift) + 1);
F1 = fft2(img_H1); F1_shift = fftshift(F1); mag1 = log(abs(F1_shift) + 1);
F2 = fft2(img_H2); F2_shift = fftshift(F2); mag2 = log(abs(F2_shift) + 1);
Frem = fft2(img_Hremez); Frem_shift = fftshift(Frem); mag_rem = log(abs(Frem_shift) + 1);

figure('Name', 'Filtro hh0', 'Position', [50, 520, 700, 500]);
subplot(1,2,1); imshow(img_H0, []); title('hh0 - Imagem'); colorbar; axis on;
subplot(1,2,2); imshow(mag0, []); title('hh0 - Espectro'); colorbar; axis on;

figure('Name', 'Filtro hh1', 'Position', [780, 520, 700, 500]);
subplot(1,2,1); imshow(img_H1, []); title('hh1 - Imagem'); colorbar; axis on;
subplot(1,2,2); imshow(mag1, []); title('hh1 - Espectro'); colorbar; axis on;

figure('Name', 'Filtro hh2', 'Position', [50, 30, 700, 500]);
subplot(1,2,1); imshow(img_H2, []); title('hh2 - Imagem'); colorbar; axis on;
subplot(1,2,2); imshow(mag2, []); title('hh2 - Espectro'); colorbar; axis on;

figure('Name', 'Filtro Hremez (H2d)', 'Position', [780, 30, 700, 500]);
subplot(1,2,1); imshow(img_Hremez, []); title('H2d - Imagem'); colorbar; axis on;
subplot(1,2,2); imshow(mag_rem, []); title('H2d - Espectro'); colorbar; axis on;

pause;
close all;

disp('III.8) ')
disp('Os dois podem ser considerados formas de interpolação. ')
disp('Porém em I.4, apenas repetimos os pixeis, como uma interpolaçao por vizinhança/proximidade ')
disp('É uma interpolação bem "crua", pouco suave. ')
disp('Já em III, utilizando filtros 2d propriamente projetados, existe uma atenuação do sinal')
disp('buscando assim eliminar essas replicas indesejadas (nas altas frequencias)')
disp('e tentando um equilibrio entre supressão de aliasing, nitidez e "artefatos"')

pause;
close all;

function g = zoneplate(M, beta)
    x = linspace(-M/2 + 0.5, M/2 - 0.5, M);
    y = linspace(-M/2 + 0.5, M/2 - 0.5, M);
    [X, Y] = meshgrid(x, y);
    g = 0.5 * cos((beta * pi) / (2 * M) * (X.^2 + Y.^2)) + 0.5;
end