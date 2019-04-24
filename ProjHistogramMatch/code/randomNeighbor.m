# recebe uma matriz, cada linha representa um ponto
# retorna a matriz com as novas posicoes
function new_positions = randomNeighbor(position)
# pacote para usar o randint
  pkg load communications;  
  allPossibilities = [[1,0];[-1,0];[0,1];[0,-1];[0,0]];
  
  new_positions = [[[1,1]];position;[[256,256]]];
    
  for i = 2:rows(new_positions)-1
    # gera um numero randomico de 0 a 5
    numRand = randint(1,1, [1 5]);
    temp = new_positions(i,:) + allPossibilities(numRand,:);
    resposta = temp < new_positions(i-1,1);
    resposta2 = temp > new_positions(i+1,1);
    if(resposta(1) || resposta(2))
      temp = new_positions(i-1,:);
    endif
    if(resposta2(1) || resposta2(2))
      temp = new_positions(i+1,:);
    endif    
    new_positions(i,:) = temp;
  endfor
  # retorna as novas posicoes excluindo o primeiro e ultimo ponto
  new_positions = new_positions(2:rows(new_positions)-1,:);
endfunction
