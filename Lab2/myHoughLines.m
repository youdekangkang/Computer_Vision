function [Points] = myHoughLines(image,x,y,points)
thetas = x(P(:,2));
rhos = y(P(:,1));
for index = 1 : length(points)
    theta = thetas(index);
    rho = rhos(index);
    if (theta < (3.14/4) ) or (theta > (3 * 3.14 /4))
        pt1 = (int(rho))
    end
    
end
end

