function resultado = polynomial(a,b,c,d,y1,y2,y3,y4)
  A = [a^3,a^2,a,1;
  	b^3,b^2,b,1;
  	c^3,c^2,c,1;
  	d^3,d^2,d,1];
  B = [y1;y2;y3;y4];
  resultado = A\B;
endfunction
