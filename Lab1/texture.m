%%
I = imread ( 'beach.jpg' );
imshow(I)
%%
% E = entropyfilt ( I );
[m,n]=size(I);
In=zeros(size(I));%In为影像局部熵
k=25;%k为搜索半径
for i=k+1:m-k
    for j=k+1:n-k
        his=zeros(1,256);
        for p=i-k:i+k
            for q=j-k:j+k
                his(I(p,q)+1)=his(I(p,q)+1)+1;%计算2k+1块的灰度直方图
            end
        end
        his=his/sum(his);
        for g=1:256
            if his(g)~=0
%                 In(i,j)=In(i,j)-his(g)*log(his(g));
                In(i,j)=In(i,j)+his(g)*his(g);
            end
        end
    end
end

%%
E = entropyfilt ( I );

%%

E = In;
Eim = mat2gray ( E );
BW1 = imbinarize ( Eim , graythresh ( Eim ));

BWao = bwareaopen ( BW1 ,2000);
nhood = true (9);
closeBWao = imclose ( BWao , nhood );
Mask1 = imfill( closeBWao , 'holes' );

boundary = bwperim ( Mask1 );
segmentResults = I ;
segmentResults( boundary ) = 255;

I2 = I ;

I2 ( Mask1 ) = 0;

E2 = entropyfilt ( I2 );

E2im = mat2gray ( E2 );
BW2 = imbinarize ( E2im , graythresh ( E2im ));
Mask2 = bwareaopen ( BW2 ,2000);
boundary = bwperim ( Mask2 );
segmentResults = I ;
segmentResults ( boundary ) = 255;

texture1 = I ;
texture1 (~ Mask2 ) = 0;
texture2 = I ;
texture2 ( Mask2 ) = 0;

imshow(texture1)