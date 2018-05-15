
function [funcOutput executionTime] = DividedDifference (Xs,Ys)
tic;
executionTime = 0.0;
%replaced col by ~
  [~, col] = size(Xs);
  coefficients = zeros(1,col);
  newXs = zeros(1,col);
  tempArray = zeros(1,col);

  for i = [1:1:col]
    newXs(i) = i + 1;
    tempArray(i) = Ys(i);
  end
  
  coefficients(1) = Ys(1);
  loops = col - 1;
  
  
  while(loops >= 1)
   for i = [1:1:loops]
     tempArray(i) = (tempArray(i+1) - tempArray(i)) / (Xs(newXs(i)) - Xs(i));
     newXs(i) = newXs(i) + 1;
   end
   loops = loops - 1;
   coefficients(col - loops) = tempArray(1);
  end
  
  func = num2str(coefficients(1));
  loops = 2;
  while loops <= col
    start = true;
    for i =[1:1:loops]
      if start
        s1 = '+';
        s2 = num2str(coefficients(loops));
        func = strcat(func, s1,s2);
        start = false;
    else
        s3 = '*(x-';
        s4 = num2str(Xs(i-1));
        s5 = ')';
        func = strcat(func, s3,s4,s5);
      end
    end
    loops = loops + 1;
  end
   
  syms f(x)
  f(x) = func;
  funcOutput = simplify(f);  
  executionTime = toc;