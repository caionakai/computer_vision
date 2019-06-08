function [histogram_8bin] = histogram_8bin(grad,direc)
  % cria um vetor com zeros de tamanho 8
  histogram_8bin = zeros(1,8);
  % itera sobre a matriz 4x4
  for i = 1:rows(grad)
    for j = 1:columns(grad)
      histogram_8bin(floor(xor([false true], direc(i,j) <0) * [180+direc(i,j); direc(i,j)]/45)+1)+=grad(i,j);
    endfor
  endfor
endfunction
