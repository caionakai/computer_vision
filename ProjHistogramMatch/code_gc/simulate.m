
function end_point = simulate(start_point, chanel1,chanel2)
  
  n_cycles = 50;
  m_trials_per_cycle = 50;
  n_accepted_solution = 0.0;
  p_accept_worse_start = 0.7;  
  p_accept_worse_end = 0.001;
  
  t_initial = -1.0/log(p_accept_worse_start);  
  t_final = -1.0/log(p_accept_worse_end);

  fraction_reduction_temperature = (t_final/t_initial)**(1.0/(n_cycles-1.0));
  
  current_point = start_point;
  best_point = start_point;
  fraction_best = D(h(transform(best_point, chanel1)), h(chanel2));
  n_accepted_solution = n_accepted_solution +1;
  
  t = t_initial;
  DeltaE_avg = 0.0;
  
  for i=1:n_cycles
    for j=1:m_trials_per_cycle
      current_point = change_point(best_point, 1);
  	  current_point = change_point(current_point, 2);
  	  current_point = change_point(current_point, 3);
      
      fraction_current = D(h(transform(current_point, chanel1)), h(chanel2));
      
      DeltaE = abs(fraction_current - fraction_best);
      accept = 1;
      if(fraction_current < fraction_best)
        if(i==1 && j==1)
          DeltaE_avg = DeltaE;
        end
        probability = exp(-DeltaE/(DeltaE_avg * t));
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
    t = fraction_reduction_temperature * t;
    disp(sprintf("Temperatura: %d",t));
  end
  disp(sprintf("Aceito %d pontos \n", n_accepted_solution));
  end_point = best_point;
endfunction
