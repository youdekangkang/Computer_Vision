function [Points] = myHoughPeak(Hist,num)
Points = zeros(num,2);
for index = 1:num
    [x0, y0] = find(Hist == max(max(Hist)));
    Points(index,1) = x0;Points(index,2) = y0;
    Hist(x0,y0) = 0;
end
end

