# Descricao dos parametros:
# s0 = estado inicial; lista com pontos, ex: [(0,0),(x,y),(255,255)]
# t0 = temperatura inicial, valor aleatorio, ex: t0 = 256
# epsilon = referência para encerrar o algoritmo, ex: epsilon = 10^-5
# h1 = canal rgb img1
# h2 = canal rgb img2
function L = simulated_annealing(s0, t0, epsilon, im1, im2)
  i = 0;
  s = s0;
  t = t0;
  
  while(t>epsilon)
    disp(t);
    t = updateTemperature(t0, i);
    sn = randomNeighbor(s);
    ls = xau(s,im1);
    lsn = xau(sn,im1);
    es = D(ls, im2);
    esn = D(lsn, im2);
    %difference = esn - es;
    if(esn < es)
      s = sn;
      s
    endif
    i = i+1;
  endwhile
  L = s;
endfunction
