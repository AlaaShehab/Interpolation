function [order, xs, ys, qs, method] = readFile2(path)
 filename = fullfile(char(path));
 t = readtable(filename);
 
 t0 = t{height(t) ,width(t)-1};
 t1 = t{height(t) -1 ,width(t)-1};
 t2 = t{height(t) -2 ,width(t)-1};
 t3 = t{height(t) -3 ,width(t)-1};
 t4 = t{height(t) -4,width(t)-1};
 
 c0 = strsplit(char(t0));
 c1 = strsplit(char(t1));
 c2 = strsplit(char(t2));
 c3 = strsplit(char(t3));
 c4 = strsplit(char(t4));
 
 c2 = removeBrackets(c2);
 c1 = removeBrackets(c1);
 c0 = removeBrackets(c0);
 
 c0(strcmp('',c0)) = [];
 c1(strcmp('',c1)) = [];
 c2(strcmp('',c2)) = [];
 c3(strcmp('',c3)) = [];
 c4(strcmp('',c4)) = [];
 
 c2 = strsplit(c2{1},',');
 c1 = strsplit(c1{1},',');
 c0 = strsplit(c0{1},',');
 
method = c4{1};
order = c3{1};
xs=zeros(size(c2,1),size(c2,2));
xs=str2double(c2);
ys=zeros(size(c1,1),size(c1,2));
ys=str2double(c1);
qs=zeros(size(c0,1),size(c0,2));
qs=str2double(c0);end
function value = removeBrackets(c)
for i = 1 :1: length(c)  
    c{i} = erase(c{i},"[");
    c{i} = erase(c{i},"]");
end
value = c;
end