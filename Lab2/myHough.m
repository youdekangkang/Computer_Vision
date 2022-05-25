function [ Hough, theta_range, rho_range ] = myHough(I)
[rows, cols] = size(I); 
theta_maximum = 90;
rho_maximum = floor(sqrt(rows^2 + cols^2)) - 1;
theta_range = -theta_maximum:theta_maximum - 1;
rho_range = -rho_maximum:rho_maximum;
 
Hough = zeros(length(rho_range), length(theta_range));
for row = 1:rows
    for col = 1:cols
        %only find: pixel > 0
        if I(row, col) > 0 
            x = col - 1;
            y = row - 1;
            for theta = theta_range
                %approximate number here
                rho = round((x * cosd(theta)) + (y * sind(theta)));  
                rho_index = rho + rho_maximum + 1;
                theta_index = theta + theta_maximum + 1;
                Hough(rho_index, theta_index) = Hough(rho_index, theta_index) + 1;
            end
        end
    end
end