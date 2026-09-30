% Lista 3 - Autocorrelação, densidade espectral de potência (PSD)
clear; clc; close all; 
disp('Lista 3 - Autocorrelação, densidade espectral de potência (PSD)')
disp('Eduardo Henrique Banaczewski')
pause; 

disp('-----------------')
disp('1) ');
img_zelda = (imread('zelda_s.tif'));
img_build = (imread('building.tif'));
img_text = (imread('text.tif'));
img_xray = (imread('xray.tif'));
figure('Name', 'Imagens');
subplot(2,2,1);
imshow(img_zelda);

axis on;

subplot(2,2,2);
imshow(img_build);
axis on;

subplot(2,2,3);
imshow(img_text);
axis on;

subplot(2,2,4);
imshow(img_xray);
axis on;

pause;
close all;

disp('-----------------')
disp('2) ');
p = [0.95, 0.7, 0.5, 0.1, -0.5];
[X, Y] = meshgrid(-127:127, -127:127);
for i = 1:length(p)
    disp(['p1 = p2 = ' num2str(p(i))]);
    figure('Name', ['Autocovariancia separavel: '  num2str(p(i))], 'Position', [100, 300, 1280, 960]);
    subplot(1,2,1);
    img = autocov_separavel(p(i), p(i), 1, X, Y);
    mesh(X, Y, img);
    title('Função R(m,n)')
    axis on;
    
    subplot(1,2,2);
    F = fft2(img);
    magnitude = log(abs(fftshift(F)) + 1);
    imshow(magnitude, []);
    title('FT');
    axis on;
    
    pause;
    close all;
end

pause;
close all;

disp('-----------------')
disp('3)');
disp('Nota: estou usando g = real(g);, para remover as partes não reais')
for i = 1:length(p)
    disp(['p1 = p2 = ' num2str(p(i))]);
    figure('Name', ['Autocovariancia isotropica: '  num2str(p(i))], 'Position', [100, 300, 1280, 960]);
    subplot(1,2,1);
    img = autocov_isotropica(p(i), 1, X, Y);
    mesh(img);
    title('Função R(m,n)')
    axis on;
    
    subplot(1,2,2);
    F = fft2(img);
    magnitude = log(abs(fftshift(F)) + 1);
    imshow(magnitude, []);
    title('FT');
    axis on;
    
    pause;
    close all;
end

pause;
close all;

disp('-----------------')
disp('4)')
img_zelda = double(imread('zelda_s.tif'));
img_build = double(imread('building.tif'));
img_text = double(imread('text.tif'));
img_xray = double(imread('xray.tif'));
imgs = {img_zelda, img_build, img_text, img_xray};
nomes = {'ZELDA', 'BUILDING', 'TEXT', 'XRAY'};
resultados = cell(1, length(imgs));

disp('Nesse caso, nenhum dos processos pode ser considerado estacionário.')
disp('Para ser considerado estacionário (WSS), a média deve ser constante e a Autocovariancia, ')
disp(' dependender apenas da distância (deslocamento) entre os pixeis. ')
disp('ZELDA: possui regiões bem definidas, como fundo, rosto, cabelo, logo as médias calculadas,  ')
disp(' são diferentes para determinadas regiões. ')
disp('BUILDING: nessa imagem, também temos regiões com brilho e contraste diferentes (céu, paredes...)')
disp(' a correlação entre os pixeis varia bastante. ')
disp('TEXT: aqui, a média da região do texto fica bem baixa, porém ela contrasta com o fundo, ')
disp(' que possui uma média mais alta. ')
disp('XRAY: entre essas 4 imagens, essa visualmente parece a mais estavel, por apresentar apenas ')
disp(' um "objeto", porém as definições de regiões de ossos, contrastam com as de tecidos e etc. ')
pause;
disp('>>>>> Ao continuar, serão apresentadas as matrizes de autocovariancia (em forma de matriz de cor) ')
disp(' e as estatisticas referentes as diagonais (baseadas na distancia).')
disp('Após, a média dos elementos diagonais é calculada para aproximar ')
disp(' de um processo estacionário, e são plotadas as funções de autocov. ')
pause;


for i = 1:length(imgs)
     figure('Name', ['Imagem original: ' nomes{i}], 'Position', [1500, 500, 1200, 500]);
     imshow(imgs{i}, []);
     axis on;

     disp(['Calculando autocovariancia separavel das linhas e colunas para imagem: ' nomes{i}]);
     cov_linhas = cov(transpose(imgs{i}));
     % C(i,j), significa a covariancia entre a linha I  com a linha J. 
     cov_colunas = cov(imgs{i});

     % plot de cor das matrizes de cov. 
     figure('Name', ['Matrizes de cov (cor): ' nomes{i}], 'Position', [100, 300, 1200, 500]);
     subplot(1,2,1);
     imagesc(cov_linhas);
     title('cov matrix linhas');
     axis on;
     colorbar;

     subplot(1,2,2);
     imagesc(cov_colunas);
     title('cov matrix colunas');
     axis on;
     colorbar;

     % estatisticas de media e desvio padrão para as 5 primeiras distancias
     disp('Estatisticas para 5 primeiros deslocamentos de linhas: ')
     for k = 0:5  
        diag_vals = diag(cov_linhas, k);
        media = mean(diag_vals);
        desvio = std(diag_vals);
        fprintf('Lag %d: Média = %.2f, Desvio = %.2f (Variância relativa = %.2f%%)\n', ...
                 k, media, desvio, (desvio/media)*100);
     end
     disp('-------------------------')
     disp('Estatisticas para 5 primeiros deslocamentos de colunas: ')
     for k = 0:5  
         diag_vals = diag(cov_colunas, k);
         media = mean(diag_vals);
         desvio = std(diag_vals);
         fprintf('Lag %d: Média = %.2f, Desvio = %.2f (Variância relativa = %.2f%%)\n', ...
                 k, media, desvio, (desvio/media)*100);
     end
     disp('-------------------------')
     % verificando o valor de media e desvio padrão, percebemos que não é
     % estacionaria, o que faz sentido considerando que a imagem zelda tem
     % regioes diferentes (rosto, fundo, cabelo). então temos texturas e e
     % variancias diferentes (não estacionaria).
     
     % agora como não sao estacionarios, preciso calcular a média dos elementos
     % de cada diagonal, para ter uma aproximação:

     C = cov_linhas;
     N = size(C,1);
     c_row = zeros(N,1);
     for k = 0:N-1
         c_row(k+1) = mean(diag(C,k));
     end
     
     C = cov_colunas;
     N = size(C,1);
     c_col = zeros(N,1);
     for k = 0:N-1
         c_col(k+1) = mean(diag(C,k));
     end

     c_row_sym = [flip(c_row(2:end)); c_row]; 
     lags_row = -(length(c_row)-1):(length(c_row)-1);
     c_col_sym = [flip(c_col(2:end)); c_col]; 
     lags_col = -(length(c_col)-1):(length(c_col)-1);

     figure('Name', ['Função de autocov: ' nomes{i}], 'Position', [500, 700, 1200, 500]);
     subplot(1,2,1);
     plot(lags_row, c_row_sym,'LineWidth',2)
     xlabel('Deslocamento')
     ylabel('Autocov')
     title('Função Autocov das linhas')
     grid on;
     
     subplot(1,2,2);
     plot(lags_col, c_col_sym,'LineWidth',2)
     xlabel('Deslocamento')
     ylabel('Autocov')
     title('Função Autocov das colunas')
     grid on;
     
     % agora preciso gerar a autocovariancia bidimensional. 
     C2D = c_row * c_col.';
     figure('Name', ['Função 2d: ' nomes{i}], 'Position', [800, 800, 1200, 500]);
     subplot(1,2,1); imshow(C2D, []); title('2D'); axis on; colormap('jet'); colorbar;
     subplot(1,2,2); mesh(C2D); xlabel('(n)'); ylabel('(m)'); zlabel('R(m,n)'); axis on; grid on;  


     % salvar resultados para questao 5
     resultados{i}.nome = nomes{i};
     resultados{i}.imagem = imgs{i};
     resultados{i}.c_row = c_row;
     resultados{i}.c_col = c_col;
     resultados{i}.C2D = C2D;
     
     pause; 
     close all;
end

pause;
close all;

disp('-----------------')
disp('5) ')
disp('5.a/b)')
disp('Vou mostrar a a/b juntas. ')
disp('Utilizando a autocovariancia das colunas de cada imagem, modelei a função de autocov. ')
disp('Os plots mostram autocov no espaço, espectro e um "zoom" no espectro de -0.05 a 0.05, ')
disp(' para melhor visualização. A frequencia é normalizada também.  ')
disp('NOTA: utilizei a relação de C(0) para encontrar variancia, e C(0)/C(1) para encontrar rho.')
% usando a função de autocov das COLUNAS, modelar
for i = 1:length(imgs)
    nome = resultados{i}.nome;
    c_col = resultados{i}.c_col;

    sigma2 = c_col(1);
    rho = c_col(2)/c_col(1);
    
    lags = -(length(c_col)-1):(length(c_col)-1);
    c_col_sym = [flipud(c_col(2:end)); c_col];
    
    r_modelo = sigma2 * rho.^abs(lags);
    
    % FFT da autocovariância estimada (simetrica0
    R_real = fftshift(abs(fft(c_col_sym, 1024)));
    
    % FFT do modelo
    R_modelo = fftshift(abs(fft(r_modelo, 1024)));
    
    % eixo de frequência normalizado
    f = linspace(-0.5,0.5,1024);
    
    figure('Name',['Questão 5b - ' nomes{i}], 'Position',[300 300 1200 500]);
    
    % tempo
    subplot(1,3,1)
    plot(lags,c_col_sym,'b','LineWidth',2)
    hold on
    plot(lags,r_modelo,'r--','LineWidth',2)
    legend('Estimada','Modelo exponencial')
    xlabel('Deslocamento')
    ylabel('r(n)')
    title(sprintf('%s: \\sigma^2 = %.2f, \\rho = %.4f', ...
          nomes{i}, sigma2, rho))
    grid on
    
    % frequência
    subplot(1,3,2);
    plot(f,R_real,'b','LineWidth',2)
    hold on
    plot(f,R_modelo,'r--','LineWidth',2)
    xlabel('Frequência Normalizada')
    ylabel('|FFT|')
    title('Domínio da frequência')
    legend('Estimada','Modelo exponencial')
    grid on

    % zoom a 0.05
    subplot(1,3,3)
    plot(f, R_real, 'b', 'LineWidth', 2)
    hold on
    plot(f, R_modelo, 'r--', 'LineWidth', 2)
    xlabel('Frequência Normalizada')
    ylabel('FFT')
    title('Domínio da Frequência (Zoom)')
    legend('Estimada', 'Modelo exponencial', 'Location', 'best')
    grid on
    xlim([-0.05, 0.05]) 

    pause;
    close all;

end
disp('Os modelos exponenciais podem ser considerados muito bons para as frequências baixas, ')
disp(' isso pode ser observado com a sobreposição das linhas vermelhas pontilhadas (modelo exp) ')
disp(' com as linhas continuas azues (modelo estimado), em quase todas as imagens, nas frequencias ')
disp(' iniciais. Porém, no dominio do "tempo", conforme a imagem a distância aumenta, as duas funções ')
disp(' acabam se diferenciando, os modelos estimados em um geral possuem bastante disturbio. ')
disp('NOTA: nesse caso o espectro de frequência é a PSD (power spectral density). ')
disp(' nesse caso, se as curvas dos modelos forem parecidas, significa que o espectro é suave, ')
disp(' e pode ser bem descrito pelo modelo exponencial..')
disp('Comentários especificos por imagem: ')
disp('ZELDA: O modelo exponencial pode ser considerado bom, ele e o modelo estimado possuem ')
disp(' bastante sobreposição, e apesar da FFT do modelo estimado apresentar bastante oscilação, ')
disp(' ela se assemelha bastante com a da FFT do modelo exponencial. ')
disp('BUIDLING: nessa imagem, o modelo estimado possui muitos picos que oscilam positiva e ')
disp(' negativamente, o modelo exponencial consegue acompanhar apenas nas distânciais inicias. ')
disp(' um comportamento parecido é observado no dominio da frequencia. Não consideraria ')
disp(' esse um modelo bom. ')
disp('TEXT: A primeira situação que noto, é um pico alto na frequencia DC do modelo estimado, ')
disp(' e muitas oscilações ao decorrer das freq. assim o modelo exponencial não consegue acompanhar. ')
disp(' e consequentemente não sendo um bom modelo para descrever essa imagem. ')
disp('XRAY: Para essa imagem, nenhuma parte dos plots se sobrepoe no dominio do "tempo", ')
disp(' e o ajuste no dominio da frequência também não encaixa. O pico DC é bem alto. ')
disp(' não considero o modelo exponencial uma boa representação. ')
pause;
close all;

disp('-----------------')
disp('6)')
img_zelda = double(imread('zelda_s.tif'));
img_build = double(imread('building.tif'));
img_text = double(imread('text.tif'));
img_xray = double(imread('xray.tif'));
disp('Nessa questão, o processo estocastico observado muda, a região a ser considerada é uma ')
disp(' matriz de 8x8, isso implica uma observação local, ao inves de global (linha/coluna inteira) ')
disp(' nessa observação local, a similaridade entre os pixeis dentro dessa pequena região, ')
disp(' possui uma probabilidade maior de ser "homogenea". ')
disp('Nessa questão, plotando a matriz de autocovariancia, podemos observar que o processo é ')
disp(' aproximadamente estacionario (WSS). ')
disp('Na questão 4, a matriz de autocovariancia apresenta um alto valor nas diagonais, o ')
disp(' que não é observado na 6. Ainda na matriz da 6), observo que dentro dos blocos, temos  ')
disp(' matrizes toeplitz e simetrica. ')
for i = 1:length(imgs)
     figure('Name', ['Imagem original: ' nomes{i}], 'Position', [1500, 500, 1200, 500]);
     imshow(imgs{i}, []);
     axis on;

    X_cols = reshape(imgs{i}, 8, [])'; 
    cov_cols = cov(X_cols);  % Gera matriz 8x8
    
    % Autocovariância das LINHAS (Horizontal)
    % Transpomos a imagem original primeiro para pegar as linhas dos blocos.
    X_linhas = reshape(imgs{i}', 8, [])'; 
    cov_linhas = cov(X_linhas);  % Gera matriz 8x8
    
    figure('Name', ['Matrizes de cov (cor): ' nomes{i}]);
    subplot(1,2,1); imagesc(cov_cols); title('Cov Colunas 8x8'); colorbar; axis square;
    subplot(1,2,2); imagesc(cov_linhas); title('Cov Linhas 8x8'); colorbar; axis square;
   
    R_linhas = zeros(1, 8);
    R_colunas = zeros(1, 8);
    % media de cada diagonal 
    for k = 0:7
        R_colunas(k+1) = mean(diag(cov_cols, k));
        R_linhas(k+1)  = mean(diag(cov_linhas, k));
    end

     R_2D_full = zeros(15,15);
     for dx = -7:7
         for dy = -7:7
             R_2D_full(dx+8, dy+8) = R_linhas(abs(dx)+1) * R_colunas(abs(dy)+1);
         end
     end
     figure('Name', ['2D Separavel:' nomes{i}], 'Position', [300, 300, 800, 800]);
     mesh(-7:7, -7:7, R_2D_full);
     xlabel('Deslocamento horizontal (dy)');
     ylabel('Deslocamento vertical (dx)');
     zlabel('R(dx, dy)');
     title('Superfície 2D (Blocos)');
     colormap('jet');
     colorbar;
     grid on;
     

     % modelagem exponencial 
     sigma2_linhas = R_linhas(1);
     ratios_linhas = R_linhas(2:end) ./ R_linhas(1:end-1);
     valid_linhas = isfinite(ratios_linhas) & (R_linhas(1:end-1) > 0) & (R_linhas(2:end) > 0);
     rho_linhas = mean(ratios_linhas(valid_linhas));

     sigma2_colunas = R_colunas(1);
     ratios_colunas = R_colunas(2:end) ./ R_colunas(1:end-1);
     valid_colunas = isfinite(ratios_colunas) & (R_colunas(1:end-1) > 0) & (R_colunas(2:end) > 0);
     rho_colunas = mean(ratios_colunas(valid_colunas));

     n_lags = 0:7;
     R_model_linhas = sigma2_linhas * (rho_linhas .^ n_lags);
     R_model_colunas = sigma2_colunas * (rho_colunas .^ n_lags);

     R_linhas_sym = [fliplr(R_linhas(2:end)), R_linhas];
     R_colunas_sym = [fliplr(R_colunas(2:end)), R_colunas];
     R_mod_linhas_sym = [fliplr(R_model_linhas(2:end)), R_model_linhas];
     R_mod_colunas_sym = [fliplr(R_model_colunas(2:end)), R_model_colunas];
     lags = -(7):7;

     figure('Name', ['Blocos: ' nomes{i}], 'Position', [500, 500, 1200, 500]);
     
     subplot(1,2,1);
     plot(lags, R_linhas_sym, 'b-', 'LineWidth', 2); hold on;
     plot(lags, R_colunas_sym, 'r-', 'LineWidth', 2);
     plot(lags, R_mod_linhas_sym, 'b--', 'LineWidth', 1.5);
     plot(lags, R_mod_colunas_sym, 'r--', 'LineWidth', 1.5);
     xlabel('Deslocamento');
     ylabel('Autocovariância');
     legend('Vertical (calculada)', 'Horizontal (calculada)', ...
            'Vertical (modelada)', 'Horizontal (modelada)', 'Location', 'best');
     title('Domínio do Tempo');
     grid on;
     xlim([-7 7]);
     
     subplot(1,2,2);
     L = 512;
     freq_axis = linspace(-0.5, 0.5, L);
     F_vert_emp = fftshift(fft(R_linhas_sym, L));
     F_hor_emp = fftshift(fft(R_colunas_sym, L));

     F_vert_mod = fftshift(fft(R_mod_linhas_sym, L));
     F_hor_mod = fftshift(fft(R_mod_colunas_sym, L));
     mag_vert_emp = log10(abs(F_vert_emp) + eps);
     mag_hor_emp = log10(abs(F_hor_emp) + eps);
     mag_vert_mod = log10(abs(F_vert_mod) + eps);
     mag_hor_mod = log10(abs(F_hor_mod) + eps);
     plot(freq_axis, mag_vert_emp, 'b-', 'LineWidth', 2); hold on;
     plot(freq_axis, mag_hor_emp, 'r-', 'LineWidth', 2);
     plot(freq_axis, mag_vert_mod, 'b--', 'LineWidth', 1.5);
     plot(freq_axis, mag_hor_mod, 'r--', 'LineWidth', 1.5);
     xlabel('Frequência normalizada');
     ylabel('Magnitude');
     legend('Vertical (calculada)', 'Horizontal (calculada)', ...
            'Vertical (modelada)', 'Horizontal (modelada)', 'Location', 'best');
     title('FFT');
     grid on;
     xlim([-0.5, 0.5]);
     
     sgtitle(['(σ²=' num2str(sigma2_linhas,3) ', ρ=' num2str(rho_linhas,3) ')']);

     pause; 
     close all;
end

pause; 
close all;

disp('-----------------')
disp('7) ')

disp('Ao considerar uma covariância não separavel, perdemos a relação de independencia entre ')
disp('as verticais e horizontais (Rm,n) = Rvertical(m)*Rvertical(n)... ')

disp('Assim, a autocovariancia precisa ser calculada utilizando cada par de distancias possiveis. ')
disp(' e a função 2D é extraida diretamente da matriz de covariancia. ')

disp('Aqui, para calcular a matriz de cov nao separavel, ')
disp('empilho as colunas dos blocos 8x8 e aplico cov() ')
disp('A matriz de covariância nesse caso, é toeplitz dentro de cada bloco 8x8, porem ')
disp('se difere entre blocos. ')

disp('Esse processo pode ser considerado estacionario, pois, dentro de cada bloco 8x8 temos toeplitz.  ')
disp(' e cada bloco 8x8 se repete de certa maneira, como uma toeplitz no decorrer da 64x64. ')
disp(' ---- se considerarmos cada bloco 8x8 como um bloco. ')
disp('Então posso dizer que é um processo "quase" estácionario. ')

disp('A forma da superficie da função 2d, reflete melhor as direções predominantes ')
disp(' de cada imagem, contendo mais informação estrutural. ')

disp('NOTA: o que entendi sobre a interpretação dessa superficie, é que ela mostra ')
disp(' a relação de quanto a direção de deslocamento de um pixel a outro ')
disp(' é abrupta ou suave, por exemplo, em ZELDA, o decaimento é similar em todas ')
disp(' direções a partir do centro, o que pode significar uma alta similaridade em ')
disp(' todas as direções. Em XRAY, ela é ainda mais suave. ')
disp(' Já em TEXT, ela tem um decaimento mais suave em uma orientação, e mais forte em outra, ')
disp(' mostrando que ao deslocar na diagonal ou para cima, existe mais chance de sair da letra e ir a um pixel diferente.')


for i = 1:length(imgs)
    blocks = im2col(imgs{i}, [8 8], 'distinct'); 
    X_blocos = blocks'; % nblocos x 64
    C_nao_separavel = cov(X_blocos); 
    
    figure('Name', ['Covariancia n separavel: ' nomes{i}], 'Position', [100, 300, 600, 500]);
    imagesc(C_nao_separavel);
    colorbar;
    axis square;
    
    % autocovariância bidimensional 
    R_2D_nao_sep = zeros(15, 15);
    contagem = zeros(15, 15);
    
    % (m, n) do bloco é mapeado para o índice idx = m + 8*n
    % itera em todos pares de indices 
    for idx1 = 0:63
        m1 = mod(idx1, 8);
        n1 = floor(idx1 / 8);
        
        for idx2 = 0:63
            m2 = mod(idx2, 8);
            n2 = floor(idx2 / 8);
            
            % deslocamentos 
            dm = m1 - m2; % Deslocamento vertical (-7 a 7)
            dn = n1 - n2; % Deslocamento horizontal (-7 a 7)
            
            i_dm = dm + 8;
            i_dn = dn + 8;
            
            % acumula os valores de cov
            R_2D_nao_sep(i_dm, i_dn) = R_2D_nao_sep(i_dm, i_dn) + C_nao_separavel(idx1 + 1, idx2 + 1);
            contagem(i_dm, i_dn) = contagem(i_dm, i_dn) + 1;
        end
    end
    
    % media
    R_2D_nao_sep = R_2D_nao_sep ./ contagem;
    
    figure('Name', ['2D Não-Separável: ' nomes{i}], 'Position', [750, 300, 800, 600]);
    [X_grid, Y_grid] = meshgrid(-7:7, -7:7);
    mesh(X_grid, Y_grid, R_2D_nao_sep);
    xlabel('Deslocamento horizontal (dn)');
    ylabel('Deslocamento vertical (dm)');
    zlabel('R(dm, dn)');
    title(['Superfície 2D Não-Separável (Blocos) - ' nomes{i}]);
    colormap('jet');
    colorbar;
    grid on;
    
    pause;
    close all;
end

pause; 
close all;

function g = autocov_isotropica(p, var, X, Y)  
    g = (var)*(p.^sqrt((X.^2)+(Y.^2)));
    g = real(g);
end

function g = autocov_separavel(p1, p2, var, X, Y)
    g = (var)*(p1.^abs(X)).*(p2.^abs(Y));
end

