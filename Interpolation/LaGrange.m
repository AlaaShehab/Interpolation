function[func executionTime] = LaGrange(arrOfX, arrOfY)
    tic;
    syms func(x);
	syms temp1(x) temp2(x); 
	temp2(x) = 1;
	func(x) = 0;
	i = 1;
    executionTime = 0.0;
	arrOfPts = [arrOfX;arrOfY]
	while (i <= size(arrOfPts,1)+1)
		j = 1;
		while (j <= size(arrOfPts,1)+1)
			if (i ~= j)
			temp1(x) = (x-arrOfPts(1,j)) / (arrOfPts(1,i) - arrOfPts(1,j));
			temp2(x) = temp2(x) * temp1(x);
			end
			j = j + 1;
		end
		func(x) = func(x) + (temp2(x) * arrOfPts(2,i));
		i = i + 1;
		temp2(x) = 1;
	end
	func(x) = simplify(func(x));

    executionTime = toc;
