function temperature = updateTemperature(t0, n)
  # constante para resfriamento geometrico
  #geo_cool = 0.9995;
  geo_cool = 0.9095;
  # n eh o numero da iteracao
  temperature = t0 * (geo_cool)^n;
endfunction
