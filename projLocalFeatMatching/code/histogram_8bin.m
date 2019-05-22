function [histogram_8bin] = histogram_8bin(grad,direc)
  histogram_8bin = zeros(1,8);
  for i = 1:rows(grad)
    for j = 1:columns(grad)
      if(direc(i,j) != 360 && 360-direc(i,j) != 360)
        histogram_8bin(floor(xor([false true], direc(i,j) <0) * [360 + direc(i,j); direc(i,j)]/45)+1)+=grad(i,j);
      else
        histogram_8bin(1)+=grad(i,j);
      endif
      

    endfor
  endfor
endfunction
