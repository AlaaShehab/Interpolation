function[func executionTime] = LaGrange(arrOfX, arrOfY)
    tic;
    syms func(x);
	syms temp1(x) temp2(x); 
	temp2(x) = 1;
	func(x) = 0;
	i = 1;
    executionTime = 0.0;
	while (i <= size(arrOfX,1))
		j = 1;
		while (j <= size(arrOfX,1))
			if (i ~= j)
			%temp1(x) = (x-arrOfPts(j,1)) / (arrOfPts(i,1) - arrOfPts(j,1));
			temp1(x) = (x-arrOfX(j)) / (arrOfX(i) - arrOfX(j));
			temp2(x) = temp2(x) * temp1(x)
			end
			j = j + 1;
		end
		%func(x) = func(x) + (temp2(x) * arrOfPts(i,2))
		func(x) = func(x) + (temp2(x) * arrOfY(i))
		i = i + 1;
		temp2(x) = 1;
	end
	func(x) = simplify(func(x))

    executionTime = toc;