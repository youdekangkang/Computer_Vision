i = imread('happydog.jpg');%��ȡ����ͼ��
h=im2bw(i);%ת��Ϊ��ֵͼ
I=double(h);%�������͸�Ϊdouble
BW1 = edge(I,'sobel');%��sobelu���ӽ��б�Ե���
%figure,imshow(BW1)

BW2 = edge(I,'prewitt');%��prewitt���ӽ��б�Ե���
%figure,imshow(BW2)

BW3 = edge(I,'roberts');%��Roberts���ӽ��б�Ե���
%figure,imshow(I,'BW3')

BW4 = edge(I,'log');%��log���ӽ��б�Ե���
%figure,imshow(BW4)
%��ͼ
subplot(2,3,1),imshow(i),title('ԭͼ')
subplot(2,3,2),imshow(BW1),title('sobel')
subplot(2,3,3),imshow(BW2),title('prewitt')
subplot(2,3,5),imshow(BW3),title('roberts')
subplot(2,3,6),imshow(BW4),title('log')
subplot(2,3,4),imshow(h),title('�Ҷ�ͼ')