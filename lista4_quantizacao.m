% Lista 4 - Image Quantization
clear; clc; close all; 
disp('Lista Capítulo 4 - Image Quantization')
disp('Eduardo Henrique Banaczewski')
pause; 

disp('I.1) ')
nomes = {'zelda_s', 'barb_s', 'lena256'};
bits = [8, 7, 6, 5, 4, 3, 2, 1];

for i = 1:length(nomes)
    img = imread([nomes{i}, '.tif']);   
    img = im2double(img);
    
    figure('Name', ['Quantização: ', nomes{i}], 'Position', [100, 100, 1200, 600]);
    
    for b = 1:length(bits)
        n_bits = bits(b);
        n_niveis = 2^n_bits;
        
        if n_bits == 1
            img_q = im2bw(img, 0.5);
        else
            delta = 1 / (n_niveis - 1);
            img_q = round(img / delta) * delta;
        end

        
        subplot(2, 4, b);
        imshow(img_q);
        title(sprintf('%d bits: ', n_bits));
        axis off;
    end
    
    sgtitle(['Efeito da Quantização - ', nomes{i}]);
end

disp('Consigo observar diferença na "qualidade" entre as imagens, gradativamente a qualidade diminui conforme o numero de bits diminui. ');
disp(' 8 até 6 bits: qualidade é mantida, sem grandes mudanças na visualização. ');
disp(' 5-4 bits: começam a surgir os falsos contornos, nas regiões onde a transição de cores é mais suave, criando degraus. ');
disp(' 2-3 bits: a imagem perde muitos detalhes, dificultando muito a visualização');
disp(' 1 bit: imagem binária, sendo possivel visualizar somente a silhueta da imagem. ');
disp('O erro introduzido pelo processo de quantização cria os chamados contornos artificiais (contouring). ');

pause; 
close all;

disp('I.2) ')

img = imread('LENA256.tif');  
img = im2double(img);         
niveis = 16;
img_quant = fix(niveis * img) / niveis;

disp('I.2.a) ')

figure('Name', 'Quantização 16 níveis', 'Position', [100, 100, 800, 400]);

subplot(1,2,1);
imshow(img, [0 1]);
title('Original');

subplot(1,2,2);
imshow(img_quant, [0 1]);
title('Quantizada');

pause; 

disp('I.2.b) ')

x = linspace(0, 1, 1000);       
y = fix(niveis * x) / niveis;    
erro = y - x;                 

figure('Name', 'Curva do Quantizador', 'Position', [100, 100, 800, 400]);

subplot(1,2,1);
plot(x, y, 'b-', 'LineWidth', 1.5);
hold on;
plot(x, x, 'r--', 'LineWidth', 1);
xlabel('Entrada');
ylabel('Saída');
title(sprintf('Entrada x Saida'));
legend('Quantizador', 'y = x (referência)', 'Location', 'northwest');
grid on;

subplot(1,2,2);
plot(x, erro, 'b-', 'LineWidth', 1.5);
xlabel('Entrada');
ylabel('Erro de Quantização (y - x)');
title('Erro de Quantização x Entrada');
grid on;

pause; 
disp('I.2.c) ')

mse = mean((img(:) - img_quant(:)).^2);
fprintf('Erro medio quadratico (MSE): %.6f\n', mse);

pause; 
close all;

disp('I.3) ')
disp('I.3.a) ')
img = im2double(imread('lena256.tif'));

img_q1 = fix(16 * img) / 16;
img_q2 = fix(16 * img) / 16 + 1/32;

figure('Name', 'Imagem Quantizada', 'Position', [100, 100, 800, 400]);
imshow(img_q2);
title('16 niveis + 1/32');

pause; 
close all; 
disp('I.3.b) ')

x = 0:0.001:1;
y = fix(16 * x) / 16 + 1/32;
erro = y - x;

figure('Name', 'Curvas do quantizador', 'Position', [100, 100, 1200, 600]);

subplot(1,2,1);
plot(x, y, 'b-', x, x, 'r--', 'LineWidth', 1.5);
xlabel('Entrada'); ylabel('Saída');
title('Entrada × Saida');
legend('Quantizador', 'y = x', 'Location', 'northwest');
grid on;

subplot(1,2,2);
plot(x, erro, 'b-', 'LineWidth', 1.5);
xlabel('Entrada'); ylabel('Erro (y − x)');
title('Erro de Quantização');
grid on;

pause;
disp('I.3.c) ')

erro1 = fix(16 * x) / 16 - x;            % erro do exercício 2
erro2 = (fix(16 * x) / 16 + 1/32) - x;   % erro do exercício 3

figure('Name', 'Erros', 'Position', [100, 100, 600, 400]);
plot(x, erro1, 'b-', 'LineWidth', 1.2); hold on;
plot(x, erro2, 'r-', 'LineWidth', 1.2);
xlabel('Entrada'); ylabel('Erro');
title('Comparação: Exerc 2 x Exerc 3');
legend('Exercicio 2', 'Exercicio 3');
grid on;

disp('Os gráficos são identicos visualmente porém deslocados. Ao compararmos, o quantizador deslocado por 1/32');
disp(' ele está "simétrico" em torno do zero. ')

pause;
disp('I.3.d)')

mse = mean((img(:) - img_q1(:)).^2);
fprintf('MSE exercicio 2: %.6f\n', mse);

mse2 = mean((img(:) - img_q2(:)).^2);
fprintf('MSE exercicio 3: %.6f\n', mse2);

disp('O erro está muito menor ao adicionar o deslocamento por 1/32 aos níveis de reconstrução. ')

pause; 
disp('I.3.e)')

figure('Name', 'Comparação Visual', 'Position', [100, 100, 1200, 400]);
subplot(1,3,1); imshow(img); title('Original ');
subplot(1,3,2); imshow(img_q1); title('16 niveis exercicio 2');
subplot(1,3,3); imshow(img_q2); title('16 niveis exercicio 3 (+1/32)');

disp('Não consegui perceber quase nenhuma diferença visual, apesar do erro ter diminuido muito em comparação a uma imagem e outra. ')
disp(' O que acontece, é que ao adicionar uma constante em toda a imagem, acabamos deslocando o brilho inteiro da imagem, não gerando ')
disp(' uma mudança de percepção. Assim posso dizer que MSE não é uma boa medida da qualidade de um quantizador. ')

pause;
close all;
clear;

disp('II)')
disp('II.a)')
img = im2double(imread('ZELDA_S.tif'));

disp('II.b)')
img_q = fix(16 * img) / 16 + 1/32;

disp('II.c)')

[M, N] = size(img);
Z = zeros(M, N);
Z(:, 1) = img(:, 1);
for j = 2:N
    Z(:, j) = img(:, j) - img(:, j-1);
end

imshow(Z, []);

pause;
close all;
disp('II.d)')

nlevels = 16;
alpha = 2;
sigma_Z = std(Z(:)); % desvio padrao
Delta = (alpha * sigma_Z) / nlevels; % passo quantização (quantizador otimo) 
T = alpha * sigma_Z;

Z_q = zeros(size(Z));
Z_q(:, 1) = Z(:, 1);
for j = 2:size(Z, 2)
    x = Z(:, j);         
    x_abs = abs(x);      
    
    % parte positiva
    q_pos = floor(x_abs / Delta) * Delta;
    
    % saturação
    q_pos(q_pos > T) = T;
    
    % valores negativos
    Z_q(:, j) = sign(x) .* q_pos;
end

figure('Name', 'Quantização Z', 'Position', [100, 100, 1200, 600]);

subplot(2, 2, 1);
imshow(Z);
title('Z original');

subplot(2, 2, 2);
imshow(Z_q);
title('Z quantizada');

subplot(2, 2, 3);
Z_vis = Z - min(Z(:));
Z_vis = Z_vis / max(Z_vis(:));
imshow(Z_vis);
title('Z original - normalizada');

subplot(2, 2, 4);
Z_q_vis = Z_q - min(Z_q(:));
Z_q_vis = Z_q_vis / max(Z_q_vis(:));
imshow(Z_q_vis);
title('Z quantizada  - normalizada');

pause;
close all;

disp('II.e) ')
X_rec = cumsum(Z_q, 2);
X_rec = min(max(X_rec, 0), 1);

figure('Name', 'Recuperação vs Quantização Direta', 'Position', [100, 100, 1000, 450]);
subplot(1, 2, 1);
imshow(img_q); 
title('Quantização Direta de X');

subplot(1, 2, 2);
imshow(X_rec);
title('Recuperada de Z quantizado');

niveis_teste = [8, 32, 64];
figure('Name', 'Efeito do Número de Níveis', 'Position', [150, 150, 1200, 400]);

for k = 1:length(niveis_teste)
    nlev = niveis_teste(k);
    
    Delta_test = (alpha * sigma_Z) / nlev;
    Z_q_test = zeros(size(Z));
    Z_q_test(:, 1) = Z(:, 1);
    
    for j = 2:size(Z, 2)
        x = Z(:, j);
        q_pos = floor(abs(x) / Delta_test) * Delta_test;
        q_pos(q_pos > T) = T;
        Z_q_test(:, j) = sign(x) .* q_pos;
    end
    
    % Recupera
    X_rec_test = cumsum(Z_q_test, 2);
    X_rec_test = min(max(X_rec_test, 0), 1);
    
    subplot(1, 3, k);
    imshow(X_rec_test);
    title(sprintf('%d níveis', nlev));
end


disp('As imagens recuperadas, para todos os níveis de quantização testados, possuem varias "falhas" na imagem, consigo ')
disp(' visualizar fortes listras de artefatos na horizontal, como se fosse uma variação do brilho ao decorrer das colunas. ')
disp('Porém conforme mais níveis são adicionados, esse erro parece suavizar um pouco. ')
disp('Esse é um erro cumulativo, da esquerda para a direita. O erro é propagado de coluna em coluna. ')
disp('Assim, quando recuperamos Z, o erro de quantização acumulado é muito maior que quando recuperamos X diretamente, pois o erro foi constante. ')
disp(' Como observamos com 64 níveis, uma das possíveis soluções para amenizar esse problema é utilizar mais níveis de quantização. ')
disp(' Outra possivel solução é quantizar a diferença em relação a estimativa anterior, ao inves de quantizar a diferença original. ')
pause;
close all;

disp('II.f)')
X = img; 
[M, N] = size(X);

Y = zeros(M, N);
Y_q = zeros(M, N);
X_q = zeros(M, N);

X_q(:, 1) = X(:, 1);


for j = 2:N
    % erro de predicao
    Y(:, j) = X(:, j) - X_q(:, j-1);
    
    % quantizacao
    q_pos = floor(abs(Y(:, j)) / Delta) * Delta;
    q_pos(q_pos > T) = T;
    Y_q(:, j) = sign(Y(:, j)) .* q_pos;
    
    % reconstrucao
    X_q(:, j) = X_q(:, j-1) + Y_q(:, j);
end

X_q_vis = min(max(X_q, 0), 1);
figure('Name', 'DPCM em Malha Fechada', 'Position', [100, 100, 1000, 450]);

subplot(1, 2, 1);
imshow(X);
title('Imagem Original (X)');

subplot(1, 2, 2);
imshow(X_q_vis);
title('Imagem Reconstruída (X_q)');

pause;
close all;

disp('II.g)')
nbins = 256; 
figure('Name', 'Histogramas de X e Y', 'Position', [100, 100, 1000, 400]);

subplot(1, 2, 1);
histogram(X(:), nbins); 
title('Histograma de X (Imagem Original)');
xlabel('Intensidade do Pixel');
ylabel('Frequência');
grid on;

subplot(1, 2, 2);
histogram(Y(:), nbins);
title('Histograma de Y (Erro de Predição)');
xlabel('Y');
ylabel('Frequência');
grid on;

disp('A diferença entre os dois histogramas é grande. ')
disp('O histograma de X é bem mais distribuido/espalhado, o que constitui os varios tons de cinza. ')
disp('O histograma de Y é mais concentrado perto de zero, devido a alta correlação entre os pixeis, com uma variancia muito menor. ')

pause;
close all;

disp('II.h)')
disp('A distribuição que melhor se aproxima de Y é a Laplaciana.')
disp('Para gerar a distribuição, vou calcular os valores de média e variancia a partir de Y: ')

mu_Y = mean(Y(:));
var_Y = var(Y(:));
sigma_Y = sqrt(var_Y);

x_vals = linspace(min(Y(:)), max(Y(:)), 1000);
pdf_gauss = (1 / (sigma_Y * sqrt(2*pi))) * exp(-((x_vals - mu_Y).^2) / (2 * var_Y));
b_Y = sqrt(var_Y / 2); 
pdf_lap = (1 / (2 * b_Y)) * exp(-abs(x_vals - mu_Y) / b_Y);

figure('Name', 'Ajuste de Distribuição de Y', 'Position', [100, 100, 800, 500]);
histogram(Y(:), 200, 'Normalization', 'pdf', 'EdgeColor', 'none', 'FaceColor', [0.7 0.7 0.7]);
hold on;

plot(x_vals, pdf_gauss, 'r-', 'LineWidth', 2, 'DisplayName', 'Gaussiana');
plot(x_vals, pdf_lap, 'b-', 'LineWidth', 2, 'DisplayName', 'Laplaciana');

title('Distribuição de Y: Histograma vs. Modelos Teóricos');
xlabel('Erro de Predição (Y)');
ylabel('Densidade de Probabilidade');
legend('Histograma de Y', 'Gaussiana', 'Laplaciana', 'Location', 'best');
grid on;
hold off;

disp('II.i)')
disp('Foi observado que o erro de predição de Y, tem uma distribuição quase Laplaciana, isso significa que a maioria dos valores ')
disp(' são pequenos. ')
disp('No quantizador utilizado em D), o passo de quantização (delta) e o limiar de saturação (T), foram definidos em função de alpha. ')
disp(' : delta = alpha * var / n_levels; T = alpha * var')
disp(' Esse alpha funciona como um fator de escala, ele define a largura da região de quantização proxima de zero nessa distribuição, e onde ocorre a saturação. ')
disp('O compromisso entre a qualidade da imagem reconstruida e a entropia de Yq: ')
disp(' Tem uma relação inversa (controlada por alpha), se alpha for muito pequeno, o passo (delta) será pequeno, resultando em qualidade alta, porém entropia alta. ')
disp(' Já com alpha grande, o passo é grande, com qualidade de imagem mais baixa e entropia baixa. ')

pause;
close all; 

disp('II.j)')

nlevels_list = [32, 16, 4, 2];
alpha_range = 0.1:0.05:5.0; 

figure('Name', 'Alpha Ótimo', 'Position', [100, 100, 800, 600]);
hold on; grid on;

% maior o lambda, mais importante é a compressão/entropia
lambdas = [0.0001, 0.001, 0.01]; 
nomes_lambdas = {'Qualidade', 'Equilibrado', 'Compressão'};

for n = 1:length(nlevels_list)
    nlev = nlevels_list(n);
    mse_vals = zeros(size(alpha_range));
    entropy_vals = zeros(size(alpha_range));
    
    for a = 1:length(alpha_range)
        alpha = alpha_range(a);
        Delta = (alpha * sigma_Z) / nlev;
        T = alpha * sigma_Z;
        
        % DPCM Malha Fechada
        Y = zeros(M, N); Y_q = zeros(M, N); X_q = zeros(M, N);
        X_q(:, 1) = X(:, 1);
        
        for j = 2:N
            Y(:, j) = X(:, j) - X_q(:, j-1);
            q_pos = floor(abs(Y(:, j)) / Delta) * Delta;
            q_pos(q_pos > T) = T;
            Y_q(:, j) = sign(Y(:, j)) .* q_pos;
            X_q(:, j) = X_q(:, j-1) + Y_q(:, j);
        end
        
        X_q_vis = min(max(X_q, 0), 1);
        mse_vals(a) = mean((X(:) - X_q_vis(:)).^2);
        
        % Entropia
        Y_q_quantized = Y_q(:, 2:end);
        [~, ~, idx] = unique(Y_q_quantized(:));
        counts = histcounts(idx, 1:max(idx)+1);
        p = counts / sum(counts);
        p = p(p > 0);
        entropy_vals(a) = -sum(p .* log2(p));
    end
    
    plot(entropy_vals, mse_vals, '-', 'Color', [0.7 0.7 0.7], 'LineWidth', 1, 'HandleVisibility', 'off');
    is_optimal = true(size(mse_vals));
    plot(entropy_vals(is_optimal), mse_vals(is_optimal), 'o-', 'LineWidth', 2, ...
         'DisplayName', sprintf('%d níveis', nlev));
    
    % alpha otimo para cada caso
    fprintf('\n--- Níveis: %d \n', nlev);
    for l = 1:length(lambdas)
        lambda = lambdas(l);

        % custo J = MSE + lambda * entropia
        custo = mse_vals + lambda * entropy_vals;
        [~, idx_opt] = min(custo);
        
        alpha_opt = alpha_range(idx_opt);
        mse_opt = mse_vals(idx_opt);
        ent_opt = entropy_vals(idx_opt);
        
        fprintf('%s (lambda=%.4f): Alpha ótimo = %.2f | MSE = %.6f | Entropia = %.4f bits\n', ...
                nomes_lambdas{l}, lambda, alpha_opt, mse_opt, ent_opt);
        
        plot(ent_opt, mse_opt, 'p', 'MarkerSize', 12, 'MarkerFaceColor', 'auto', ...
             'HandleVisibility', 'off');
    end
end

fprintf('------ \n')
disp('Para escolher os melhores valores de alpha, selecionei tres valores de lambda, cada um com foco em Qualidade, Equilibrado e Compressão. ')
disp('Depois calculei para cada um dos níveis, sabendo que a função de custo usada é J = MSE + lambda * entropia. ')

disp('Nesse gráfico os alphas otimos são representados pelas estrelas, para 32 e 16 niveis, o alpha otimo é igual para todos lambdas. ')

xlabel('Entropia');
ylabel('MSE');
title('Alpha Ótimo');
legend('Location', 'best');
hold off;

pause;
close all;

disp('II.k)')
mu_Y = mean(Y(:));
sigma_Y = std(Y(:));
t_pos = [0.0000, 0.2645, 0.5668, 0.9200, 1.3446, 1.8778, 2.5974, 3.7243];
r_pos = [0.1240, 0.4049, 0.7288, 1.1111, 1.5780, 2.1776, 3.0171, 4.4314];

% limiares e níveis simétricos, escalados para Y
b = [-fliplr(t_pos(2:end)), t_pos] * sigma_Y + mu_Y;
r = ([-fliplr(r_pos), r_pos] * sigma_Y + mu_Y)'; 

% DPCM em malha fechada com quantizador ótimo
X_q = zeros(M, N);
X_q(:,1) = X(:,1);

for j = 2:N
    Y_curr = X(:,j) - X_q(:,j-1);              % erro de predição atual
    idx = discretize(Y_curr(:), [-inf; b(:); inf]); % índice do bin
    X_q(:,j) = X_q(:,j-1) + r(idx);            % reconstrói
end

X_q_vis = min(max(X_q, 0), 1);
X_rec_vis = min(max(X_rec, 0), 1);

figure('Name', 'k) Lloyd-Max vs (e)', 'Position', [100 100 1000 450]);
subplot(1, 3, 1); imshow(img_q); title('Quantização Direta de X (e)');
subplot(1, 3, 2); imshow(X_rec); title('Recuperada de Z quantizado (e)');
subplot(1,3,3), imshow(X_q_vis),   title('Lloyd-Max 16 níveis (k)');

mse_b = mean((X(:) - img_q(:)).^2);       % quantização direta (b)
mse_e = mean((X(:) - X_rec_vis(:)).^2);   % recuperada de Z (e)
mse_k = mean((X(:) - X_q_vis(:)).^2);     % Lloyd-Max (k)

fprintf('MSE (b) = %.6f\n', mse_b);
fprintf('MSE (e) = %.6f\n', mse_e);
fprintf('MSE (k) = %.6f\n', mse_k);

disp('Consigo observar que a quantização feita em K é a que visualmente parece melhor entre as três.')
disp(' Além de possuir o menor erro MSE. ')

pause;
close all; 

disp('II.l)')

%  uniforme D
nlev_q  = 16;
alpha_q = 2;
T_q     = alpha_q * sigma_Y;
Delta_q = 2 * T_q / nlev_q;
b_d = Delta_q * (1 : nlev_q/2 - 1);
r_d = Delta_q * (0.5 : 1 : nlev_q/2 - 0.5);

% LLoyd
t_pos = [0.0000, 0.2645, 0.5668, 0.9200, 1.3446, 1.8778, 2.5974, 3.7243];
r_pos = [0.1240, 0.4049, 0.7288, 1.1111, 1.5780, 2.1776, 3.0171, 4.4314];
b = ([-fliplr(t_pos(2:end)), t_pos]) * sigma_Y + mu_Y;
r = ([-fliplr(r_pos), r_pos])           * sigma_Y + mu_Y;

% Uniforme
X_q_uni = zeros(M, N);
X_q_uni(:,1) = X(:,1);

for j = 2:N
    Y_curr = X(:,j) - X_q_uni(:,j-1);
    Y_q_curr = zeros(size(Y_curr));
    for i = 1:numel(Y_curr)
        v = Y_curr(i); va = abs(v);
        if va < b_d(1)
            q = r_d(1);
        elseif va >= T_q
            q = r_d(end);
        else
            q = r_d(find(b_d <= va, 1, 'last'));
        end
        Y_q_curr(i) = sign(v) * q;
    end
    X_q_uni(:,j) = X_q_uni(:,j-1) + Y_q_curr;
end

% lloyd
X_q_lm = zeros(M, N);
X_q_lm(:,1) = X(:,1);

for j = 2:N
    Y_curr = X(:,j) - X_q_lm(:,j-1);
    Y_q_curr = zeros(size(Y_curr));
    for i = 1:numel(Y_curr)
        v = Y_curr(i);
        if v < b(1)
            k = 1;
        elseif v >= b(end)
            k = numel(r);
        else
            k = find(b <= v, 1, 'last');
        end
        Y_q_curr(i) = r(k);
    end
    X_q_lm(:,j) = X_q_lm(:,j-1) + Y_q_curr;
end

X_q_uni_vis = min(max(X_q_uni, 0), 1);
X_q_lm_vis  = min(max(X_q_lm,  0), 1);

figure('Name', 'Imagens Quantizadas', 'Position', [100 100 1200 450]);
subplot(1,3,1), imshow(X),           title('Original');
subplot(1,3,2), imshow(X_q_uni_vis), title('Uniforme 16 níveis');
subplot(1,3,3), imshow(X_q_lm_vis),  title('Lloyd-Max 16 níveis');

mse_uni = mean((X(:) - X_q_uni_vis(:)).^2);
mse_lm  = mean((X(:) - X_q_lm_vis(:)).^2);
fprintf('MSE uniforme  = %.6f\n', mse_uni);
fprintf('MSE Lloyd-Max = %.6f\n', mse_lm);
fprintf('Melhoria Lloyd-Max vs Uniforme = %.1f%%\n', 100*(mse_uni - mse_lm)/mse_uni);
x = linspace(min(Y(:)), max(Y(:)), 2000);

y_d = zeros(size(x));
for i = 1:numel(x)
    v = x(i); va = abs(v);
    if va < b_d(1),     q = r_d(1);
    elseif va >= T_q,   q = r_d(end);
    else,               q = r_d(find(b_d <= va, 1, 'last'));
    end
    y_d(i) = sign(v) * q;
end

y_k = zeros(size(x));
for i = 1:numel(x)
    v = x(i);
    if v < b(1),        k = 1;
    elseif v >= b(end), k = numel(r);
    else,               k = find(b <= v, 1, 'last');
    end
    y_k(i) = r(k);
end

figure('Name', 'Comparação dos Quantizadores', 'Position', [100 100 1200 500]);
subplot(1,2,1);
plot(x, y_d, 'r--', 'LineWidth', 2, 'DisplayName', 'Uniforme 16 níveis');
hold on;
plot(x, y_k, 'b-',  'LineWidth', 2, 'DisplayName', 'Lloyd-Max 16 níveis');
plot(x, x,   'k:',  'LineWidth', 1, 'DisplayName', 'y = x');
xlabel('Entrada (Y)'); ylabel('Saída Quantizada');
title('Curvas de Transferência');
legend('Location', 'northwest'); grid on;

subplot(1,2,2);
b_lap = sigma_Y / sqrt(2);
pdf_lap = (1/(2*b_lap)) * exp(-abs(x - mu_Y)/b_lap);
plot(x, pdf_lap, 'g-', 'LineWidth', 2);
xlabel('Erro de Predição (Y)'); ylabel('Densidade de Probabilidade');
title('Distribuição Laplaciana de Y'); grid on;

disp('O resultado obtido em K é melhor. Pois como a estatistica de Y se aproxima de uma laplaciana, utilizando um otimizador Lloyd otimizado para uma Laplaciana funciona muito bem. ')
disp(' Já o otimizador utilizado em D) é uniforme, erra muito onde os valores importam (proximo de zero), ')
disp('  Que é onde o otimizador lloyd-max para laplaciana acerta melhor. ')
disp(' assim, com os mesmos 16 niveis, K) possui um MSE menor que D). assim como uma quantização/visualização mais representativa.  ')

pause;
close all;
clear;

disp('III)')
disp('III.i)')
img = im2double(imread('lena256.tif'));
img_q = fix(16 * img) / 16 + 1/32;

figure('Name', 'LENA quantizada', 'Position', [100 100 1200 600]);
subplot(1,2,1);
imshow(img_q);
title('16 níveis');

subplot(1,2,2);
imshow(img);
title('Original');

pause;
disp('III.ii)')
alpha = 0.05;
[M, N] = size(img_q);
ruido = alpha * (2 * rand(M, N) - 1);

figure('Name', 'Ruído uniforme', 'Position', [150 150 500 500]);
imshow(ruido, []);
title(sprintf('Ruído uniforme em [%.2f, %.2f]', -alpha, alpha));
colorbar;

pause;
disp('III.iii)');

img_ruidosa = img + ruido; 
img_ruidosa_q = fix(16 * img_ruidosa) / 16 + 1/32;

disp('III.iii.a)');

figure('Name', 'Ruído vs Sem Ruído', 'Position', [100 100 900 400]);
subplot(1, 2, 1);
imshow(img_q);
title('Quantizada sem ruído');

subplot(1, 2, 2);
imshow(img_ruidosa_q);
title('Quantizada com ruído adicionado');


disp('A quantização realizada com ruido adicionado, elimina as falhas visuais de falsos contornos, nas regiões sensíveis de transição de cor. ')
disp('Basicamente, o ruído "quebra" essa suavização de transição, fazendo com que oscile entre os níveis de quantização. ')

pause;
disp('III.iii.b)');
img_sub = img_ruidosa_q - ruido;
img_sub = min(max(img_sub, 0), 1);

figure('Name', 'Comparação com ruído subtraído', 'Position', [100 100 1200 400]);
subplot(1, 3, 1);
imshow(img_q);
title('Sem ruído');

subplot(1, 3, 2);
imshow(img_ruidosa_q);
title('Com ruído');

subplot(1, 3, 3);
imshow(img_sub);
title('Ruído subtraído');

disp('Já ao substrair o ruído do resultado, a imagem se parece ainda mais com a original, com qualidade aparente maior do que deixando o ruido. ')
disp('O que acontece é que o erro de quantização deixa de ser estruturado, e passa a ser um erro aleatorio, e sabendo o ruido que foi adicionado, ao subtrair é possível reduzir. ')

pause;
close all; 
disp('III.iv)')

img = im2double(imread('lena256.tif'));

alphas = [0.005, 0.015, 0.03125, 0.05, 0.0625, 0.10];
nrep = 3;  
[M, N] = size(img);

mse_lap = zeros(size(alphas));

figure('Name', 'Variação de alpha', 'Position', [100 100 1500 700]);

for a = 1:length(alphas)
    alpha = alphas(a);
    mse_acum = 0;
    img_sub_acum = zeros(M, N);
    
    for r = 1:nrep
        ruido = alpha * (2 * rand(M, N) - 1);
        img_ruidosa = fix(16 * (img + ruido)) / 16 + 1/32;
        img_sub = img_ruidosa - ruido;
        img_sub = min(max(img_sub, 0), 1);
        mse_acum = mse_acum + mean((img(:) - img_sub(:)).^2);
        img_sub_acum = img_sub_acum + img_sub;
    end
    
    mse_lap(a) = mse_acum / nrep;
    img_sub_avg = img_sub_acum / nrep;
    
    subplot(2, 3, a);
    imshow(img_sub_avg);
    title(sprintf('\\alpha = %.4f (MSE=%.2e)', alpha, mse_lap(a)));
end

sgtitle('Ruído subtraído para diferentes \alpha');

figure('Name', 'iv) MSE vs alpha', 'Position', [200 200 600 400]);
plot(alphas, mse_lap, 'o-', 'LineWidth', 2, 'MarkerFaceColor', 'b');
xlabel('\alpha'); ylabel('MSE');
title('MSE após subtrair o ruído'); grid on;

disp('Valor alpha otimo aparentemente parece ser 0,03125');
pause;
close all;

disp('III.v)')
img = im2double(imread('ZELDA.tif'));
[M, N] = size(img);
alpha = 0.2;

% 1 bit SEM dithering 
img_1bit_sem = double(img >= 0.5);

% 1 bit COM dithering 
ruido = alpha * (2 * rand(M, N) - 1);
img_ruidosa = img + ruido;
img_1bit_com = double(img_ruidosa >= 0.5);

figure('Name', 'Comparação 1-bit', 'Position', [100 100 1500 600]);

subplot(1, 3, 1);
imshow(img);
title('Original');

subplot(1, 3, 2);
imshow(img_1bit_sem);
title('1 bit');

subplot(1, 3, 3);
imshow(img_1bit_com);
title('1 bit COM dithering');

sgtitle('Efeito do Dithering na Quantização de 1 bit');

disp('A imagem com 1 bit sem dithering parece bem "crua" visualmente falando, as regiões possuem transições agressivas entre o preto e branco, dificultando a visualização. ')
disp('Já com o ruido adicionado, a percepção é muito melhor, ficando mais facil de identificar as transições e texturas da imagem. ')
disp('Isso acontece devido ao limiar ser exclusivamente em 0.5, fazendo com que as transições e valores proximos, sejam atribuidos ao mesmo valor de quantização. ')
disp('Porém o ruído de certa forma suaviza essas transições. ')
pause;
close all;