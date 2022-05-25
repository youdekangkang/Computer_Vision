function [H,T,R] = my_hough(BW)

[rows, cols] = size(BW);
 
theta_maximum = 90;
rho_maximum = floor(sqrt(rows^2 + cols^2)) - 1;
T = -theta_maximum:theta_maximum - 1;
R = -rho_maximum:rho_maximum;
 
H = zeros(length(R), length(T));
for row = 1:rows
    for col = 1:cols
        if BW(row, col) > 0 %only find: pixel > 0
            x = col - 1;
            y = row - 1;
            for theta = T
                rho = round((x * cosd(theta)) + (y * sind(theta)));  %approximate
                rho_index = rho + rho_maximum + 1;
                theta_index = theta + theta_maximum + 1;
                H(rho_index, theta_index) = H(rho_index, theta_index) + 1;
            end
        end
    end
end