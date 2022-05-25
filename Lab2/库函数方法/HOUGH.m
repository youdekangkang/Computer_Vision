clear all;
clc;
I  = imread('直线检测.jpg');
I=rgb2gray(I);

BW = edge(I,'log');%Canny方法提取图像边界
[H,T,R] = hough(BW);%计算二值图像的标准霍夫变换

imshow(H,[],'XData',T,'YData',R, 'Initialmagnification','fit')
%H为霍夫变换矩阵，T,R为计算霍夫变换的角度和半径值

xlabel('\theta'), ylabel('\rho');%定义x轴和y轴

axis on,axis normal, hold on;
%打开所有的坐标轴标签、刻度、背景
%将当前的坐标轴框恢复为全尺寸，并将单位刻度的所有限制取消

P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
%在H矩阵中设置5个峰值点

%画图
x = T(P(:,2));
y = R(P(:,1));
plot(x,y,'s','color','white');

lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);%找直线
figure,imshow(I),hold on;%显示灰度图

%对直线的两端做标记，一端为红色，另一端为黄色
max_len = 0;
for k = 1;length(lines)
          xy = [lines(k).point1;lines(k).point2];
          plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');          
          plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
         plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
         
           %找最长的直线
         len = norm(lines(k).point1- lines(k).point2);
         if ( len > max_len)
                   max_len = len;
                   xy_long = xy;
         end
end

%标记最长的直线 
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');
          