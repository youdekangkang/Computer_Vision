I  = imread('street.jpg');
[y, x, dim] = size(I);
if dim>1
    I = rgb2gray(I);
end
rotI = I;
subplot 221
fig1 = imshow(I);
BW = edge(rotI,'canny');
title('Original');
subplot 222
imshow(BW);
% [H,theta,rho] = myHough(BW);
[H,theta,rho] = hough(BW);
title('Canny edge detection');
subplot 223
imshow(imadjust(mat2gray(H)),[],'XData',theta,'YData',rho,...
        'InitialMagnification','fit');
xlabel('\theta (degrees)'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(hot)

P = houghpeaks(H,7,'threshold',ceil(0.7*max(H(:))));

% P = myHoughPeak(H,7);

x = theta(P(:,2));
y = rho(P(:,1));
plot(x,y,'s','color','black');

lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',7);

title('Hough parameters space');
subplot 224, imshow(rotI), hold on

max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');
title('Line detection');