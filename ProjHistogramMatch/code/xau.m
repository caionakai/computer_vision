function retorno = xau(s, histog)
  coefs = polynomial(s(1,1),s(2,1),s(3,1),s(1,2),s(2,2),s(3,2));
  h2 = floor(arrayfun(@(x) (coefs(1)*(x)^2 + coefs(2)*(x) + coefs(3)), 1:256)); 
  [nani nothing] = size(h2);
  for i= 1:nothing
    if(h2(i)>256)
      h2(i) = 256;
    endif
    if(h2(i) < 1)
      h2(i) = 1;
    endif
  endfor
  #retorno = imhist(histog(h2));
  retorno = uint8(h2(histog+1));
endfunction
