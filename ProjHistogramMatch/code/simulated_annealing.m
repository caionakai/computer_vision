# Descricao dos parametros:
# s0 = estado inicial; lista com pontos, ex: [(0,0),(x,y),(255,255)]
# t0 = temperatura inicial, valor aleatorio, ex: t0 = 256
# epsilon = referência para encerrar o algoritmo, ex: epsilon = 10^-5
# cha1 = canal rgb img1
# cha2 = canal rgb img2
function L = simulated_annealing(s0, t0, epsilon, cha1, cha2)
  i = 0;
  s = s0;
  t = t0;
  
  while(t>epsilon)
    disp(t);
    t = updateTemperature(t0, i);
    sn = randomNeighbor(s);
    ls = xau(s,cha1);
    lsn = xau(sn,cha1);
    es = D(ls, cha2);
    esn = D(lsn, cha2);
    dif = esn - es;
    if(dif < 0)
      p = 1;
    else
      p = exp(-dif/t);
    endif
    q = rand();

    if(q < p)
      s = sn;
      s
    endif

    i = i+1;
  endwhile
  L = s;
endfunction
