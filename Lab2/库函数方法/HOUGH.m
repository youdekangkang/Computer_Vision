clear all;
clc;
I  = imread('ֱ�߼��.jpg');
I=rgb2gray(I);

BW = edge(I,'log');%Canny������ȡͼ��߽�
[H,T,R] = hough(BW);%�����ֵͼ��ı�׼����任

imshow(H,[],'XData',T,'YData',R, 'Initialmagnification','fit')
%HΪ����任����T,RΪ�������任�ĽǶȺͰ뾶ֵ

xlabel('\theta'), ylabel('\rho');%����x���y��

axis on,axis normal, hold on;
%�����е��������ǩ���̶ȡ�����
%����ǰ���������ָ�Ϊȫ�ߴ磬������λ�̶ȵ���������ȡ��

P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
%��H����������5����ֵ��

%��ͼ
x = T(P(:,2));
y = R(P(:,1));
plot(x,y,'s','color','white');

lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);%��ֱ��
figure,imshow(I),hold on;%��ʾ�Ҷ�ͼ

%��ֱ�ߵ���������ǣ�һ��Ϊ��ɫ����һ��Ϊ��ɫ
max_len = 0;
for k = 1;length(lines)
          xy = [lines(k).point1;lines(k).point2];
          plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');          
          plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
         plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
         
           %�����ֱ��
         len = norm(lines(k).point1- lines(k).point2);
         if ( len > max_len)
                   max_len = len;
                   xy_long = xy;
         end
end

%������ֱ�� 
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');
          