% Lista 3 - Image Perception
clear; clc; close all; 
disp('Lista 4 - Image Perception')
disp('Eduardo Henrique Banaczewski')
pause; 

disp('-----------------')
disp('I.1) ');
X = [0   0   0   0   0   0;
     0   0   0   0   0   0;
     0   0   0.5 0.5 0   0;
     0   0   0.5 0.5 0   0;
     0   0   0   0   0   0;
     0   0   0   0   0   0];

Y = [1   1   1   1   1   1;
     1   1   1   1   1   1;
     1   1   0.5 0.5 1   1;
     1   1   0.5 0.5 1   1;
     1   1   1   1   1   1;
     1   1   1   1   1   1];

figure('Name', 'Matrizes Originais', 'Position',[500,500,800,600]);
subplot(1,2,1);
imshow(X);
axis on;
title('X');

subplot(1,2,2);
imshow(Y);
axis on;
title('Y');

disp('Parece que o quadrado da direita (fundo branco), é mais escuro que o da esquerda, mesmo os dois tendo o mesmo valor. ')
pause;

X = [0   0   0   0   0   0;
     0   0   0   0   0   0;
     0   0   0.5 0.5 0   0;
     0   0   0.5 0.5 0   0;
     0   0   0   0   0   0;
     0   0   0   0   0   0];

Y = [1   1   1   1   1   1;
     1   1   1   1   1   1;
     1   1   0.7 0.7 1   1;
     1   1   0.7 0.7 1   1;
     1   1   1   1   1   1;
     1   1   1   1   1   1];

figure('Name', 'Matrizes Ajustadas', 'Position',[500,500,800,600]);
subplot(1,2,1);
imshow(X);
axis on;
title('X');

subplot(1,2,2);
imshow(Y);
axis on;
title('Y');

disp('Ajustei os valores centrais da matriz da direita para 0.7. Agora a cor está similar entre os dois quadros. ')
disp(' mesmo tendo cores diferentes.')
pause;
close all;

disp('Função "Checkershadow()": ')
checkershadow();
disp('O que acontece aqui, é uma ilusão no sistema de percepção/optico, apesar de A e B terem o mesmo valor de pixel (107), ')
disp(' os quadros em volta de B, tem intensidade maior (54) que os quadros em volta de A, criando assim uma ilusão para o  ')
disp(' olho humano, pois percebemos A como sendo mais escuro. ')

pause;
close all;
imtool close all;

cont_sim2();
disp('Nas imagens chamadas pela função "cont_sim2()", acontece um comportamento similar ao observado no plot das primeiras matrizes.  ')
disp(' ao separar o quadro com uma faixa branca,  a percepção do anel central, mesmo que com o mesmo valor dos pixeis, parece com ')
disp(' uma cor mais escura ao compararmos com a imagem unida. ')
disp('A mesma ideia segue com as imagens deslocadas, pois são introduzidas faixas de cor branca em cima e embaixo dos quadros, ')
disp(' alterando assim a percepção.')

disp('É possível concluir que o cerébro utiliza o contexto ao redor de um objeto para construir a percepção de brilho.')
disp(' essa ilusão vem da inibição lateral, onde as celulas que recebem a luz, acabam enviando sinais que reduzem a resposta. ')

pause;
close all;

disp('-----------------')
disp('I.2) ');
disp('I.2.a) ');
n = 256;
num_barras = 7;
bordas = round(linspace(0, n, num_barras + 1));
larguras = diff(bordas);
niveis_cinza = linspace(0, 1, num_barras);
linha = repelem(niveis_cinza, larguras);
X = repmat(linha, n, 1);

figure('Name', 'Barras Cinzas', 'Position',[500,500,800,600]);
imshow(X, [0 1]);
colormap(gray(256));
colorbar;

disp('Consigo observar que em cada transição de cor (principalmente nas mais claras), ')
disp(' que uma pequena faixa de cor diferente aparece. O brilho percebido pela sistema optico, ')
disp(' é afetado por essa transição, onde acontece uma "suavização" nesses pontos. ')
disp(' O brilho percebido nessas transições, possui pequenos saltos (tanto pra baixo quanto pra cima), ')
disp(' (como observamos no slide da pg 41), assim mesmo que a cor seja sólida, a percepção nota uma  ')
disp(' pequena "interferencia".')

pause;
close all; 

disp('I.2.b) ');
N = 128;
[X, Y] = meshgrid(1:N, 1:N);
img = uint8(164 - (X - 1) * (23 / (N - 1)));
img2 = [img img];
figure;
subplot(1,2,1);
imshow(img);
title('128x128');
subplot(1,2,2);
imshow(img2);
title('128x256');

disp('Nesse caso, a imagem I da esquerda parece mais escura do que a imagem da direita, ')
disp(' mesmo elas sendo iguais. Esse efeito é causado devido a inibição lateral, ')
disp(' a mudança rapida de cor na borda entre as imagens faz com que as cores pareçam diferentes. ')
disp(' Onde a parte mais escura parece ainda mais escura, e a mais clara, ainda mais clara. ')

pause;
close all;

disp('I.2.c) ');
N = 256;                    
img = zeros(N, N);              
center = (N + 1) / 2;
[x, y] = meshgrid(1:N, 1:N);

% passo de 16, de 0 ate 256
L = 256:-16:16;              
levels = 0:16:256;    

% cria os quadrados baseado na coordenada do centro
for k = 1:numel(L)
    half = L(k) / 2;         
    mask = (abs(x - center) <= half) & (abs(y - center) <= half);
    img(mask) = levels(k);      
end

figure('Name', 'Quadrados', 'Position',[500,500,800,600]);
imshow(img, [0 255]);
title('Quadrados');
axis on;

disp('A imagem é formada por diversas Bandas de Mach, onde cada transição de cor ')
disp(' provoca uma ilusão de optica, todas as transições entre os quadrados,  ')
disp(' parecem ter um contraste diferente, causando um efeito que não existe na imagem ')
disp(' pois cada quadrado tem uma cor constante. Esse efeito é bem observado nas diagonais em X. ')
disp(' esse encontro de mais bordas faz com que o efeito da inibição lateral seja mais forte. ')
disp('O efeito é similar aos exercicios a e b, porém como as repetições são consecutivas,  ')
disp(' o efeito se soma visualmente. ')

pause; 
close all; 

disp('I.3) ');
disp('I.3.a) ');
M = 400;  
beta = 0.6;  
[mm, nn] = meshgrid(1:M, 1:M);
X = (256 .^ (-(M - mm) / (M - 1))) .* cos((M - 1) * beta * pi * ((49 * beta) .^ (-(M - nn) / (M - 1)) / log(49 * beta)));

figure('Name', 'Função', 'Position',[500,500,800,600]);
imshow(X, []);  
title(sprintf('Matriz X (M = %d, beta = %.2f)', M, beta));
colormap(gray);
axis image;  

pause; 

disp('I.3.b)')
disp('A 2 metros eu consigo ver a imagem, porém a região cinza (parte esquerda e parte inferior), afeta boa parte da imagem. ')
disp(' quando me aproximo do monitor, a região cinza diminui, assim consigo ver as faixas menores. ')
disp(' ao me afastar a mais de 2 metros, a região cinza aumenta, dificultando a visualização das faixas menores (parte inferior), ')
disp(' o lado esquerdo inteiro também fica dificil de enxergar. ')

pause; 

disp('I.3.c) ')
disp('Para calcular a frequencia horizontal instantanea, é preciso derivar a fase (cos) em relação a n (horizontal). ')
disp(' derivada -> b*pi(49*b)^(-(M-n)/(M-1)) ')
disp('----')
disp(' Para n=1, temos que a frequencia angular horizontal instantanea é pi/49 rad/pixel (exponencial fica -1)')
disp(' Para n=M, temos a frequencia angular horizontal instantanea de B*pi (exponencial 0), nesse caso de B=0.6, resulta em 0.6*pi rad/pixel.')
disp('----')
disp(' Para converter para ciclos/pixel é preciso dividir a frequencia angular por 2*pi: ')
disp(' Para n=1, resulta em 1/98 ciclos/pixel')
disp(' Para n=M, resulta em 0.3 ciclos/pixel')
disp('----')
disp(' Para obter ciclos/grau com distancia=20*altura (h), ')
disp(' temos que o angulo de observação é: h/distancia -> h/20h -> 1/20 rad, ou 9/pi graus')
disp(' M*pi/9, são pixels/grau. Multiplicando pela frequencia, temos: ')
disp(' Para n=1, M*pi/882')
disp(' Para n=M, M*pi/30')

pause; 

disp('I.3.d) ')
disp('Assumindo a formula da questão passada, para n=1, temos 1.4 ciclos/grau; para n=M, temos 41.9 ciclos/grau')
disp(' Existe uma limitação do sistema de sensibilidade ao contraste (do olho), que funciona quase como um filtro passa baixa.  ')
disp(' A imagem tem listras muito largas na esquerda e mais finas na direita. ')
disp('Com isso em mente, o lado esquerdo com sua baixa frequência, o olho não consegue detectar a zona de transição entre uma barra e outra')
disp(' o que gera uma grande distorção cinza. ')
disp(' conforme a frequencia aumenta, o sistema consegue detectar melhor as bordas. ')

pause; 

disp('I.3.e) ')

figure('Name', 'Função', 'Position',[500,500,800,600]);
M = 400;  
beta = 1;  
[mm, nn] = meshgrid(1:M, 1:M);
X = (256 .^ (-(M - mm) / (M - 1))) .* cos((M - 1) * beta * pi * ((49 * beta) .^ (-(M - nn) / (M - 1)) / log(49 * beta)));
subplot(1,2,1);
imshow(X, []);  
title(sprintf('Matriz X (M = %d, beta = %.2f)', M, beta));
colormap(gray);
axis image;  

M = 400;  
beta = 2;  
[mm, nn] = meshgrid(1:M, 1:M);
X = (256 .^ (-(M - mm) / (M - 1))) .* cos((M - 1) * beta * pi * ((49 * beta) .^ (-(M - nn) / (M - 1)) / log(49 * beta)));

subplot(1,2,2);
imshow(X, []);  
title(sprintf('Matriz X (M = %d, beta = %.2f)', M, beta));
colormap(gray);
axis image;  

disp('Observando as duas imagens a 2M do monitor: ')
disp(' Consigo identificar efeito de aliasing na parte direita das duas imagens, ')
disp(' com B=1, o aliasing não parece tão alto, porém com B=2, observo um aliasing mais forte')
disp(' causando até com que as linhas voltem a aumentar sua largura na direita inferior. ')

pause; 
close all;

disp('I.4)')

msize = 14;
fsize = 2*msize*msize;
A = ones(fsize,1);
b0 = zeros(1,msize);
b1 = ones(1,msize);
B = kron(b1,[b0,b1]);
X = A*B/2;
c = zeros(1,fsize);
for i=1:msize
c(2*msize*(i-1)+i) = 1;
end
y = [1:fsize];
z = exp(-(log(256)/(2.5*fsize))*(fsize-y));
Y = z'*c;
Z = X+Y;

figure('Name', 'Matriz Z', 'Position',[500,500,800,600]);
imshow(Z, []);  
colormap(gray);
axis image;  

disp('DISTANCIA NORMAL (~1m): A linha branca localizada dentro das barras pretas, se desloca da esquerda para direita, ')
disp(' quando ela está na posição central, distância maxima das bordas, tenho a percepção de ')
disp(' que ela é maior (apesar de todas serem iguais), analogamente, quando ela está muito perto ')
disp(' da borda de transição (do preto para o cinza), parece que ela ocupa apenas 20% da faixa ')
disp(' vertical. ')
disp(' Isso ocorre porque o sistema visual tem sensibilidade ao contraste, que depende da luminância de fundo.')

disp('DISTANCIA MAIOR (>2m): Assim, a percepção da linha branca fica ainda mais dificil,  observo cerca de 20% dela ')
disp(' nas faixas centrais, e nas laterais, menos ainda. ')
disp('Isso ocorre porque a frequência espacial da imagem aumenta, e a percepção depende da sensibilidade CSF.')

disp('Esse efeito pode ser chamado de "mascaramento", que também pode ser explicado pela inibição lateral,  ')
disp( ' mas também devido a percepção da frequência espacial. ')
disp('Assim tanto a linha quanto o fundo compartilham componentes de frequencia espacial, dificultando a separação. ')
pause; 
close all;

disp('II.1)')
disp('II.1.a)')

[X, Y] = meshgrid(1:401, 1:401);
centro = (401+1)/2;

Y_s = [0, 0.3, 0.5, 0.8, 1];

figure('Name', 'Cores', 'Position',[500,500,800,600]);
for i = 1:length(Y_s)
    Y_lum = Y_s(i);      
    x_norm = (X - centro) / (centro - 1);   % controla B
    y_norm = (Y - centro) / (centro - 1);   % controla R
    
    % maior distancia permitida
    k = min(Y_lum, 1 - Y_lum);
    
    % (b-Y, r-Y)
    % (Bmin - Y) = -(Bmax - Y)
    % (Rmin - Y) = -(Rmax - Y)
    r = Y_lum + k * y_norm;
    b = Y_lum + k * x_norm;

    % Y = 0.299 *r + 0.587*g + 0.114*b;
    g = (Y_lum - 0.299*r - 0.114*b) / .587; % forçado pra manter o brilho constante
    
    % nao deixa estourar (mais de 1) 
    r = min(max(r, 0), 1);
    g = min(max(g, 0), 1);
    b = min(max(b, 0), 1);
    
    RGB = cat(3, r, g, b);
    subplot(2,3,i);
    imshow(RGB);
    title(sprintf('Y = %.1f', Y_lum));
    axis on;
end

disp('Menos branco significa mais saturação. ')
pause;
close all;

disp('II.2)')
disp('II.2.a)')
img_mandrill = (imread('mandrill.tif'));
imshow(img_mandrill);

pause;
close all;

disp('II.2.b)')

img_mandrill = (imread('mandrill.tif'));
figure('Name', 'Mandrill Original', 'Position',[500,500,800,600]);
imshow(img_mandrill);

img_mandrill_yiq = rgb2ntsc(img_mandrill);
figure('Name', 'Mandrill YIQ (ntsc)', 'Position',[500,500,800,600]);
imshow(img_mandrill_yiq);

img_mandrill_ycbcr = rgb2ycbcr(img_mandrill);
figure('Name', 'Mandrill YcbCr', 'Position',[500,500,800,600]);
imshow(img_mandrill_ycbcr);

pause;
close all;

disp('II.2.c.i)')
disp('Utilizando YIQ e filtro no Y: ')
N = 9;
sigma2_values = [1, 10, 100];

% grid do kernel 9x9
[m, n] = meshgrid(-N:N, -N:N);

for i = 1:length(sigma2_values)
    sigma2 = sigma2_values(i);
    
    H = exp(-(m.^2 + n.^2) / (2 * sigma2));
    alpha = 1 / sum(H(:));  
    h = alpha * H;

    if i == 1
        disp(h)
        disp('^^^^^^ Resultado do filtro H para sigma 1 (apenas para visualização)')
    end
    
    % filtrar apenas o canal Y
    canal_y_mandrill_yiq = img_mandrill_yiq(:,:,1);
    canal_y_mandrill_yiq_filtered = filter2(h, canal_y_mandrill_yiq, 'same');
    YIQ_filtered = cat(3, canal_y_mandrill_yiq_filtered, img_mandrill_yiq(:,:,2), img_mandrill_yiq(:,:,3));
    
    figure('Name', ['Mandrill YIQ Filtered, SIGMA = ' num2str(sigma2)], 'Position',[500,500,800,600]);
    sgtitle(['Mandrill YIQ Filtered (Y), SIGMA = ' num2str(sigma2)]);
    subplot(1,2,1);
    imshow(YIQ_filtered);
    axis on;
    title('Y filtrado');
    
    subplot(1,2,2);
    imshow(img_mandrill_yiq);
    axis on;
    title('Y Original');

    pause;
end

pause;
close all;

disp('II.2.c.ii)')
disp('Utilizando YIQ e filtro no IQ: ')
N = 9;
sigma2_values = [1, 10, 100];

% grid do kernel 9x9
[m, n] = meshgrid(-N:N, -N:N);

for i = 1:length(sigma2_values)
    sigma2 = sigma2_values(i);
    
    H = exp(-(m.^2 + n.^2) / (2 * sigma2));
    alpha = 1 / sum(H(:));  
    h = alpha * H;
    
    % filtrar apenas os canais I e Q
    canal_y_mandrill_yiq = img_mandrill_yiq(:,:,1);
    canal_i_mandrill_yiq = img_mandrill_yiq(:,:,2);
    canal_q_mandrill_yiq = img_mandrill_yiq(:,:,3);

    canal_i_mandrill_yiq_filtered = filter2(h, canal_i_mandrill_yiq, 'same');
    canal_q_mandrill_yiq_filtered = filter2(h, canal_q_mandrill_yiq, 'same');

    YIQ_filtered = cat(3, canal_y_mandrill_yiq, canal_i_mandrill_yiq_filtered, canal_q_mandrill_yiq_filtered);
    
    figure('Name', ['Mandrill YIQ Filtered (IQ), SIGMA = ' num2str(sigma2)], 'Position',[500,500,800,600]);
    sgtitle(['Mandrill YIQ Filtered (IQ), SIGMA = ' num2str(sigma2)]);
    subplot(1,2,1);
    imshow(YIQ_filtered);
    axis on;
    title('Y filtrado');
    
    subplot(1,2,2);
    imshow(img_mandrill_yiq);
    axis on;
    title('Y Original');

    pause;
end

disp('COMENTARIOS SOBRE FILTRO GAUSSIANO: ')
disp(' i) ao filtrar apenas a luminância (Y), é como se filtrassemos apenas o brilho, varias texturas desaparecem, ')
disp(' enquanto as cores continuam nitidas. ')
disp(' ii) ao filtrar as crominancias (IQ) é o contrario, a textura é mantida porém as cores "diluem". ')
disp(' como se uma operação fosse o contrário da outra. ')
disp('O olho humano não processa todas informações da cena da mesma maneira. A sensibilidade dele para a luminância borrada, é muito maior')
disp(' já a sensibilidade para IQ é menor. Podemos dizer que a percepção da luminancia é mais imediata, pois o cerebro utiliza ela ')
disp(' para "enxergar as formas". ')
disp(' Acredito que a vantagem para sistemas de TV, está relacionada com o que foi explicado em aula em relação a poder transmitir uma banda menor ')
disp(' para esses canais de cores, e deixar a maior parte da banda para o canal de luminância, pois ele é mais relevante no processo de formação  ')
disp(' da imagem. ')
disp(' Pesquisei sobre e encontrei o nome de "Chroma subsampling" para essa técnica, que ainda é amplamente utilizada em transmissão de video, mesmo em outros formatos. ')

pause;
close all;

disp('II.3)')

img_mandrill = im2double(imread('mandrill.tif'));
img_cape = im2double(imread('cape.tif'));
img_trees = im2double(imread('trees.tif'));
img_clown = im2double(imread('clown.tif'));

nomes = {'Mandrill', 'Cape', 'Trees', 'Clown'};
imagens = {img_mandrill, img_cape, img_trees, img_clown};

for idx = 1:length(imagens)
    RGB = imagens{idx};
    nome = nomes{idx};
    
    R = RGB(:,:,1);
    G = RGB(:,:,2);
    B = RGB(:,:,3);
    
    % Ycbcr
    YCBCR = rgb2ycbcr(RGB);
    Y_ycbcr = YCBCR(:,:,1); 
    Cb = YCBCR(:,:,2);    
    Cr = YCBCR(:,:,3);      
    
    % YIQ
    YIQ = rgb2ntsc(RGB);
    Y_yiq = YIQ(:,:,1);          
    I = YIQ(:,:,2);             
    Q = YIQ(:,:,3);     
    
    % [0 1] remapeia para min 0 max 1
    figure('Name', ['Imagem: ' nome], 'Position', [100, 100, 900, 700]);
    subplot(3,3,1);
    imshow(R, [0 1]);
    title('R');
    
    subplot(3,3,2);
    imshow(G, [0 1]);
    title('G');
    
    subplot(3,3,3);
    imshow(B, [0 1]);
    title('B');
    
    % Ycbcr
    subplot(3,3,4);
    imshow(Y_ycbcr, []);
    title('Y');
    subplot(3,3,5);
    imshow(Cb, []);     
    title('Cb');
    subplot(3,3,6);
    imshow(Cr, []);    
    title('Cr');
    
    % yiq
    subplot(3,3,7);
    imshow(Y_yiq, [0 1]);
    title('Y');    
    subplot(3,3,8);
    imshow(I, []);      
    title('I');
    subplot(3,3,9);
    imshow(Q, []);      
    title('Q');

    pause;
    close all;   
end

disp('A primeira diferença que noto, é que o sistema RGB tem bastante redundância entre os canais, consigo identificar ')
disp(' a imagem, em todos os canais. Enquanto em YIQ e YCbCr apenas o Y tem a imagem bem definida. ')
disp('O que consigo pensar é que existe uma relação maior entre os pixeis de cada canal no RGB, do que nos outros. ')
disp('RGB: além de ser um formato bem intuitivo, facil de interpretar, não precisa de transformações para exibir na tela. ')
disp(' porém devido a sua alta redundancia, não é um formato tão eficiente para transmissões. ')
disp('YCbCr: facilidade para transmissão, devido a informação mais relevante estar concentrada em Y, podendo reduzir resolução de CbCr, ')
disp(' essa separação total de luminancia e cor que facilita. As desvantagens estão na dificil interpretabilidade, falta de intuitividade ')
disp(' para humanos, e tambem o cuidado com os números negativos. ')
disp('YIQ: similar ao YCbCr, é pouco utilizado atualmente, além de seus canais terem pouca interpretabilidade, seus eixos ')
disp(' de cores, não são alinhados com a percepção. ')
pause;
close all;
