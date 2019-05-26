function [gradient, direction] = calcula_gradient_direction(grid)
  % para cada 4x4 grade de celulas faça:
  sobel = fspecial('sobel'); % pega o filtro do sobel
  gx = imfilter(grid, sobel); % aplica o sobel na horizontal
  gy = imfilter(grid, sobel'); % aplica o sobel na vertical

  gradient = hypot(gx,gy); % calcula o gradiente para cada um dos elementos
  %gradient = imgradient(grid);
  %direction = atan2(gy,gx); % calcula a direção do gradiente
  direction = atan2d(gy,gx); % calcula em graus
endfunction
