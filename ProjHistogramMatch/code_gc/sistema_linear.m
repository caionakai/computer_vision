function y = sistema_linear(points)
  A = zeros(rows(points),rows(points));
  B = zeros(rows(points));
  for i=1:rows(points)
    for j=1:rows(points)
      A(i,j) = points(i,1)^(rows(points)-1);
    end
    B(i) = points(i,2);
  end
  y = A\B;
endfunction

