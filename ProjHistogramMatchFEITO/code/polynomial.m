function resultado = polynomial(a,b,c,y1,y2,y3)
  A = [a^2,a,1;b^2,b,1;c^2,c,1];
  B = [y1;y2;y3];
  resultado = A\B;
endfunction
