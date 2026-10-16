% Lista 5 - Image Transforms
clear; clc; close all; 
disp('Lista Capítulo 7 - Image Enhancement')
disp('Eduardo Henrique Banaczewski')
pause; 

disp('I.1) ')
image_names = {'TEXT2', 'POLLENS', 'INSETO', 'HARDWARE'};
betas = [50, 75, 100, 150, 200];

for i = 1:length(image_names)
    filename = [image_names{i}, '.tif']; 
    img = imread(filename);
    img_gray = img;

    figure('Name', ['Thresholding: ', image_names{i}], 'NumberTitle', 'off');

    subplot(2, 3, 1);
    imshow(img_gray);
    title('Original');
    

    for j = 1:length(betas)
        beta = betas(j);
        img_thresh = img_gray;
        
        img_thresh(img_gray <= beta) = 0;
        img_thresh(img_gray > beta) = 255;
        
        subplot(2, 3, j+1);
        imshow(img_thresh);
        title(['\beta = ', num2str(beta)]);
    end
end

pause;
close all;

disp('I.2)')
img = imread('HARDWARE.tif');
img_gray = img;
img_double = double(img_gray);

r1 = 70;   % r1: Limite inferior da faixa de intensidade que você quer expandir 
s1 = 0;   % s1: Novo valor para r1
r2 = 150;  % r2: Limite superior da faixa de intensidade 
s2 = 255;  % s2: Novo valor para r2 
r = 0:255;
s = zeros(1, 256);

for i = 1:length(r)
    if r(i) <= r1
        % reta de (0,0) até (r1, s1)
        s(i) = (s1 / r1) * r(i);
    elseif r(i) <= r2
        % reta de (r1, s1) até (r2, s2) - REGIÃO DE EXPANSÃO
        s(i) = ((s2 - s1) / (r2 - r1)) * (r(i) - r1) + s1;
    else
        % reta de (r2, s2) até (255, 255)
        s(i) = ((255 - s2) / (255 - r2)) * (r(i) - r2) + s2;
    end
end

s = uint8(max(0, min(255, s)));
img_expandida = intlut(img_gray, s);
figure('Name', 'Expansão de Contraste - HARDWARE', 'NumberTitle', 'off');

subplot(2, 2, 1);
imshow(img_gray);
title('Imagem Original');
subplot(2, 2, 2);
imhist(img_gray);
title('Histograma Original');
subplot(2, 2, 3);
plot(0:255, s, 'LineWidth', 2);
title('Função de Transformação (2 partes)');
xlabel('Intensidade de Entrada (r)');
ylabel('Intensidade de Saída (s)');
grid on;
xlim([0 255]);
ylim([0 255]);

subplot(2, 2, 4);
imshow(img_expandida);
title('Imagem com Contraste Expandido');


pause;
close all;

disp('I.3)')
images = {'XRAY', 'BACTERIA2', 'GALAXY', 'HARDWARE'};

for i = 1:length(images)
    filename = [images{i}, '.tif'];
    img = imread(filename);
    img_eq = histeq(img);
    
    figure('Name', ['Equalização: ', images{i}], 'NumberTitle', 'off');
    subplot(2, 2, 1); imshow(img); title('Original');
    subplot(2, 2, 2); imhist(img); title('Histograma Original');
    subplot(2, 2, 3); imshow(img_eq); title('Equalizada');
    subplot(2, 2, 4); imhist(img_eq); title('Histograma Equalizado');
end

disp('HARWARE: Na expansão de contraste, é possível controlar o nível de de tons das roscas, enquanto mantem o fundo e outras estruturas. ')
disp(', na equalização, o fundo é afetado também, ficando completamente cinza, pq o pico de cinza foi dissolvido ao longo da imagem. ')

disp('A equalização funciona melhor para imagens mais uniformes, ssem algum objeto especifico para isolar, com baixo contraste geral. (XRAY, GALAXY) ')
disp('Já a expansão, funciona bem quando o objeto é conhecido, podendo realçar ele com niveis controlados. (HARDWARE)')

pause;
close all;

disp('II.1)')

img_zelda = imread('ZELDA_S.tif');
img_xray = imread('XRAY.tif');

img_zelda = im2double(img_zelda);
img_xray = im2double(img_xray);

f1 = (1/9) * ones(3,3);
f2 = (4/3) * [0, 1/8, 0; 1/8, 1/4, 1/8; 0, 1/8, 0];

h = conv([1/2, 1/2], [1/2, 1/2]); % h = [1/4, 1/2, 1/4]
v = conv(h, h);                   % v = [1/16, 1/4, 3/8, 1/4, 1/16]
f3 = v' * v;                

variances = [0.003, 0.01];
images = {img_zelda, img_xray};
image_names = {'ZELDA_S', 'XRAY'};

for i = 1:length(images)
    img = images{i};
    name = image_names{i};
    
    for v_idx = 1:length(variances)
        var_val = variances(v_idx);
        
        % ruido gaussiano 
        img_noisy = imnoise(img, 'gaussian', 0, var_val);
        
        % filtro imagem original
        img_f1_orig = imfilter(img, f1, 'replicate');
        img_f2_orig = imfilter(img, f2, 'replicate');
        img_f3_orig = imfilter(img, f3, 'replicate');
        
        % imagem com ruído
        img_f1_noisy = imfilter(img_noisy, f1, 'replicate');
        img_f2_noisy = imfilter(img_noisy, f2, 'replicate');
        img_f3_noisy = imfilter(img_noisy, f3, 'replicate');
        
        figure('Name', sprintf('%s - Variância = %.3f', name, var_val), 'NumberTitle', 'off');
        subplot(2, 4, 1); imshow(img, []); title('Original');
        subplot(2, 4, 2); imshow(img_f1_orig, []); title('Orig + f1');
        subplot(2, 4, 3); imshow(img_f2_orig, []); title('Orig + f2');
        subplot(2, 4, 4); imshow(img_f3_orig, []); title('Orig + f3');
        
        subplot(2, 4, 5); imshow(img_noisy, []); title('Com Ruído');
        subplot(2, 4, 6); imshow(img_f1_noisy, []); title('Ruído + f1');
        subplot(2, 4, 7); imshow(img_f2_noisy, []); title('Ruído + f2');
        subplot(2, 4, 8); imshow(img_f3_noisy, []); title('Ruído + f3');
    end
end

pause;
close all;

disp('II.2)')
f2 = (4/3) * [0, 1/8, 0; 1/8, 1/4, 1/8; 0, 1/8, 0];
h = conv([1/2, 1/2], [1/2, 1/2]); % h = [1/4, 1/2, 1/4]
v = conv(h, h);                   % v = [1/16, 1/4, 3/8, 1/4, 1/16]
f3 = v' * v;                      % Filtro de suavização 5x5

images = {'ZELDA_S.tif', 'XRAY.tif'};
names = {'ZELDA_S', 'XRAY'};

for k = 1:length(images)
    img = im2double(imread(images{k}));
    img_sp = imnoise(img, 'salt & pepper', 0.05);
    
    % ruido gauss
    img_g1 = imnoise(img, 'gaussian', 0, 0.003);
    img_g2 = imnoise(img, 'gaussian', 0, 0.01);
    
    inputs = {img, img_sp, img_g1, img_g2};
    input_titles = {'Original', 'Ruído S&P (0.05)', 'Gauss (var=0.003)', 'Gauss (var=0.01)'};
    
    figure('Name', ['Filtragem por Medianas: ', names{k}], 'NumberTitle', 'off', 'Position', [100, 50, 1200, 900]);
    for row = 1:4
        noisy_img = inputs{row};
        
        % b - filtros
        filtered_f2 = imfilter(noisy_img, f2, 'replicate');
        filtered_f3 = imfilter(noisy_img, f3, 'replicate');
        filtered_med = medfilt2(noisy_img, [3 3]);
        
        subplot(4, 4, (row-1)*4 + 1);
        imshow(noisy_img, []);
        title(input_titles{row});
        
        subplot(4, 4, (row-1)*4 + 2);
        imshow(filtered_f2, []);
        title(['f2 em ', input_titles{row}]);
        
        subplot(4, 4, (row-1)*4 + 3);
        imshow(filtered_f3, []);
        title(['f3 em ', input_titles{row}]);
        
        subplot(4, 4, (row-1)*4 + 4);
        imshow(filtered_med, []);
        title(['Mediana em ', input_titles{row}]);
    end
end

disp('Consigo observar que a mediana na segunda linha (Salt and Pepper) remove muito bem o ruido. Já os filtros f2/f3 deixam borroes ao longo da imagem. ')
disp('Para o ruído gaussiano, o filtro f3 obtem o resultado mais proximo da imagem original, pois afetas todos pixeis da imagem de forma uniforme.  ')

pause;
close all;

disp('II.3) ')
f1 = (1/9) * ones(3,3); 
lambdas = [0.5, 1, 2, 4, 8, 16];
images = {'ZELDA_S.tif', 'XRAY.tif', 'BACTERIA1_CROP.tif', 'INFLAMACAO.tif'};

for k = 1:length(images)
    X = im2double(imread(images{k}));
    Y = imfilter(X, f1, 'replicate');
    

    figure('Name', ['Crispening: ', images{k}], 'NumberTitle', 'off', 'Position', [100, 100, 1200, 500]);
    subplot(2, 4, 1); imshow(X, []); title('Original (X)');
    subplot(2, 4, 2); imshow(Y, []); title('Passa-baixas (Y)');
    
    % fórmula Z = X + lambda * (X - Y)
    for j = 1:length(lambdas)
        lambda = lambdas(j);
        
        Z = X + lambda * (X - Y);
        Z = max(0, min(1, Z));
        
        subplot(2, 4, j+2);
        imshow(Z, []);
        title(['\lambda = ', num2str(lambda)]);
    end
end

disp('Valores baixos de lambda destacam um pouco as bordas, de maneira suave. Com lambdas maiores o contraste e nitidez aumentam, ')
disp(' porem tambem fazem com que o ruido aumente consideravalmente, principalmente em lambda=16. ')

pause;
close all;

disp('II.4)')
Fs = {[0.0 0.4 0.6 1.0], [0.0 0.4 0.6 1.0], [0.0 0.2 0.3 0.7 0.8 1.0]};
As = {[1 1 0 0], [0 0 1 1], [1 1 0 0 1 1]};
nomes_filtro = {'Filtro 1 (Passa-Baixas)', 'Filtro 2 (Passa-Altas)', 'Filtro 3 (Multibanda)'};

h_filtros = cell(1,3);
H_2D = cell(1,3);

for i = 1:3
    h_filtros{i} = remez(10, Fs{i}, As{i}); 
    [H, w] = freqz(h_filtros{i}, 1, 512);
    
    figure('Name', ['Q4 - Resposta 1D - ' nomes_filtro{i}], 'NumberTitle', 'off');
    plot(w/pi, abs(H), 'LineWidth', 2); grid on;
    xlabel('Frequência normalizada (\times \pi rad/amostra)');
    ylabel('|H(e^{j\omega})|');
    title(['Resposta em frequência 1D - ' nomes_filtro{i}]);
    ylim([0 1.2]);

    H_2D{i} = h_filtros{i} * h_filtros{i}';
end


figure('Name', 'Resposta em Frequência 2D dos Filtros', 'NumberTitle', 'off');
for i = 1:3
    subplot(1, 3, i);
    freqz2(H_2D{i}, 128, 128); 
    title(nomes_filtro{i});
    xlabel('Freq. Normalizada (f_x)'); 
    ylabel('Freq. Normalizada (f_y)'); 
    zlabel('Magnitude');
    axis([-1 1 -1 1 0 1.2]); 
end

images = {'LENA256.tif', 'BUILDING.tif', 'HARDWARE.tif'};
names = {'LENA256', 'BUILDING', 'HARDWARE'};

for i = 1:length(images)
    img = imread(images{i});
    img = im2double(img);
    
    img_f1 = imfilter(img, H_2D{1}, 'replicate');
    img_f2 = imfilter(img, H_2D{2}, 'replicate');
    img_f3 = imfilter(img, H_2D{3}, 'replicate');
    
    img_f1 = max(0, min(1, img_f1));
    img_f2 = max(0, min(1, img_f2));
    img_f3 = max(0, min(1, img_f3));
    
    figure('Name', ['Filtragem: ', names{i}], 'NumberTitle', 'off', 'Position', [100, 100, 1000, 800]);
    subplot(2, 2, 1); imshow(img, []); title('Original');
    subplot(2, 2, 2); imshow(img_f1, []); title('Filtro 1 (Passa-Baixas)');
    subplot(2, 2, 3); imshow(img_f2, []); title('Filtro 2 (Passa-Altas)');
    subplot(2, 2, 4); imshow(img_f3, []); title('Filtro 3 (Multibanda)');
end

pause;
close all;

disp('II.5)')
images = {'HARDWARE.tif', 'BACTERIA2.tif'};
names = {'HARDWARE', 'BACTERIA2'};

for i = 1:length(images)
    img = imread(images{i});
    img = im2double(img);
    
    % desvio = raiz quadrada da variância
    calc_sigma = @(x) sqrt(var(x(:)));
    
    % nlfilter aplica a função calc_sigma a cada bloco 3x3 da imagem
    sigma = nlfilter(img, [3 3], calc_sigma);
    sigma(sigma == 0) = eps;
    
    % x(m,n) / sigma(m,n)
    img_out = img ./ sigma;
    img_out_norm = mat2gray(img_out);
    
    figure('Name', ['Filtro Não Linear: ', names{i}], 'NumberTitle', 'off', 'Position', [100, 100, 1000, 400]); 
    subplot(1, 3, 1); imshow(img, []); title('Original');
    subplot(1, 3, 2); imshow(sigma, []); title('Mapa de Desvio Padrão (\sigma)');
    subplot(1, 3, 3); imshow(img_out_norm, []); title('Resultado: x / \sigma');
end

disp('Um comportamento bem diferente para as duas imagens, na imagem HARDWARE, tem um destaque completo do parafuso e do fundo. ')
disp('Já na imagem BACTERIA2, o ruído toma conta da imagem, distorcendo completamente. (em x/sigma)')
disp('Onde tem atenuação de bordas (desvio alto), faz com que a divisao x/sigma, resulta em valores baixos, distorcendo bordas. ')

pause;
close all;

disp('III.1)')
images = {'ZELDA_S.tif', 'TEXT.tif'};
names = {'ZELDA_S', 'TEXT'};
k_values = [96, 128];

for idx = 1:length(images)
    img_orig = imread(images{idx});
    img_orig = im2double(img_orig);
    
    % ruido gaussiano (média 0, variância 0.003)
    img_noisy = imnoise(img_orig, 'gaussian', 0, 0.003);
    inputs = {img_orig, img_noisy};
    input_titles = {'Original', 'Com Ruído (var=0.003)'};
    
    for in_idx = 1:2
        img_in = inputs{in_idx};
        
        % DCT da imagem inteira
        D = dct2(img_in);
        
        figure('Name', sprintf('Filtragem DCT: %s - %s', names{idx}, input_titles{in_idx}), ...
               'NumberTitle', 'off', 'Position', [100, 100, 1200, 600]);
        
        subplot(1, 3, 1); imshow(img_in, []); title(input_titles{in_idx});
        
        for k_idx = 1:length(k_values)
            k = k_values(k_idx);
            
            % b) Zerar os coeficientes da DCT, zerando linha + coluna <= k + 1
            [rows, cols] = size(D);
            [J, I] = meshgrid(1:cols, 1:rows);
            mask = (I + J) <= (k + 1);
            D_filtered = D .* mask;
            
            % c) DCT inversa
            img_out = idct2(D_filtered);
            
            subplot(1, 3, k_idx + 1);
            imshow(img_out, []);
            title(sprintf('DCT Filtrada (k = %d)', k));
        end
    end
end

disp('A filtragem com a DCT produz um efeito visualmente pior do que a filtragem linear, pois introduz artefatos. ')
disp(' Na filtragem linear, o efeito é mais suave ao longo da imagem inteira. Já na DCT é mais abrupta, introduzindo efeitos de anel. ')

disp(' Para minimizar esse efeito da DCT, K pode ser aumentado, para preservar mais coeficientes. ')

pause;
close all;

disp('III.2)')

images = {'ZELDA_S.tif', 'INSETO.tif', 'POLLENS.tif'};
names = {'ZELDA_S', 'INSETO', 'POLLENS'};
alphas = [0, 0.5, 0.7];

for idx = 1:length(images)
    img = imread(images{idx});
    img = im2double(img);
    
    % a) fourier bi-dimensional
    F = fft2(img);
    M = abs(F);
    Theta = angle(F);
    
    figure('Name', ['Filtragem por Raiz: ', names{idx}], 'NumberTitle', 'off', 'Position', [100, 100, 1200, 400]);
    subplot(1, 4, 1); imshow(img, []); title('Original');
    
    for a_idx = 1:length(alphas)
        alpha = alphas(a_idx);
        
        % b) Z
        Z = (M .^ alpha) .* exp(1i * Theta);
        W = real(ifft2(Z)); 
        
        % c) W 
        subplot(1, 4, a_idx + 1);
        imagesc(W + 0.5);
        colormap(gray);
        axis image off;
        title(['\alpha = ', num2str(alpha)]);
        colorbar;
    end
end

disp('Nesse caso quanto mais baixo o alfa, mais a magnitude é visivel, com alfa baixo, sobra só informação de fase.  ')

pause;
close all;

disp('III.3)')

images = {'ZELDA_S.tif', 'INSETO.tif', 'POLLENS.tif'};
names = {'ZELDA_S', 'INSETO', 'POLLENS'};

for idx = 1:length(images)
    img = imread(images{idx});
    img = im2double(img);
    
    % a) fourier bi-dimensional
    F = fft2(img);
    M = abs(F);
    Theta = angle(F);
    
    % Z 
    Z = log(1 + M) .* exp(1i * Theta);
    
    % W
    W = real(ifft2(Z));
    
    % c) Exibir W usando imagesc(W + 0.5)
    figure('Name', ['Cepstrum: ', names{idx}], 'NumberTitle', 'off', 'Position', [100, 100, 500, 500]);
    imagesc(W + 0.5);
    colormap(gray);
    axis image off;
    title(['Cepstrum (W + 0.5) - ', names{idx}]);
    colorbar;
end

disp('Utilizando este Z, existe um pico de concentracao no centro, o log reduz a faixa dinamica do espectro. ')
disp('Consigo perceber um ruido estruturado na imagem de Zelda. ')

pause;
close all;

disp('III.4)')

imagens_q4_3 = {'XRAY.tif', 'EOSINOFILO.tif', 'BACTERIA1_CROP.tif', 'POLLENS.tif', 'GALAXY.tif'};
colormaps_q4 = {'jet', 'hot', 'flag', 'prism'};
niveis_q4    = [10, 32, 64, 256];  

for i = 1:length(imagens_q4_3)
    nome = imagens_q4_3{i};
    I = imread(nome);
    
    if size(I,3) == 3
        I = rgb2gray(I);
    end

    figure('Name', sprintf('Q4 - Pseudo-cor: %s', nome), 'NumberTitle', 'off', ...
           'Position', [50, 50, 1200, 800]);
    
    plot_idx = 1;

    for r = 1:length(colormaps_q4)
        cmap_nome = colormaps_q4{r};
        
        for c = 1:length(niveis_q4)
            n_niveis = niveis_q4(c);
            
            subplot(length(colormaps_q4), length(niveis_q4), plot_idx);
            
            imshow(I);                                  
            colormap(gca, feval(cmap_nome, n_niveis)); 
            colorbar;
            title(sprintf('%s (%d níveis)', cmap_nome, n_niveis));
            
            plot_idx = plot_idx + 1;
        end
    end
end

disp('A distinção entre as variações nos objetos ficam mais definidas utilizando pseudo-cor.')
disp(' Dependendo do colormap utilizado, diferentes partes da imagem são destacados. ')

pause;
close all;

