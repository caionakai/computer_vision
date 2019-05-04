# recebe uma matriz, cada linha representa um ponto
# retorna a matriz com as novas posicoes
function novos_pontos = vizinho(position_atual)
# pacote para usar o randint
  pkg load communications;
# todos os movimentos possiveis para o ponto  
  allPossibilities = [[1,0];[-1,0];[0,1];[0,-1]];
  #allPossibilities = [[0,1];[0,-1]];
  new_positions = [[[1,1]];position_atual;[[256,256]]];
  flag = 0;
  
  while(flag == 0)
    numRand = randint(1,1, [1 4]);
    temp = position_atual(2,:) + allPossibilities(numRand, :);
    ans = temp > position_atual(1, :);
    ans2 = temp < position_atual(3, :);
    if(ans(1) && ans2(1))
      #disp("mudei");
      novos_pontos = [[[1,1]];temp;[[256,256]]];
      flag = 1;
    endif
  endwhile

endfunction
