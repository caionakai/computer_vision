function y = f(points, x)
  y = 0.0;
  for i=1:rows(points)
    for j=1:rows(points)
      y = y + points(i,1)*x^(rows(points)-1);
    end
  end
  y = floor(y);
endfunction

