#include<iostream>
#include<opencv2/opencv.hpp>
#include <opencv2/core/core.hpp>  
#include<opencv2/highgui/highgui.hpp>  
#include<opencv2/imgproc/imgproc.hpp>
#include<cmath>

#define PI 3.1415;

using namespace std;
using namespace cv;


#include <stdio.h>

int main() {

    //读取图片
    Mat img = imread("image2.jpg");
    //执行一次高斯过滤与灰度变换
    Mat copy;
    cvtColor(img, copy, COLOR_RGB2GRAY); //将图像转换为灰度图像
    GaussianBlur(copy, copy, Size(3, 3), 1);//实现高斯滤波清除图像中的噪点
    Mat cannyimg;
    Canny(copy, cannyimg, 20, 255, 3, false);
    cv::imshow("canny image", cannyimg);
    //提取圆
    waitKey(0);
    int maxsize, minsize;
    /*cout << "please input your maxsize and minsize" << endl;
    cin >> maxsize >> minsize;*/
    minsize = 10;
    maxsize = 100;
    const int n = img.cols;
    const int m = img.rows;
    const int z = maxsize - minsize;
    vector<vector<vector<int>>>gassionspace(m, vector<vector<int>>(n, vector<int>(z, 0)));  //设立一个m*n*z的数组 初始值为0
    std::cout << "1" << endl;

    for (int r = 0; r < z; r++)
    {  
        for (int i = 0; i < m; i++)
        {
            for (int j = 0; j < n; j++)
            {
                if (cannyimg.at<uchar>(i, j) != 0)//存在一个点i，j，在这个点存在像素值
                {
                 //在此计算每一个圆上的点时考虑到我们设定的半径通常较大，所以我们采用将x轴从左向右一个一个的移动的方式来计算所有的在圆上的点
                    int* a = new int[r+minsize];    //设定一个一维数组来存储每一个每一个点的横坐标
                    for (int p = 0; p < r + minsize; p++)
                        a[p] = 0;
                    for (int q = 0; q < r + minsize; q++)
                    {
                        int e = (int)sqrt(pow(r+minsize, 2) - pow(q, 2));
                        a[q] = e;
                    }
                    if((j+r+minsize)>=0&&(j+r+minsize)<n)
                        gassionspace[i][j + r + minsize][r]++;//实现园四个角上的点的值的标记避免重复标记
                    if((j-r-minsize)>=0&&(j-r-minsize)<n)
                        gassionspace[i][j - r - minsize][r]++;
                    if((i+r+minsize)>=0&&(i+r+minsize)<m)
                        gassionspace[i + r + minsize][j][r]++;
                    if((i-r-minsize)>=0&&(i-r-minsize)<m)
                        gassionspace[i - r - minsize][j][r]++;
                    for (int q = 1; q < r + minsize; q++)
                    {//判定我们通过此方式计算出的每个点是否在我们的给定范围之内
                        if ((i + q) < m && (i + q) >= 0 && (j + a[q]) < n && (j + a[q]) >= 0)  //将一个象限内的属猪数据映射到四个象限之中
                            gassionspace[i + q][j + a[q]][r]++;
                        if ((i - q) < m && (i - q) >= 0 && (j + a[q]) < n && (j + a[q]) >= 0)
                            gassionspace[i - q][j + a[q]][r]++;
                        if ((i + q) < m && (i + q) >= 0 && (j - a[q]) < n && (j - a[q]) >= 0)
                            gassionspace[i + q][j - a[q]][r]++;
                        if ((i - q) < m && (i - q) >= 0 && (j - a[q]) < n && (j - a[q]) >= 0)
                            gassionspace[i - q][j - a[q]][r]++;
                    }
                }
            }
        }
    }
    std::cout << "1" << endl;
    Mat output = img;
    int threshold;
    threshold = 100;
    for (int q = 0; q < z; q++)
    {
        for (int i = 0; i < m; i++)
        {
            for (int j = 0; j < n; j++)
            {
                if (gassionspace[i][j][q] > threshold)//当经过某一点的园的个数超过阙值时我们认定该点是一个圆心
                {
                    circle(output, Point(i, j), q + minsize, Scalar(0, 0, 255));
                }
            } 
        }
    }
    cv::imshow("output", output);
    

    cv::waitKey();
}
