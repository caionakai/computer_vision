function retorno = calculatesTable2(s, histog)
  h1 = imhist(histog);
  
  coefs = polynomial(s(1,1),s(2,1),s(3,1),s(1,2),s(2,2),s(3,2));
  
  h2 = floor(arrayfun(@(x) (coefs(1)*(x)^2 + coefs(2)*(x) + coefs(3)) , 
                        s(1,1):s(3,2))); 
  plot(h2);
  h2
  retorno = h1(h2);
endfunction
