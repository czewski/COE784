% Lista 5 - Image Transforms
clear; clc; close all; 
disp('Lista Capítulo 5 - Image Transforms')
disp('Eduardo Henrique Banaczewski')
pause; 

disp('I) ')
N = 8;
disp('I.a)')
for i = 1:N
    for j = 1:N
        E = zeros(N,N);
        E(i,j) = 1;
        
        B = idct2(E);
        
        subplot(8,8,8*(i-1)+j);
        imagesc(B);
        axis image off;
        colormap gray;
    end
end

sgtitle('DCT 8x8 Basis');

pause;
close all;

disp('I.b)')
figure('Name','DST Basis');

S = zeros(N,N);

for k = 0:N-1
    for n = 0:N-1
        S(k+1,n+1) = sqrt(2/N) * ...
            sin(pi/N * (n + 1/2) * (k + 1));
    end
end

for i = 1:N
    for j = 1:N
        
        E = zeros(N,N);
        E(i,j) = 1;
        
        B = S' * E * S;
        
        subplot(8,8,8*(i-1)+j);
        imagesc(B);
        axis image off;
        colormap gray;
    end
end

sgtitle('DST 8x8 Basis');

pause;
close all;

disp('I.c)')

H = hadamard(N);
sign_changes = sum(H(:,2:end) ~= H(:,1:end-1), 2);
[~, order] = sort(sign_changes);

Hseq = H(order, order);
figure('Name','Hadamard Basis');

for i = 1:N
    for j = 1:N       
        B = Hseq(i,:)' * Hseq(j,:);
        B = B / N;
        
        subplot(8,8,8*(i-1)+j);
        imagesc(B);
        axis image off;
        colormap gray;
    end
end

sgtitle('Hadamard 8x8 Basis - Sequency Order');

pause;
close all;

disp('I.d)')
Haar = [
     1  1  1  1  1  1  1  1;
     1  1  1  1 -1 -1 -1 -1;
     1  1 -1 -1  0  0  0  0;
     0  0  0  0  1  1 -1 -1;
     1 -1  0  0  0  0  0  0;
     0  0  1 -1  0  0  0  0;
     0  0  0  0  1 -1  0  0;
     0  0  0  0  0  0  1 -1
];

for k = 1:N
    Haar(k,:) = Haar(k,:) / norm(Haar(k,:));
end

figure('Name','Haar Basis');

for i = 1:N
    for j = 1:N
        B = Haar(i,:)' * Haar(j,:);
        
        subplot(8,8,8*(i-1)+j);
        imagesc(B);
        axis image off;
        colormap gray;
    end
end

sgtitle('Haar 8x8 Basis');

pause;
close all;

disp('II)')
disp('II.1)')
lena = double(imread('lena256.tif'));
D = dct2(lena);

figure('Name', 'Lena DCT', 'Position', [100, 100, 1200, 600]);
subplot(1,2,1);
imagesc(lena);
axis image;
colormap gray;
colorbar;
title('Imagem LENA');

D_log = log(abs(D) + 1);
subplot(1,2,2);
imagesc(D_log);
axis image;
colormap jet(64);
colorbar;

title('log(|DCT| + 1)');

pause;
close all;

disp('II.2)')

I = double(imread('lena256.tif'));
D = dct2(I);
js = [1 2 4 8 16 32 64 128];

figure('Name', 'Reconstrução DCT', 'Position', [100, 100, 1200, 600]);
for k = 1:length(js)
    j = js(k);
    A = zeros(size(D));
    A(1:j,1:j) = fliplr(triu(ones(j)));

    % DCT coeficientes apenas
    D_j = D .* A;
    I_j = idct2(D_j);

    subplot(2,4,k);
    imagesc(I_j);
    axis image off;
    colormap gray;

    title(sprintf('j = %d', j));
end

disp('Com 8 coeficientes, já é possível observar a silhueta da imagem, com 32 e 64 já é possível ver a imagem com detalhes. ')
disp('Assim, é possível utilizar a DCT como uma forma de comprimir a imagem, pois é possível reconstruir ela utilizando os coeficientes ')
disp(' com apenas uma perda de qualidade dependendo do número de coeficientes escolhidos. ')
disp(' Isso acontece pois a DCT concentra maior parte da energia do sinal nos coeficientes de baixa frequência, como podemos observar em II.1, ')
disp(' no canto superior esquerdo. Já os coeficientes de alta energia representam os detalhes da imagem. ')

pause;
close all;

disp('III)')
disp('III.1.a)')
img = double(imread('zelda_s.tif')); 
F = fft2(img);

disp('III.1.b) ');
MAG = abs(F);
fase = angle(F);
ANGLE = exp(1i * fase); 

pause;
disp('III.1.c)')
img_rec_mag = ifft2(MAG);
img_rec_mag = real(img_rec_mag);

figure('Name', 'Recuperação - Somente Magnitude');
imshow(img_rec_mag, []); 
colormap(gray);
title('Recuperação a partir da Magnitude (MAG)');
axis off;

pause;
disp('III.1.d)')
img_rec_angle = ifft2(ANGLE);
img_rec_angle = real(img_rec_angle);

figure('Name', 'Recuperação - Somente Fase');
imagesc(img_rec_angle);
colormap(gray);
title('Recuperação a partir da Fase (ANGLE)');
axis off;

pause;
disp('III.1.e)')
disp('A recuperação através de MAG não resulta em uma imagem reconhecível, pois a MAG representa a quantidade de cada frequência e não ')
disp(' a localização espacial, já utilizando ANGLE, é possível identificar a imagem através da reconstrução, pois ANGLE carrega informação ')
disp(' estrutural. ')

pause;
close all;

disp('III.2.a)')
img = double(imread('building.tif')); 
F = fft2(img);

disp('III.2.b) ');
MAG = abs(F);
fase = angle(F);
ANGLE = exp(1i * fase); 

pause;
disp('III.2.c)')
img_rec_mag = ifft2(MAG);
img_rec_mag = real(img_rec_mag);

figure('Name', 'Recuperação - Somente Magnitude');
imshow(img_rec_mag, []); 
colormap(gray);
title('Recuperação a partir da Magnitude (MAG)');
axis off;

pause;
disp('III.2.d)')
img_rec_angle = ifft2(ANGLE);
img_rec_angle = real(img_rec_angle);

figure('Name', 'Recuperação - Somente Fase');
imagesc(img_rec_angle);
colormap(gray);
title('Recuperação a partir da Fase (ANGLE)');
axis off;

pause;
disp('III.2.e)')
disp(' O mesmo comportamento observado em III.1.e) acontece com a imagme BUILDING. ')

pause;
close all;

disp('IV)')
disp('IV.1)')
imagens = {'ZELDA_S', 'TEXT'};
for k = 1:numel(imagens)
    img = double(imread([imagens{k} '.tif']));
    
    % KLT das COLUNAS
    X_cols = reshape(im2col(img, [8 8], 'distinct'), 8, [])';
    [V_c, D_c] = eig(cov(X_cols));
    [~, ord] = sort(diag(D_c), 'descend');
    Tc = V_c(:, ord);
    
    % KLT das LINHAS 
    img_t = blockproc(img, [8 8], @(bs) bs.data');
    X_lins = reshape(im2col(img_t, [8 8], 'distinct'), 8, [])';
    [V_r, D_r] = eig(cov(X_lins));
    [~, ord] = sort(diag(D_r), 'descend');
    Tr = V_r(:, ord);

    eval(sprintf('Tc_%s = Tc;', imagens{k}));
    eval(sprintf('Tr_%s = Tr;', imagens{k}));
     
    % Bases
    figure('Name', sprintf('KLT 2D - %s', imagens{k}));
    for i = 1:8
        for j = 1:8
            subplot(8, 8, 8*(i-1)+j);
            imagesc(Tc(:,i) * Tr(:,j)');
            colormap(gray); axis off;
        end
    end
    sgtitle(sprintf('Bases KLT 8x8 - %s', imagens{k}));
end

pause;
close all;

disp('IV.2)')

for k = 1:numel(imagens)
    img = double(imread([imagens{k} '.tif']));
    
    Tc = eval(sprintf('Tc_%s', imagens{k}));
    Tr = eval(sprintf('Tr_%s', imagens{k}));
    
    % KLT 8x8 / bloco
    X_blocos = im2col(img, [8 8], 'distinct');  % 64 x nBlocos
    nBlocos  = size(X_blocos, 2);
    
    % 2D separável: F = Tc' * X * Tr
    coefs = zeros(64, nBlocos);
    for b = 1:nBlocos
        blk   = reshape(X_blocos(:,b), 8, 8);
        F     = Tc' * blk * Tr;   % 8x8 de coeficientes
        coefs(:,b) = F(:);        % 64x1
    end
    
    % Autocov
    C = cov(coefs');                                  
     
    % --- Plot: mapa de calor da autocovariância ---
    figure('Name', sprintf('Autocov. KLT - %s', imagens{k}), ...
           'Position', [100 100 900 400]);
    
    subplot(1,2,1);
    imagesc(log(abs(C) + 1));
    colormap(gray); colorbar;
    title(sprintf('%s: log|C| dos coeficientes KLT', imagens{k}));
    axis square;
    
    subplot(1,2,2);
    % Compara com o que seria sem KLT: autocovariância dos próprios pixels
    C_pix = cov(X_blocos');
    imagesc(log(abs(C_pix) + 1));
    colormap(gray); colorbar;
    title('log |C| dos pixels (sem KLT)');
    axis square;
end

disp('Os coeficientes da KLT são majoritariamente diagonais na matriz obtida, o que constitui uma descorrelação entre os coeficientes. ')
disp(' a magnitudade da diagonal é muito maior que fora dela. Já na imagem da direita, é observado uma variação pequena na magnitude, e blocos ')
disp(' semelhantes, o que constitui a alta correlação espacial. ')
pause;
close all;


disp('IV.3)')

imagens = {'ZELDA_S', 'TEXT'};
D = dctmtx(8); % Matriz da DCT 1D. A DCT 2D é D * X * D'

for k = 1:numel(imagens)
    img = double(imread([imagens{k} '.tif']));
    X_blocos = im2col(img, [8 8], 'distinct'); % 64 x nBlocos
    nBlocos = size(X_blocos, 2);
    
    % DCT 8x8 em cada bloco 
    coefs_dct = zeros(64, nBlocos);
    for b = 1:nBlocos
        blk = reshape(X_blocos(:,b), 8, 8);
        F_dct = D * blk * D'; % Transformada 2D
        coefs_dct(:,b) = F_dct(:);
    end
    
    % Autocovariância dos coeficientes DCT
    C_dct = cov(coefs_dct');
    
    figure('Name', sprintf('Autocovariância DCT - %s', imagens{k}));
    imagesc(log(abs(C_dct) + 1));
    colormap(gray); colorbar; axis square;
    title(sprintf('Autocovariância DCT - %s', imagens{k}));

end

disp('Notei que as matrizes ficaram bem semelhantes, com a diagonal principal forte, porém usando a DCT foi um pouco mais rápido o cálculo. ')
disp(' Na DCT existem linhas diagonais fora da diagonal principal, um pouco mais fortes que na KLT, pois a KLT é uma transformada otima, ela ')
disp(' consegue concentrar a maior parte da energia nos primeiros coeficientes. Mas a DCT é uma boa aproximação. ')
pause;
close all;

disp('IV.4)')
imagens = {'ZELDA_S', 'TEXT'};
bs = 8;

% DST-I 8x8 
n = (0:bs-1)';
S = sqrt(2/(bs+1)) * sin( (n+1) * (n+1)' * pi / (bs+1) );

for k = 1:numel(imagens)
    img = double(imread([imagens{k} '.tif']));
    
    X_blocos = im2col(img, [bs bs], 'distinct');
    nBlocos  = size(X_blocos, 2);
    
    % DST 8x8 em cada bloco 
    coefs_dst = zeros(bs*bs, nBlocos);
    for b = 1:nBlocos
        blk = reshape(X_blocos(:,b), bs, bs);
        F   = S * blk * S';    % DST 2D separável
        coefs_dst(:,b) = F(:);
    end
    
    % AUTOCOV coeficientes DST 
    C_dst   = cov(coefs_dst');
    
    figure('Name', sprintf('Autocovariância - %s', imagens{k}), 'Position', [100 100 1200 400]);
 
    imagesc(log(abs(C_dst)+1)); colormap(gray); colorbar; axis square;
    title('DST');
  
end

disp('A DST (entre as transformadas acima) é a que menos consegue descorrelacionar, a energia fica bem espalhada ao longo da matriz. ')
disp(' ela é uma transformada fixa, que não corresponde as estatisticas das imagens naturais. ')
pause;
close all;

disp('IV.5)')
img = double(imread('ZELDA_S.tif'));
[M, N] = size(img);

% DCT 2D
C_dct = dct2(img);

% DST 2D
nM = (1:M)'; Sr = sqrt(2/(M+1)) * sin(nM * nM' * pi / (M+1));
nN = (1:N)'; Sc = sqrt(2/(N+1)) * sin(nN * nN' * pi / (N+1));
C_dst = Sr * img * Sc';

% KLT 8x8 
Tc = Tc_ZELDA_S; Tr = Tr_ZELDA_S;
C_klt = zeros(M, N);
bs = 8;
for i = 1:bs:M
    for j = 1:bs:N
        blk = img(i:i+bs-1, j:j+bs-1);
        C_klt(i:i+bs-1, j:j+bs-1) = Tc' * blk * Tr;
    end
end

% Js vs j 
js = [1, 2, 4, 8, 16, 32, 64, 128];
Js_klt = zeros(size(js)); Js_dct = zeros(size(js)); Js_dst = zeros(size(js));

for k = 1:length(js)
    j = js(k);
    M_mask = zeros(M, N);
    M_mask(1:j, 1:j) = triu(ones(j));
    
    Js_klt(k) = 1 - sum(sum(abs(C_klt .* M_mask).^2)) / sum(sum(abs(C_klt).^2));
    Js_dct(k) = 1 - sum(sum(abs(C_dct .* M_mask).^2)) / sum(sum(abs(C_dct).^2));
    Js_dst(k) = 1 - sum(sum(abs(C_dst .* M_mask).^2)) / sum(sum(abs(C_dst).^2));
end

figure('Name', 'Erro de restrição de base', 'Position', [100 100 800 500]);
plot(js, Js_klt, 'b-o', 'LineWidth', 2); hold on;
plot(js, Js_dct, 'r-s', 'LineWidth', 2);
plot(js, Js_dst, 'g-^', 'LineWidth', 2);
xlabel('j'); ylabel('J_s');
title('Erro de restrição de base - ZELDA\_S');
legend('KLT','DCT','DST','Location','northeast');
grid on; set(gca, 'XScale', 'log');

js_show = [8, 4, 2, 1];

figure('Name', 'V.5) Reconstruções DCT e DST', 'Position', [100 100 1200 600]);
for k = 1:length(js_show)
    j = js_show(k);
    M_mask = zeros(M, N);
    M_mask(1:j, 1:j) = triu(ones(j));
    
    % DCT
    img_rec_dct = idct2(C_dct .* M_mask);
    subplot(2, 4, k);
    imshow(img_rec_dct, []);
    title(sprintf('DCT, j=%d', j));
    
    % DST 
    img_rec_dst = Sr' * (C_dst .* M_mask) * Sc;
    subplot(2, 4, k+4);
    imshow(img_rec_dst, []);
    title(sprintf('DST, j=%d', j));
end
sgtitle('Reconstruções com máscara triangular (ZELDA\_S)');

pause; 
close all;

disp('IV.6)')

imagens = {'ZELDA_S', 'TEXT'};
bs = 8;

for k = 1:numel(imagens)
    img = double(imread([imagens{k} '.tif']));
    [M, N] = size(img);
    
    X_blocos = im2col(img, [bs bs], 'distinct');   % 64 x nBlocos
    nB = size(X_blocos, 2);
    
    % KLT não separável
    % Matriz de covariância 64x64 dos blocos
    C = cov(X_blocos');
    [V, D] = eig(C);
    [~, ord] = sort(diag(D), 'descend');
    Phi = V(:, ord);       % 64x64, cada coluna é uma base (64x1)
    
    % Visualização das 64 bases como imagens 8x8
    figure('Name', sprintf('Bases KLT não separável - %s', imagens{k}), ...
           'Position', [100 100 800 800]);
    for i = 1:64
        subplot(8,8,i);
        imshow(reshape(Phi(:,i), bs, bs), []);
        title(sprintf('%d', i), 'FontSize', 6);
    end
    sgtitle(sprintf('Bases KLT não separável - %s', imagens{k}));
    
    Y = Phi' * X_blocos;       % 64 x nB
    C_y = cov(Y');             % 64x64
    
    % --- KLT separável (do item IV.1) para comparação -
    Tc = eval(sprintf('Tc_%s', imagens{k}));
    Tr = eval(sprintf('Tr_%s', imagens{k}));
    Y_sep = zeros(64, nB);
    for b = 1:nB
        blk = reshape(X_blocos(:,b), bs, bs);
        Y_sep(:,b) = reshape(Tc' * blk * Tr, [], 1);
    end
    C_sep = cov(Y_sep');
    
    
    figure('Name', sprintf('Covariância dos coeficientes - %s', imagens{k}), ...
           'Position', [100 100 900 400]);
    subplot(1,2,1);
    imagesc(log(abs(C_sep)+1)); colormap(gray); colorbar; axis square;
    title('KLT separável (Item 2)');
    subplot(1,2,2);
    imagesc(log(abs(C_y)+1)); colormap(gray); colorbar; axis square;
    title('KLT não separável (Item 6)');
end

disp('A KLT não separável possui uma diagonal principal muito mais forte, onde os valores fora da diagonal são zeros. ')
disp(' assim, ela descorrelaciona melhor que a KLT separavel, concentrando a energia nos primeiros coeficientes. ')
disp(' Mas em um geral na prática, a aproximação fixa da DCT é preferida devido ao desempenho. Pois o ganho da KLT nao separavel ')
disp(' é pouco considerando a complexidade.')

pause;
close all;

disp('V)')
disp('V.1)')
img = im2double(imread('BARB_S.tif'));
figure('Name', 'V.1) Imagem Original', 'Position', [100 100 500 500]);
imshow(img);

pause;
close all;

disp('V.2)')
D = dctmtx(8);

% DCT 8x8 em cada bloco da imagem
fun_dct = @(bs) D * bs.data * D';
img_dct = blockproc(img, [8 8], fun_dct);

figure('Name', 'V.2) DCT 8x8', 'Position', [150 150 900 400]);

subplot(1,2,1);
imshow(img);
title('Original');

subplot(1,2,2);
imshow(log(abs(img_dct) + 1), []);
title('DCT 8x8 (escala logarítmica)');
colormap(gca, gray);

pause;
close all;

disp('V.3)')
blocos = [57, 241;
          121, 233];

figure('Name', 'V.3) Localização dos blocos', 'Position', [100 100 600 600]);
imshow(img); hold on;
cores = {'r', 'y'};
for k = 1:size(blocos,1)
    r = blocos(k,1); c = blocos(k,2);
    rectangle('Position', [c, r, 8, 8], 'EdgeColor', cores{k}, 'LineWidth', 2);
    text(c, r-3, sprintf('B%d', k), 'Color', cores{k}, 'FontWeight', 'bold');
end
title('BARB\_S - Localização dos blocos analisados');

for k = 1:size(blocos,1)
    r = blocos(k,1); c = blocos(k,2);
    blk_orig = img(r:r+7, c:c+7);         % pixels originais
    blk_dct  = img_dct(r:r+7, c:c+7);     % coeficientes da DCT
    
    % bloco original 
    subplot(2, 2, 2*k - 1);
    imshow(blk_orig);
    title(sprintf('B%d - Pixels originais', k));
    
    % coeficientes DCT
    subplot(2, 2, 2*k);
    imshow(log(abs(blk_dct) + 1), []);
    title(sprintf('B%d - DCT (log)', k));
end

disp('A região B2 é bem mais texturizada que a região B1, onde os pixels são similares. ')
pause;
close all;

disp('V.4)')
alphas = [1/32, 1/16, 1/8, 1/4];
bs = 8;
D = dctmtx(bs);

blocos = [57, 241;
          121, 233];

disp('V.4.a)')
figure('Name', 'V.4a) DCT dos blocos por alpha', ...
       'Position', [100 100 1200 700]);

for a = 1:length(alphas)
    alpha = alphas(a);
    img_dct_thr = img_dct .* (abs(img_dct) >= alpha);
    
    for k = 1:size(blocos, 1)
        r = blocos(k,1); c = blocos(k,2);
        blk_dct = img_dct_thr(r:r+7, c:c+7);
        
        % Layout: linha = bloco (B1, B2); coluna = alpha
        idx = (k-1)*length(alphas) + a;
        subplot(2, length(alphas), idx);
        imshow(log(abs(blk_dct) + 1), []);
        title(sprintf('B%d, \\alpha = 1/%d', k, round(1/alpha)));
    end
end
sgtitle('DCT dos blocos B1 e B2 após limiarização');

pause;

disp('V.4.b)')
figure('Name', 'V.4b) Imagens reconstruídas', ...
       'Position', [100 100 1400 400]);

subplot(1, 5, 1);
imshow(img);
title('Original');

for a = 1:length(alphas)
    alpha = alphas(a);
    img_dct_thr = img_dct .* (abs(img_dct) >= alpha);
    
    % IDCT 8x8 em cada bloco (D' * F * D)
    fun_idct = @(bs) D' * bs.data * D;
    img_rec = blockproc(img_dct_thr, [bs bs], fun_idct);
    
    % Trunca para [0,1]
    img_rec = min(max(img_rec, 0), 1);
    
    subplot(1, 5, a+1);
    imshow(img_rec);
    title(sprintf('\\alpha = 1/%d', round(1/alpha)));
end

sgtitle('Reconstruções com DCT limiarizada');
pause;

disp('V.5)')
alphas_betas = [1/32, 1/16, 1/8, 1/4];
bs = 8;
D = dctmtx(bs);

blocos = [57, 241; 121, 233];

disp('V.5.a)')
figure('Name', 'V.5a) DCT quantizada dos blocos', ...
       'Position', [100 100 1200 700]);

for b = 1:length(alphas_betas)
    beta = alphas_betas(b);
    
    % Quantiza a DCT: fix(X/beta)*beta
    img_dct_q = fix(img_dct / beta) * beta;
    
    for k = 1:size(blocos, 1)
        r = blocos(k,1); c = blocos(k,2);
        blk_dct_q = img_dct_q(r:r+7, c:c+7);
        
        idx = (k-1)*length(alphas_betas) + b;
        subplot(2, length(alphas_betas), idx);
        imshow(log(abs(blk_dct_q) + 1), []);
        title(sprintf('B%d, \\beta = 1/%d', k, round(1/beta)));
    end
end
sgtitle('DCT dos blocos após quantização com passo \beta');

pause;
disp('V.5.b)')
figure('Name', 'V.5b) Reconstruções quantizadas', ...
       'Position', [100 100 1400 400]);

subplot(1, 5, 1);
imshow(img);
title('Original');

mse_vals = zeros(1, length(alphas_betas));

for b = 1:length(alphas_betas)
    beta = alphas_betas(b);
    
    % Quantiza
    img_dct_q = fix(img_dct / beta) * beta;
    
    % IDCT por bloco
    fun_idct = @(bs) D' * bs.data * D;
    img_rec = blockproc(img_dct_q, [bs bs], fun_idct);
    img_rec = min(max(img_rec, 0), 1);   % trunca para [0,1]
    
    subplot(1, 5, b+1);
    imshow(img_rec);
    title(sprintf('\\beta = 1/%d\n', round(1/beta)));
end
sgtitle('Reconstruções com DCT quantizada');

pause;

disp('V.5.c)')
disp('A quantização transforma os coeficientes em multiplos de B, tendo assim um conjunto pequeno, permitindo a codificação. ')
disp(' a limiarização não reduz o valor absoluto dos coeficientes, eles continuam tendo valores continuo, inviabilizando uma codificação eficiente. ')
disp(' Assim, a medida que B cresce, a taxa de compressão aumenta e a qualidade cai. ')

pause;
close all;