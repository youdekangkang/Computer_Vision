i = imread('happydog.jpg');%读取输入图像
h=im2bw(i);%转换为二值图
I=double(h);%数据类型改为double
BW1 = edge(I,'sobel');%用sobelu算子进行边缘检测
%figure,imshow(BW1)

BW2 = edge(I,'prewitt');%用prewitt算子进行边缘检测
%figure,imshow(BW2)

BW3 = edge(I,'roberts');%用Roberts算子进行边缘检测
%figure,imshow(I,'BW3')

BW4 = edge(I,'log');%用log算子进行边缘检测
%figure,imshow(BW4)
%画图
subplot(2,3,1),imshow(i),title('原图')
subplot(2,3,2),imshow(BW1),title('sobel')
subplot(2,3,3),imshow(BW2),title('prewitt')
subplot(2,3,5),imshow(BW3),title('roberts')
subplot(2,3,6),imshow(BW4),title('log')
subplot(2,3,4),imshow(h),title('灰度图')