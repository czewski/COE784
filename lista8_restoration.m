% Lista  8 - Image Restoration
clear; clc; close all; 
disp('Lista Capítulo 8 - Image Restoration')
disp('Eduardo Henrique Banaczewski')
pause; 

disp('I.1)')
img = imread('ZELDA_S.tif');
img = im2double(img);
h = (1/16) * ones(1, 16);

% h na horizontal
img_blur = imfilter(img, h, 'replicate');
figure('Name', 'Blur Horizontal - ZELDA_S', 'NumberTitle', 'off', 'Position', [100, 100, 800, 400]);

subplot(1, 2, 1);
imshow(img);
title('Original');

subplot(1, 2, 2);
imshow(img_blur);
title('Com Blur Horizontal (h = 1/16 * ones(1,16))');

pause;
close all;

disp('I.2)')

img = imread('ZELDA_S.tif');
img = im2double(img);
h = (1/16) * ones(1, 16);
img_blur = imfilter(img, h, 'replicate');

[M, N] = size(img);
H = fft2(h, M, N); 
G = fft2(img_blur);
F_hat = G ./ (H + eps); 
img_restored = real(ifft2(F_hat));

figure('Name', 'Restauração por Filtro Inverso', 'NumberTitle', 'off', 'Position', [100, 100, 1200, 400]);
subplot(1, 3, 1); imshow(img); title('Original');
subplot(1, 3, 2); imshow(img_blur); title('Com Blur Horizontal');

subplot(1, 3, 3); 
img_restored_norm = mat2gray(img_restored);
imshow(img_restored_norm); 
title('Filtro Inverso (Resultado)');

disp('A imagem fica completamente irreconhecivel apos recuperação. ')
disp('Pelo que entendi, o filtro h (passa-baixa), e a imagem no dominio da frequencia fica com valores proximos de zero, assim os erros/ruidos são amplificados, ')
disp(' ao dividir a imagem pela transformada do filtro. ')

pause;
close all;

disp('I.3)')

img = imread('ZELDA_S.tif');
img = im2double(img);

h = (1/16) * ones(1, 16);
img_blur = imfilter(img, h, 'replicate');
[M, N] = size(img);
H = fft2(h, M, N); 
G = fft2(img_blur);
limiar = 0.0001;
H_abs = abs(H);

% matriz de frequências restauradas
F_hat = zeros(size(G));

% divisão apenas onde o módulo do filtro é maior que o limiar
mask = H_abs > limiar;
F_hat(mask) = G(mask) ./ H(mask);
img_restored = real(ifft2(F_hat));

figure('Name', 'Restauração por Filtro Pseudo-Inverso', 'NumberTitle', 'off', 'Position', [100, 100, 1200, 400]);

subplot(1, 3, 1); imshow(img); title('Original');
subplot(1, 3, 2); imshow(img_blur); title('Com Blur Horizontal');

subplot(1, 3, 3); 
imshow(img_restored, []); 
title('Pseudo-Inverso');

disp('Com o filtro pseudo inverso a recuperação é consideravelmente melhor do que a anterior. ')
disp('Mas ainda com alguns artefatos. O pseudo inverso resolve o problema da divisao por valores muito baixos, adicionando a limiar. ')

pause;
close all;

disp('I.4)')
img = imread('ZELDA_S.tif');
img = im2double(img);

h = (1/16) * ones(1, 16);
img_blur = imfilter(img, h, 'replicate');
img_quant = fix(256 * img_blur) / 256;

figure('Name', 'Quantização com 256 níveis', 'NumberTitle', 'off', 'Position', [100, 100, 800, 400]);

subplot(1, 2, 1); 
imshow(img_blur); 
title('Imagem com Blur (Antes da Quantização)');

subplot(1, 2, 2); 
imshow(img_quant); 
title('Imagem Quantizada (256 níveis)');

pause;
close all;

disp('I.5)')

[M, N] = size(img);
H = fft2(h, M, N);
G = fft2(img_quant);
F_hat = G ./ (H + eps);
img_restored = real(ifft2(F_hat));

figure('Name', 'Filtro Inverso em Imagem Quantizada', 'NumberTitle', 'off', 'Position', [100, 100, 1200, 400]);

subplot(1, 3, 1); 
imshow(img_blur, []); 
title('Blur Original (Contínuo)');

subplot(1, 3, 2); 
imshow(img_quant, []); 
title('Blur Quantizado (256 níveis)');

subplot(1, 3, 3); 
imshow(img_restored, []); 
title('Filtro Inverso na Quantizada');

disp('A quantização introduz um pequeno erro, que é propagado mais ainda no processo. ')

pause;
close all;

disp('I.6)')

img = imread('ZELDA_S.tif');
img = im2double(img);

h = (1/16) * ones(1, 16);
img_blur = imfilter(img, h, 'replicate');

% quantiza
img_quant = fix(256 * img_blur) / 256;
[M, N] = size(img);

% FFT
H = fft2(h, M, N);
H_abs = abs(H);
G = fft2(img_quant);
limiar = 0.0001;

% frequências restauradas
F_hat = zeros(size(G));
mask = H_abs > limiar;
F_hat(mask) = G(mask) ./ H(mask);
img_restored = real(ifft2(F_hat));

figure('Name', 'Filtro Pseudo-Inverso em Imagem Quantizada', 'NumberTitle', 'off', 'Position', [100, 100, 1200, 400]);

subplot(1, 4, 1); imshow(img, []); title('Original');
subplot(1, 4, 2); imshow(img_blur, []); title('Blur Contínuo');
subplot(1, 4, 3); imshow(img_quant, []); title('Blur Quantizado');
subplot(1, 4, 4); imshow(img_restored, []); title('Pseudo-Inverso na Quantizada');

disp('A mesma ideia de usar o filtro pseudo-inverso para reduzir o erro propagado. ')

pause;
close all;

disp('I.7)')

img = imread('ZELDA_S.tif');
img = im2double(img);

h = (1/16) * ones(1, 16); 
img_blur = imfilter(img, h, 'replicate');
img_quant = fix(256 * img_blur) / 256;

% Filtro de Wiener
[M, N] = size(img);
A = 1/256;
noise_var = (A^2) / 12; 
sigma_f2 = var(img(:)); 

H = fft2(h, M, N);       % FFT do filtro de blur
G = fft2(img_quant);     % FFT da imagem degradada

p_values = [0.95, 0.7, 0.5, 0.1, -0.5];
figure('Name', 'p no Filtro de Wiener', 'NumberTitle', 'off', 'Position', [50, 50, 1400, 600]);
subplot(2, 3, 1); imshow(img_quant, []); title('Imagem Degradada (Input)');

for idx = 1:length(p_values)
    p = p_values(idx);
    
    % rho_v = rho_h = p
    rho_v = p;
    rho_h = p;
    
    % PSD
    [U, V] = meshgrid(0:N-1, 0:M-1);
    
    % autocovariância separável: r(m,n) = sigma^2 * p^|m| * p^|n|
    % PSD 1D para cada direção
    Su = (1 - rho_v^2) ./ (1 - 2*rho_v*cos(2*pi*U/N) + rho_v^2);
    Sv = (1 - rho_h^2) ./ (1 - 2*rho_h*cos(2*pi*V/M) + rho_h^2);
    Sf = sigma_f2 * Su .* Sv; % PSD 2D da imagem original
    
    % Filtro de Wiener no domínio da frequência
    F_hat = (conj(H) ./ (abs(H).^2 + (noise_var ./ (Sf + eps)))) .* G;
    img_wiener = real(ifft2(F_hat));
    
    subplot(2, 3, idx + 1);
    imshow(img_wiener, []);
    title(sprintf('Filtro de Wiener (p = %.2f)', p));
end

disp('O filtro wiener é bastante sensivel ao parametro p do modelo adotado, o valor de 0.95 tem o resultado melhor entre os fornecidos. ')
disp(' Um p muito baixo ou negativo ou muito alto causa amplificação do ruido. ')
pause;
close all;

disp('II')
disp('II.a)')

img = imread('ZELDA_S.tif');
img = im2double(img);

variancias = [0.003, 0.01];
h1d = conv([1/2 1/2], [1/2 1/2]);
h2d = h1d' * h1d;

for i = 1:length(variancias)
    var_val = variancias(i);
    img_noisy = imnoise(img, 'gaussian', 0, var_val);
    
    % c) filtro linear separável
    img_linear = imfilter(img_noisy, h2d, 'replicate');
    
    % d) filtro de Wiener adaptativo 3x3
    img_wiener = wiener2(img_noisy, [3 3]);
    
    figure('Name', sprintf('Ruído Gaussiano (Variância = %.3f)', var_val), ...
           'NumberTitle', 'off', 'Position', [100, 100, 1200, 400]);
    
    subplot(1, 4, 1); imshow(img, []); title('Original');
    subplot(1, 4, 2); imshow(img_noisy, []); title('Com Ruído');
    subplot(1, 4, 3); imshow(img_linear, []); title('Filtro Linear (c)');
    subplot(1, 4, 4); imshow(img_wiener, []); title('Filtro de Wiener (d)');
end

disp('para as imagens corrompidas só com ruido, o wiener é melhor, equilibrando a troca entre remocao de ruido e preservando as bordas (melhor com variancia 0.003). ')

pause;
close all;

disp('III)')

images = {'ZELDA_S.tif', 'XRAY.tif'};
names = {'ZELDA_S', 'XRAY'};
h1d = conv([1/2 1/2], [1/2 1/2]); 
h2d = h1d' * h1d;                

for i = 1:length(images)
    img = imread(images{i});
    img = im2double(img);
    
    % (a) "speckle" (multiplicativo) com variância 0.04
    img_noisy = imnoise(img, 'speckle', 0.04);
    
    % (b) filtro linear definido em I.c
    img_linear = imfilter(img_noisy, h2d, 'replicate');
    
    % (c) Homomórfica (Linear)
    img_log = log(1 + img_noisy);
    img_log_filt = imfilter(img_log, h2d, 'replicate');
    img_homo_linear = exp(img_log_filt) - 1; % Logaritmo inverso
    
    % (d) Wiener adaptativo 3x3
    img_wiener = wiener2(img_noisy, [3 3]);
    
    % (e) Homomórfica de Wiener
    img_log_wiener = wiener2(img_log, [3 3]);
    img_homo_wiener = exp(img_log_wiener) - 1;
    
    figure('Name', ['Ruído Speckle e Restauração: ', names{i}], ...
           'NumberTitle', 'off', 'Position', [50, 50, 1400, 500]);
       
    subplot(2, 3, 1); imshow(img, []); title('Original');
    subplot(2, 3, 2); imshow(img_noisy, []); title('Com Speckle (var=0.04)');
    subplot(2, 3, 3); imshow(img_linear, []); title('(b) Filtro Linear');
    subplot(2, 3, 4); imshow(img_homo_linear, []); title('(c) Homomórfico Linear');
    subplot(2, 3, 5); imshow(img_wiener, []); title('(d) Wiener Direto');
    subplot(2, 3, 6); imshow(img_homo_wiener, []); title('(e) Homomórfico Wiener');
end

disp('Para o ruido speckle, o filtro homomórfica é essencial pra remover o ruido, tanto linear quanto wiener. ')
disp('O uso do log altera o ruido de multiplicativo pra aditivo, permitindo que o filtro Wiener funcione melhor. ')
disp('Ordem de qualidade: e -> c -> d -> b')

pause;
close all;


