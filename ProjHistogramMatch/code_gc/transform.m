function hist = transform(points, img)
  transform_function = arrayfun(@(x) f(sistema_linear(points),x), 1:256);
  hist = uint8(transform_function(img+1));
endfunction

