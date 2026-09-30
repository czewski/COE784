% Lista 2 - Mathematical Preliminaries
% Funções de Transferência; 
clear; clc; close all; 

disp('I - Funções de Transferência'); 
pause; 

% Exercicio 1
disp('I) Exercicio 1: ');
x = [1 4 1; 2 5 3];
origin_x = [2, 1];
pause; 

% i)
disp('i)');
y = [0 -1 1; -1 4 -1; 0 -1 0];
origin_y = [2, 2];
pause;

figure('Name', 'Convolução', 'NumberTitle', 'off')
subplot(1,3,1);
spy(x); hold on;
plot(origin_x(2), origin_x(1), 'ro', 'MarkerSize', 10, 'LineWidth', 2); 
title('x'); grid on; hold off;

subplot(1,3,2);
spy(y); hold on;
plot(origin_y(2), origin_y(1), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
title('y'); grid on; hold off;

x_y = conv2(x, y);
subplot(1,3,3);
spy(x_y); 
title('x**y'); grid on;
pause;

pause;

% verify volume
vol_x = sum(x(:));
vol_y = sum(y(:));
vol_x_y = sum(x_y(:));
disp(['Volume de x: ' num2str(vol_x) ', Volume de y: ' num2str(vol_y) ', Volume esperado x_y: ' num2str(vol_x*vol_y) ', Volume de x_y: ' num2str(sum(x_y(:)))]);
pause;
pause;

% ii) 
disp('ii)');
y = [0 0 0; 1 2 3; 0 0 0];
origin_y = [2, 2];
pause;

figure('Name', 'Convolução', 'NumberTitle', 'off')
subplot(1,3,1);
spy(x); hold on;
plot(origin_x(2), origin_x(1), 'ro', 'MarkerSize', 10, 'LineWidth', 2); 
title('x'); grid on; hold off;

subplot(1,3,2);
spy(y); hold on;
plot(origin_y(2), origin_y(1), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
title('y'); grid on; hold off;

x_y = conv2(x, y);
subplot(1,3,3);
spy(x_y); 
title('x**y'); grid on;
pause;

% verify volume
vol_x = sum(x(:));
vol_y = sum(y(:));
vol_x_y = sum(x_y(:));
disp(['Volume de x: ' num2str(vol_x) ', Volume de y: ' num2str(vol_y) ', Volume esperado x_y: ' num2str(vol_x*vol_y) ', Volume de x_y: ' num2str(sum(x_y(:)))]);
pause;
pause;

% iii) 
disp('iii)');
y = [0 -2 0; 0 3 0; 0 -1 0];
origin_y = [2, 2];
pause;

figure('Name', 'Convolução', 'NumberTitle', 'off')
subplot(1,3,1);
spy(x); hold on;
plot(origin_x(2), origin_x(1), 'ro', 'MarkerSize', 10, 'LineWidth', 2); 
title('x'); grid on; hold off;

subplot(1,3,2);
spy(y); hold on;
plot(origin_y(2), origin_y(1), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
title('y'); grid on; hold off;

x_y = conv2(x, y);
subplot(1,3,3);
spy(x_y); 
title('x**y'); grid on;
pause;

pause;

% verify volume
vol_x = sum(x(:));
vol_y = sum(y(:));
vol_x_y = sum(x_y(:));
disp(['Volume de x: ' num2str(vol_x) ', Volume de y: ' num2str(vol_y) ', Volume esperado x_y: ' num2str(vol_x*vol_y) ', Volume de x_y: ' num2str(sum(x_y(:)))]);
pause;

pause; 


% 2) 
disp('I) Exercicio 2: ');
x = [0 0 0 0 0 0 0 0;
     1 1 1 1 0 0 0 0;
     0 1 1 1 1 0 0 0;
     0 0 1 1 1 1 0 0;
     0 0 0 0 0 0 0 0];

h = [0 1 0 0 0 0 0 0;
     0 1 0 0 0 0 0 0];
pause; 

figure('Name', 'Convolução', 'NumberTitle', 'off')
subplot(1,3,1);
spy(x); hold on;
plot(origin_x(2), origin_x(1), 'ro', 'MarkerSize', 10, 'LineWidth', 2); 
title('x'); grid on; hold off;

subplot(1,3,2);
spy(y); hold on;
plot(origin_y(2), origin_y(1), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
title('y'); grid on; hold off;

x_y = conv2(x, y);
subplot(1,3,3);
spy(x_y); 
title('x**y'); grid on;
pause;

% verify volume
vol_x = sum(x(:));
vol_y = sum(y(:));
vol_x_y = sum(x_y(:));
disp(['Volume de x: ' num2str(vol_x) ', Volume de y: ' num2str(vol_y) ', Volume esperado x_y: ' num2str(vol_x*vol_y) ', Volume de x_y: ' num2str(sum(x_y(:)))]);
pause;
 
close all; 

disp('II - Transformadas de Fourier'); 
pause; 

disp('II) Exercicio 1: ');
thetas = [0, 0, 0, 0, 90, 90, 90, 90, 90, 90, 45, 45, 30, 70];
ds = [256, 150, 64*sqrt(2), 64, 25, 16*sqrt(2), 10, 4, 2, 1, 32, 32*sqrt(2), 16, 4];
disp('Vetor de thetas: ');
disp(thetas);

disp('Vetor de d: ');
disp(ds);
pause;

size_m = 256;
size_n = 256;
num_images = length(thetas);
figure('Name', '2d', 'NumberTitle', 'off', 'Position', [100, 100, 800, 600]);
rows = 4;
cols = 4;

disp('Visualizações 2d: ');
for i = 1:num_images
    theta = thetas(i) * pi / 180;  % radianos
    d = ds(i);
   
    g = sinusoidal_image(d, theta, size_m, size_n);
    
    subplot(rows, cols, i);
    imshow(g, []);
    
    % titulos
    if thetas(i) == 0
        title(['\theta = 0°, d = ' num2str(ds(i), '%.1f')]);
    elseif thetas(i) == 90
        title(['\theta = 90°, d = ' num2str(ds(i), '%.1f')]);
    else
        title(['\theta = ' num2str(thetas(i)) '°, d = ' num2str(ds(i), '%.1f')]);
    end  
end
pause;

% mesh

disp('Visualizações 3d: ');
figure('Name', '3d', 'NumberTitle', 'off', 'Position', [25, 25, 1200, 800]);
for i = 1:num_images
    theta = thetas(i) * pi / 180;  % radianos
    d = ds(i);
   
    g = sinusoidal_image(d, theta, size_m, size_n);
     
    subplot(rows, cols, i);
    mesh(g);
    xlabel('n');
    ylabel('m');
    zlabel('g');
    
    if thetas(i) == 0
        title(['\theta = 0°, d = ' num2str(ds(i), '%.1f')]);
    elseif thetas(i) == 90
        title(['\theta = 90°, d = ' num2str(ds(i), '%.1f')]);
    else
        title(['\theta = ' num2str(thetas(i)) '°, d = ' num2str(ds(i), '%.1f')]);
    end
    
    view(45, 25);
    colormap('jet');
    grid on;
    axis tight;       
end
pause;

disp('Alterar o Theta, faz com que a angulação (direção) das listras alterem na imagem. Sendo 0 graus linhas horizontais, 45 graus linhas diagonais, 30 e 70 linhas inclinadas. ');
disp('Já os valores de D, controlam a frequência das listras, quanto maior D, menor frequência, resultando em listras largas e espaçadas; Já valores menores de D, tem alta frequência, gerando listras próximas e finas. ');
pause;
close all; 

disp('II) Exercicio 2: ');
pause;
figure('Name', 'Fourier Transform (DFT)', 'NumberTitle', 'off', 'Position', [50, 50, 1600, 900]);
for i = 1:num_images
    theta = thetas(i) * pi / 180; 
    d = ds(i);
    g = sinusoidal_image(d, theta, size_m, size_n);
    
    G = fft2(g);
    
    % Shift zero frequency to center
    G_shifted = fftshift(G);
    
    % Compute magnitude spectrum (log scale for better visualization)
    magnitude = log(abs(G_shifted) + 1);
    
    % Plot grayscale image
    subplot(rows, cols, i);
    imshow(magnitude, []);
    axis tight;
    
    if thetas(i) == 0
        title(['\theta = 0°, d = ' num2str(ds(i), '%.1f')]);
    elseif thetas(i) == 90
        title(['\theta = 90°, d = ' num2str(ds(i), '%.1f')]);
    else
        title(['\theta = ' num2str(thetas(i)) '°, d = ' num2str(ds(i), '%.1f')]);
    end
end
pause;

% Comente sobre o significado de ? e d.
disp('Na DFT, uma linha de picos na vertical significa linhas horizontais na imagem (2D), e uma linha de picos na horizontal (DFT), significa linhas verticais na imagem (2D).');
disp('Podemos afirmar que Theta controla a orientação dos picos no espectro de Fourier. ');
disp('e que D, controla a distância dos picos em relação ao centro do espectro. ');
disp('um D maior, reflete picos próximos ao centro na DFT, já um D pequeno, mostra picos próximos das bordas da imagem. ');
pause;

% Comente sobre oefeito da relac˜ao entre ? e d na DFT das imagens.
disp('Tanto o Theta quanto o D, contribuem para o espectro da DFT; ');
disp('Theta com o ângulo dos picos, e D com o raio dos picos. ');

pause;

% O que acontece quando d = 1 e d = 2? Explique.
disp('Um D muito baixo resulta em uma imagem com frequências muito altas (e períodos pequenos). ');
disp('A imagem, quando o D=1, é totalmente branca, e na visualização 3D, um plano, já no espectro de frequência, tenho apenas um pico no centro da imagem. ');
disp('Acredito que isso acontece devido a função utilizar 2*pi/d');

disp('Já com D=2, pico no espectro DFT está na borda esquerda. Na imagem tenho linhas verticais, com uma leve sobreposição no centro, no visualização 3D, as senoides formam quase um bloco completo.   ');
disp('Acredito que esse efeito de sobreposição na imagem seja relacionado a aliasing');
pause;

close all; 


disp('II) Exercicio 3: ');
pause;

x0 = 0;
y0 = 0;

% 50x50 grid -> [-2, 2]
N = 50;
x = linspace(-2, 2, N);
y = linspace(-2, 2, N);

% 2d grid
[X, Y] = meshgrid(x, y);

h = 2 * ((sin(pi * (X - x0)) ./ (pi * (X - x0))).^2) .* ((sin(pi * (Y - y0)) ./ (pi * (Y - y0))).^2);

% 3D Mesh
figure('Name', 'Resposta ao impulso: h(x,y)', 'NumberTitle', 'off', 'Position', [100, 100, 800, 600]);

mesh(X, Y, h);
xlabel('x');
ylabel('y');
zlabel('h(x,y)');
title('Resposta ao impulso: h(x,y)');
colormap('jet');
colorbar;
view(45, 30);
grid on;

pause; 
close all; 

disp('II) Exercicio 4: ');
pause;

figure('Name', 'DFT: H(u,v)', 'NumberTitle', 'off', 'Position', [100, 100, 1600, 900]);

% DFT
H = fft2(h);
H_shifted = fftshift(H);
magnitude = log(abs(H_shifted) + 1);


freq_x = linspace(-2, 2, N);
freq_y = linspace(-2, 2, N);
[FX, FY] = meshgrid(freq_x, freq_y);


subplot(1,2,1);
mesh(FX, FY, magnitude);
xlabel('u'); ylabel('v'); zlabel('|H(u,v)|');
title('3D');
colormap('jet');
colorbar;
view(45, 30);
grid on;

subplot(1,2,2);
imshow(magnitude, []);
xlabel('u'); ylabel('v');
title('2D');
colormap('gray');
colorbar;
axis on;

pause;
close all;

disp('II) Exercicio 5: ');
pause;

%%%%%%%%%%%%%%%%%%%%
disp('zelda');
img = imread('zelda_s.tif');
img = double(img);

figure('Name', 'Imagem', 'NumberTitle', 'off', 'Position', [100, 100, 1200, 600]);
subplot(1,2,1);
imshow(img, []);
colormap('gray');
axis on;

% 2D FFT
F = fft2(img);
F_shifted = fftshift(F);

% log
magnitude = abs(F_shifted);
log_magnitude = log(magnitude + 1);

subplot(1,2,2);
imshow(log_magnitude, []);
title('Log Magnitude da Transformada de Fourier');
xlabel('u');
ylabel('v');
colorbar;
axis on;

disp('Essa imagem tem tons claros, quase brilhosos. Na DFT, esse brilho é representado por um centro brilhoso, e nas bordas uma menor concentração de frequências. ');
disp('Já as caracteristicas da personagem (rosto, cabelo, roupa), possuem diversas frequências variadas, que podem ser observadas na "cruz" no decorrer do espectro (tanto vertical quanto horizontal)');
pause;

%%%%%%%%%%%%%%%%%%%%
disp('text2');
img = imread('text2.tif');
img = double(img);

figure('Name', 'Imagem', 'NumberTitle', 'off', 'Position', [100, 100, 1200, 600]);
subplot(1,2,1);
imshow(img, []);
colormap('gray');
axis on;

% 2D FFT
F = fft2(img);
F_shifted = fftshift(F);

% log
magnitude = abs(F_shifted);
log_magnitude = log(magnitude + 1);

subplot(1,2,2);
imshow(log_magnitude, []);
title('Log Magnitude da Transformada de Fourier');
xlabel('u');
ylabel('v');
colorbar;
axis on;

disp('Ao comparar essa imagem com a anterior, temos muito menos brilho, porém mais detalhes de letras. ');
disp('O centro da DFT, está bem menos concentrado, devido as letras, as frequências próximas ao centro, estão distribuídas em uma faixa maior (mas ainda no estilo de cruz)');

pause;

%%%%%%%%%%%%%%%%%%%%
disp('square');
img = imread('square.tif');
img = double(img);

figure('Name', 'Imagem', 'NumberTitle', 'off', 'Position', [100, 100, 1200, 600]);
subplot(1,2,1);
imshow(img, []);
colormap('gray');
axis on;

% 2D FFT
F = fft2(img);
F_shifted = fftshift(F);

% log
magnitude = abs(F_shifted);
log_magnitude = log(magnitude + 1);

subplot(1,2,2);
imshow(log_magnitude, []);
title('Log Magnitude da Transformada de Fourier');
xlabel('u');
ylabel('v');
colorbar;
axis on;

disp('Esta imagem do quadrado, possuí uma area branca grande, que pode ser facilmente observada na DFT, como uma cruz intensa')
disp('Existe um padrão "quadriculado e ondulado" acontecendo no espectro de frequência também, acredito que seja devido ao fato da transformada Fourier de um quadrado, ser um SINC '); 
pause;

%%%%%%%%%%%%%%%%%%%%
disp('jotav: ');
img = imread('jotav.tif');
img = double(img);

figure('Name', 'Imagem', 'NumberTitle', 'off', 'Position', [100, 100, 1200, 600]);
subplot(1,2,1);
imshow(img, []);
colormap('gray');
axis on;

% 2D FFT
F = fft2(img);
F_shifted = fftshift(F);

% log
magnitude = abs(F_shifted);
log_magnitude = log(magnitude + 1);

subplot(1,2,2);
imshow(log_magnitude, []);
title('Log Magnitude da Transformada de Fourier');
xlabel('u');
ylabel('v');
colorbar;
axis on;

disp('O J não é perfeitamente simétrico, causando uma faixa de distribuição maior na cruz (vertical e horizontal) do espectro. ');
disp('Devido a sua forma, ele cria um espectro um pouco mais espalhado do que um simples retangulo. (composição de retangulos)');
pause;

%%%%%%%%%%%%%%%%%%%%
disp('jotad: ');
img = imread('jotad.tif');
img = double(img);

figure('Name', 'Imagem', 'NumberTitle', 'off', 'Position', [100, 100, 1200, 600]);
subplot(1,2,1);
imshow(img, []);
colormap('gray');
axis on;

% 2D FFT
F = fft2(img);
F_shifted = fftshift(F);

% log
magnitude = abs(F_shifted);
log_magnitude = log(magnitude + 1);

subplot(1,2,2);
imshow(log_magnitude, []);
title('Log Magnitude da Transformada de Fourier');
xlabel('u');
ylabel('v');
colorbar;
axis on;

disp('Comparando com o J anterior, este possui uma inclinação. Assim, os picos da DFT rotacionam junto com a letra (similar as rotações observadas no exercicio anterior)');
pause;

%%%%%%%%%%%%%%%%%%%%
disp('triang: ');
img = imread('triang.tif');
img = double(img);

figure('Name', 'Imagem', 'NumberTitle', 'off', 'Position', [100, 100, 1200, 600]);
subplot(1,2,1);
imshow(img, []);
colormap('gray');
axis on;

% 2D FFT
F = fft2(img);
F_shifted = fftshift(F);

% log
magnitude = abs(F_shifted);
log_magnitude = log(magnitude + 1);

subplot(1,2,2);
imshow(log_magnitude, []);
title('Log Magnitude da Transformada de Fourier');
xlabel('u');
ylabel('v');
colorbar;
axis on;

disp('Assim como o quadrado, o triângulo possui um padrão de repetições, porém devido aos ângulos do triangulo, existe uma inclinação no espectro de frequências. ');
disp('A fourier de um triangulo também é um padrão sinc, porém ele gera uma forma uma pouco mais complexa no espectro de frequência. ');
pause;

%%%%%%%%%%%%%%%%%%%%
disp('circle');
img = imread('circle.tif');
img = double(img);

figure('Name', 'Imagem', 'NumberTitle', 'off', 'Position', [100, 100, 1200, 600]);
subplot(1,2,1);
imshow(img, []);
colormap('gray');
axis on;

% 2D FFT
F = fft2(img);
F_shifted = fftshift(F);

% log
magnitude = abs(F_shifted);
log_magnitude = log(magnitude + 1);

subplot(1,2,2);
imshow(log_magnitude, []);
title('Log Magnitude da Transformada de Fourier');
xlabel('u');
ylabel('v');
colorbar;
axis on;

disp('Já o circulo, apresenta um centro brilhante, com algumas "distorções" simétricas na DFT, como se fossem aneis em repetição. '); 
disp('Essa simetria radial, ocorre ainda nas direções centrais horizontais e verticais. Demonstrando a simetria. ');
pause;
close all;

function g = sinusoidal_image(d, theta, size_m, size_n)
    [n, m] = meshgrid(0:size_n-1, 0:size_m-1);
    g = 0.5 + 0.5 * cos((2*pi/d) * (m * cos(theta) + n * sin(theta)));
end