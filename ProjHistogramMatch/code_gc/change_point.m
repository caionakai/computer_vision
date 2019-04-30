function new_points = change_point(points, index)
  new_points = points;
  pkg load communications;  
  new_points(index,:) = randint(1,2, [-1 1]) + points(index,:);
endfunction

