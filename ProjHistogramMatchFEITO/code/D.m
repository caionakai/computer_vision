% funcao que calcula a diferenca de histogramas
function retorno = D(chan1, chan2) 

% pega o tamanho
  [x y] = size(chan1); 

% pega o histograma dos canais
  [counts] = imhist(chan1);
  [counts2] = imhist(chan2);

% o tamanho eh o mesmo portanto pode ser utilizado nos canais das duas imagens
  counts = counts/(x*y);
  counts2 = counts2/(x*y);

  retorno = 0;
  for i = 1:255 
    retorno = retorno + (counts2(i) - counts(i))^2;
  endfor
  
endfunction