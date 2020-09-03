%攻击实验 测试鲁棒性
clear all;
wimage=imread('wimage.bmp');
ImageA=wimage;
ssss=1;
while ssss==1
disp('======================='); 
disp('对嵌入水印的图像的攻击实验，请输入选择项：'); 
disp('1--JPEG 压缩'); 
disp('2--旋转10度'); 
disp('3--高斯低通滤波'); 
disp('4--添加白噪声'); 
disp('5--图像剪切');  
disp('6--不攻击,退出'); 
disp('======================='); 
choice=input('请输入选择（1-6）:'); 
disp('=======================');

switch choice 
       case 1
           disp('1--JPEG 压缩'); 
           factor=input('请输入quality(50:10:100):'); 
           imwrite(wimage,'a-jpeg.jpg','jpg','quality',factor);
           ImageB=imread('a-jpeg.jpg');
       case 2
           disp('2--旋转'); 
           angle=input('请输入angle(0.1,0.2,0.23,0.27):'); 
           k=imrotate(wimage,angle,'crop');
           imwrite(k,'a-angle.bmp','bmp');
           ImageB=imread('a-angle.bmp');
       case 3
           disp('3--高斯低通滤波');
            hh=fspecial('gaussian',3,0.5);
            wimageR=wimage(:,:,1);
            wimageG=wimage(:,:,2);
            wimageB=wimage(:,:,3);
            kkkk1=filter2(hh,wimageR);
            kkkk2=filter2(hh,wimageG);
            kkkk3=filter2(hh,wimageB);
            [m1,m2]=size(wimageR);
            %生成的图像三色重组    
            for p=1:m1;
                for q=1:m2;
                     kkkk(p,q,1)=uint8(kkkk1(p,q)); 
                     kkkk(p,q,2)=uint8(kkkk2(p,q));
                     kkkk(p,q,3)=uint8(kkkk3(p,q));
                end
            end
            imwrite(kkkk,'a-filter.bmp','bmp'); 
            ImageB=imread('a-filter.bmp');
       case 4 
           disp('4--添加白噪声'); 
            noise0=uint8(20*randn(size(wimage)));
            k=wimage+noise0; 
            imwrite(k,'a-noise.bmp','bmp');
            ImageB=imread('a-noise.bmp');
       case 5 
           disp('5--图像剪切');  
            k=wimage;
            for p=1:125
                for q=1:125
                    k(p,q,1)=255;
                    k(p,q,2)=255;
                    k(p,q,3)=255;
                end
            end
            imwrite(k,'a-cut.bmp','bmp');
            ImageB=imread('a-cut.bmp');
       case 6
           disp('6--不攻击，退出');
           disp('======================='); 
           break; 
       otherwise 
            disp('你输入的是无效数字，图像未受攻击');
            ImageB=imread('wimage.bmp');
end
         dpsnr=psnr(ImageA,ImageB)
      
end
         