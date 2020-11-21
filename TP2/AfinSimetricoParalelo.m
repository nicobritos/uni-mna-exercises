function U = AfinSimetricoParalelo(h, U, k, q)
  % This function calculates the next U using
  % Afin integrator symmetric with parallel computing.

  x = U;
  n = floor(q/2);
  gammas = GamasSimetrico(q);
  spmd(q) %here we split in threads
     for j = 1:n
      if labindex == j 
        for s = 1:labindex
          x = NoLineal(h/labindex, Lineal(h/labindex, x, k), k); %I-
        end
        x = gammas(labindex) .* x; 
      end
      
      if labindex == j + n  
         for s = 1:labindex-n 
             x= NoLineal(h/(labindex-n), Lineal(h/(labindex-n), x, k), k); %I+
         end
         x = gammas(labindex-n) .* x; 
      end
       
     end
  end %threads end

  for s = 2:n
      x{1} = x{1} +x{s};
  end

  U = x{1};
end