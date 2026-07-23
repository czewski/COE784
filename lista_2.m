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

figure('Name', 'Convolution', 'NumberTitle', 'off')
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

figure('Name', 'Convolution', 'NumberTitle', 'off')
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

figure('Name', 'Convolution', 'NumberTitle', 'off')
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

figure('Name', 'Convolution', 'NumberTitle', 'off')
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
thetas = [0, 0, 0, 0, 90, 90, 90, 90, 45, 45, 30, 70];
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
pause;
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
pause;
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

figure('Name', 'Fourier Transform: H(u,v)', 'NumberTitle', 'off', 'Position', [100, 100, 1600, 900]);

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
title('3D Mesh View');
colormap('jet');
colorbar;
view(45, 30);
grid on;

subplot(1,2,2);
imshow(magnitude, []);
xlabel('u'); ylabel('v');
title('2D Grayscale View');
colormap('gray');
colorbar;
axis on;

pause;
close all;

disp('II) Exercicio 5: ');
pause;

%%%%%%%%%%%%%%%%%%%%
disp('zelda');
img = imread('matlabimages_cursos/zelda_s.tif');
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

pause;

%%%%%%%%%%%%%%%%%%%%
disp('text2');
img = imread('matlabimages_cursos/text2.tif');
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

pause;

%%%%%%%%%%%%%%%%%%%%
disp('square');
img = imread('matlabimages_cursos/square.tif');
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

pause;

%%%%%%%%%%%%%%%%%%%%
disp('jotav');
img = imread('matlabimages_cursos/jotav.tif');
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

pause;

%%%%%%%%%%%%%%%%%%%%
disp('jotad');
img = imread('matlabimages_cursos/jotad.tif');
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

pause;

%%%%%%%%%%%%%%%%%%%%
disp('triang');
img = imread('matlabimages_cursos/triang.tif');
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

pause;

%%%%%%%%%%%%%%%%%%%%
disp('circle');
img = imread('matlabimages_cursos/circle.tif');
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

pause;
close all;