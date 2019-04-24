function retorno = calculatesTable(s, histog)
  # fixed for second degree polynomial
  coefs = polynomial(s(1,1),s(2,1),s(3,1),s(1,2),s(2,2),s(3,2));
  #value = zeros(rows(histog),columns(histog));
  value = arrayfun(@(x) (coefs(1)*x^2 + coefs(2)*x + coefs(3)) , histog);
  #[tamanho nada] = size(histog);
  #for i= 1:rows(histog)
  #  for j= 1:columns(histog)
  #    value(i,j) = (coefs(1)*histog(i)^2+coefs(2)*histog(i)+coefs(3));  
  #  endfor
  #endfor
  
  retorno = value;
endfunction
