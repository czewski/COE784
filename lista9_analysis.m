% Lista  9 - Image Analysis
clear; clc; close all; 
disp('Lista Capítulo 9 - Image Analysis')
disp('Eduardo Henrique Banaczewski')
pause; 

disp('I)')
imagens = {'SQUARE.tif', 'CIRCLE.tif', 'TRIANG.tif', 'BARD1.tif', 'BARD2.tif', 'JOTAV.tif', 'JOTAD.tif'};
for i = 1:length(imagens)
    img = imread(imagens{i});
    img = im2double(img);
    
    % b) Calcular a DFT
    F = fft2(img);                 % Transformada de Fourier 2D
    F_shifted = fftshift(F);       % Centraliza a frequência zero
    magnitude = abs(F_shifted);    % Módulo da transformada
    espectro = log(magnitude + 1);

    figure('Name', ['Formas no Domínio da Frequência: ', imagens{i}], ...
           'NumberTitle', 'off', 'Position', [100, 100, 800, 400]);
       
    subplot(1, 2, 1);
    imshow(img, []);
    title(['Imagem Original: ', imagens{i}]);
    
    subplot(1, 2, 2);
    imagesc(espectro);
    colormap(gray);
    axis image off;
    title('DFT (log(1 + |F|))');
    colorbar;
end

disp('As formas sólidas com cores preto e branco, possuem espectros com padrões relacionadas/repetidos. ')
disp(' retangulo: gera padrão em cruz ao longos dos eixos.')
disp(' circulo: é radialmente simetrico, gera um espectro com radiais simetricas')
disp(' as letras: tem os espectros mais espalhados e menos simétricos, que refletem a orientação e bordas. ')

pause;
close all;

disp('II.1)')
img = imread('SHUTTLE.tif');
img = im2double(img);

metodos = {'roberts', 'prewitt', 'sobel', 'log', 'canny'};
nomes_metodos = {'Roberts', 'Prewitt', 'Sobel', 'Laplacian of Gaussian', 'Canny'};

for i = 1:length(metodos)
    metodo = metodos{i};
    nome = nomes_metodos{i};
    
    % tolerância de ruído automaticamente
    [~, thresh] = edge(img, metodo);
    
    % limiar automático
    BW_auto = edge(img, metodo, thresh);
    
    % metade do limiar
    BW_half = edge(img, metodo, thresh / 2);
    
    % dobro do limiar
    BW_double = edge(img, metodo, thresh * 2);
    
    figure('Name', ['Detecção de Arestas: ', nome], 'NumberTitle', 'off', ...
           'Position', [50, 50, 1200, 300]);
       
    subplot(1, 4, 1); imshow(img, []); title('Original');
    
    subplot(1, 4, 2); imshow(BW_auto); 
    title(sprintf('Auto (T = %.4f)', thresh(1)));
    
    subplot(1, 4, 3); imshow(BW_half); 
    title(sprintf('Metade (T = %.4f)', thresh(1)/2));
    
    subplot(1, 4, 4); imshow(BW_double); 
    title(sprintf('Dobro (T = %.4f)', thresh(1)*2));
end

disp('Reduzir o limiar, a via de regra detecta mais bordas. ')
disp('Entre os métodos Reoberts, prewit e sobel, sao mais sensiveis a ruido. ')
disp('Log gera contornos fechados mas pode acabar duplicando bordas proximas.; ')
disp('Canny possui um resultado um pouco melhor, com bordas finas e conectadas. ')

pause; 
close all;

disp('II.2)')

imagens = {'SHUTTLE.tif', 'ZELDA_S.tif'};
nomes = {'SHUTTLE', 'ZELDA_S'};

H1 = [-1 0 1; -1 0 1; -1 0 1]; 
H2 = [-1 -1 -1; 0 0 0; 1 1 1]; 
H_45    = [0 1 1; -1 0 1; -1 -1 0]; 
H_neg45 = [-1 -1 0; -1 0 1; 0 1 1]; 

for i = 1:length(imagens)
    img = imread(imagens{i});
    img = im2double(img);
    
    g_x = imfilter(img, H1, 'replicate'); % Resposta ao H1 (vertical)
    g_y = imfilter(img, H2, 'replicate'); % Resposta ao H2 (horizontal)
    g_45    = imfilter(img, H_45, 'replicate');
    g_neg45 = imfilter(img, H_neg45, 'replicate');
    g_iso = sqrt(g_x.^2 + g_y.^2);
    
    [BW_auto, ~] = edge(img, 'prewitt');
    
    figure('Name', ['Prewitt Manual (Tabela 9.2): ', nomes{i}], ...
           'NumberTitle', 'off', 'Position', [50, 50, 1400, 600]);
       
    subplot(2, 4, 1); imshow(img, []); title('Original');
    
    % Exibindo o valor absoluto e normalizando para visualização
    subplot(2, 4, 2); imshow(mat2gray(abs(g_x))); title('H_1 (Vertical)');
    subplot(2, 4, 3); imshow(mat2gray(abs(g_y))); title('H_2 (Horizontal)');
    subplot(2, 4, 4); imshow(mat2gray(abs(g_45))); title('+45^\circ');
    
    subplot(2, 4, 5); imshow(mat2gray(abs(g_neg45))); title('-45^\circ');
    subplot(2, 4, 6); imshow(mat2gray(g_iso)); title('Isotrópico (Mag. Grad)');
    subplot(2, 4, 7); imshow(BW_auto); title('Item 1b (edge automático)');
    
    sgtitle(['Detecção de Arestas - Prewitt: ', nomes{i}]);
end


disp('Usando as máscaras das tabelas: as bordas são mais espessas, pois o gradiente ao redor da transição é realçado. ')

pause;
close all;

disp('II.3)')

img = imread('ZELDA_S.tif');
img = im2double(img);

% Horizontal 
H_horiz = [ 5  5  5; 
           -3  0 -3; 
           -3 -3 -3];

% Vertical 
H_vert  = [-3 -3  5; 
           -3  0  5; 
           -3 -3  5];

% +45 graus 
H_45    = [-3  5  5; 
           -3  0  5; 
           -3 -3 -3];

% -45 graus 
H_neg45 = [ 5  5 -3; 
            5  0 -3; 
           -3 -3 -3];

g_horiz = imfilter(img, H_horiz, 'replicate');
g_vert  = imfilter(img, H_vert, 'replicate');
g_45    = imfilter(img, H_45, 'replicate');
g_neg45 = imfilter(img, H_neg45, 'replicate');


figure('Name', 'Operador de Kirsch - ZELDA_S', 'NumberTitle', 'off', ...
       'Position', [50, 50, 1200, 600]);

subplot(2, 3, 1); imshow(img, []); title('Original');
subplot(2, 3, 2); imshow(mat2gray(abs(g_horiz))); title('Kirsch Horizontal');
subplot(2, 3, 3); imshow(mat2gray(abs(g_vert))); title('Kirsch Vertical');
subplot(2, 3, 5); imshow(mat2gray(abs(g_45))); title('Kirsch +45^\circ');
subplot(2, 3, 6); imshow(mat2gray(abs(g_neg45))); title('Kirsch -45^\circ');

sgtitle('Detecção de Arestas - Operador de Kirsch');

disp('Com o peso maior das mascaras de Kirsch (5, -3), as bordas tendem a serem realçadas (o ruido tambem) ')
disp('Os padrões são semelhantes com Prewitt, porém assimetricos entre os pixeis centrais e vizinhos, o que pode acentuar as bordas em diferentes direções.')

pause;
close all;

disp('III')

imagens = {'SQUARE', 'TRIANG', 'CIRCLE', 'JOTAV', 'HARDWARE', 'CIRCBW'};
se = [1 1 1; 1 1 1; 1 1 1];

for i = 1:length(imagens)
    filename = [imagens{i}, '.tif'];
    I = imread(filename);
    X = im2bw(I);
    
    if strcmp(imagens{i}, 'HARDWARE')
        X = 1 - X; 
    end
    
    eroded = imerode(X, se);
    dilated = imdilate(X, se);
    
    % a) Hit-miss (Transformada Hit-or-Miss)
    B1 = [0 1 0; 1 1 1; 0 1 0]; 
    B2 = [1 0 1; 0 0 0; 1 0 1]; 
    hit_miss = imerode(X, B1) & imerode(~X, B2);
    
    % b) Open 
    opened = imdilate(eroded, se);
    
    % c) Close 
    closed = imerode(dilated, se);
    
    % d) Boundary (Contorno): Original menos a Erosão
    boundary = X & ~eroded;
    
    figure('Name', ['Operações Morfológicas: ', imagens{i}], ...
           'NumberTitle', 'off', 'Position', [50, 50, 1400, 600]);
       
    subplot(2, 4, 1); imshow(X); title('Original Binária');
    subplot(2, 4, 2); imshow(eroded); title('Erosão');
    subplot(2, 4, 3); imshow(dilated); title('Dilatação');
    subplot(2, 4, 4); imshow(hit_miss); title('Hit-miss');
    
    subplot(2, 4, 5); imshow(opened); title('Open (Abertura)');
    subplot(2, 4, 6); imshow(closed); title('Close (Fechamento)');
    subplot(2, 4, 7); imshow(boundary); title('Boundary (Contorno)');
    
    sgtitle(['Morfologia - ', imagens{i}]);
end
pause;
close all;
