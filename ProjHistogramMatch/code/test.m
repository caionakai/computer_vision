function main()  
  imagens = ['img1_patch', 'img2_patch', 'img1','img2'];
  input_path = '../data';
  output_path = '../data_out';
  img1 = imread(sprintf("%s/%s.png",input_path,imagens(1)));
  img2 = imread(sprintf("%s/%s.png",input_path,imagens(2)));
  points_channels = zeros(3);
  start_point = [[1,1];[128,128];[256,256]];
  for i= 1:3
    points_channels(i) = simulate(start_point,img1(:,:,i),img2(:,:,i));
  end
  for i=1:4
    imwrite(app(imread(sprintf("%s/%s.png",input_path,imagens(i))),points_channels),sprintf("%s/%s.png",output_path,imagens(i)))
  end

endfunction

function hist = h(img)
  hist = imhist(img)
endfunction

function new_points = change_point(points, index)
  new_points = points;
  pkg load communications;  
  new_points(index,:) = randint(1,2, [-1 1]) + points(index,:)
endfunction
function y = f(points, x)
  y = 0;
  for i=1:rows(points)
    for j=1:rows(points)
      y = y + points(i,1)*x^(rows(points)-1);
    end
  end
  y = y
endfunction
function y = sistema_linear(points)
  A = zeros(rows(points),rows(points));
  B = zeros(rows(points));
  for i=1:rows(points)
    for j=1:rows(points)
      A(i,j) = points(i,1)^(rows(points)-1);
    end
    B(i) = points(i,2);
  end
  result = A\B;
endfunction

function hist = transform(points, image)
  transform_function = floor(arrayfun(@(x) f(sistema_linear(points),x), 1:257));
  hist = uint8(transform_function(imagem+1));
  
endfunction


function end_point = simulate(start_point, chanel1,chanel2)
  
  n_cycles = 50;
  m_trials_per_cycle = 50;
  n_accepted_solution = 0.0;
  p_accept_worse_start = 0.7;  
  p_accept_worse_end = 0.001;
  change_index = 2;% altera apenas o ponto do meio
  
  t_initial = -1.0/math.log(p_accept_worse_start);  
  t_final = -1.0/math.log(p_accept_worse_end);

  fraction_reduction_temperature = (t_final/t_initial)**(1.0/(n_cycles-1.0));
  
  current_point = start_point;
  best_point = start_point;
  fraction_best = D(h(transform(best_point, chanel1)), h(chanel2));
  n_accepted_solution = n_accepted_solution +1;
  
  t = t_initial;
  DeltaE_avg = 0.0;
  
  for i=1:n_cycles
    for j=1:m_trials_per_cycle
      current_point = change_point(best_point, change_index);
      
      fraction_current = D(h(transform(current_point, chanel1)), h(chanel2));
      
      DeltaE = abs(fraction_current - fraction_best);
      accept = 1;
      if(fraction_current > fraction_best)
        if(i==1 && j==1)
          DeltaE_avg = DeltaE;
        end
        probability = exp(-DeltaE/(DeltaE_avg * t))
        if( rand() >= probability)
          accept= 0;
        end
      end
      if(accept == 1)
        best_point = current_point;
        fraction_best = D(h(transform(best_point, chanel1)), h(chanel2));
        n_accepted_solution = n_accepted_solution +1;
        DeltaE_avg = (DeltaE_avg * (n_accepted_solution-1.0) +  DeltaE) / n_accepted_solution;
      end   
    end
    t = fraction_reduction_temperature * t
  end
  disp(sprintf("Aceito %d pontos \n", n_accepted_solution))
  end_point = best_point
endfunction
function im = app(img,points_channels)
  im = img
  for i= 1:3
    im(:,:,i) = transform(points_channels(i),img(:,:,i));
  end
endfunction

