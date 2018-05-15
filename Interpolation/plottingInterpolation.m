function plottingInterpolation(graph, f, Xs, Ys)
minNum = min(Xs);
maxNum = max(Xs);

margin = abs(maxNum-minNum);
margin = margin/5;

startPoint = minNum - margin;
endPoint = maxNum + margin;

axes(graph.axes1);
grid on;
y = 0;
hold on;
fplot(y,[startPoint endPoint],'color','black')

hold on;
fplot(f,[startPoint endPoint],'color','red')

[~,row] = size(Xs);

counter = 1;
while counter <= row
    hold on;
    plot([Xs(counter) Xs(counter)], [Ys(counter) Ys(counter)], 'x') 
    counter = counter + 1;
end

