function x = asd(img)
   k = 1;
 for i = 0:3
   for j = 0:3
     x(:,:,k) = img(i*4+1:i*4+4, j*4+1:j*4+4);
     k++;
   endfor
 endfor
  
endfunction
