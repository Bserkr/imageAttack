%����ʵ�� ����³����
clear all;
wimage=imread('wimage.bmp');
ImageA=wimage;
ssss=1;
while ssss==1
disp('======================='); 
disp('��Ƕ��ˮӡ��ͼ��Ĺ���ʵ�飬������ѡ���'); 
disp('1--JPEG ѹ��'); 
disp('2--��ת10��'); 
disp('3--��˹��ͨ�˲�'); 
disp('4--��Ӱ�����'); 
disp('5--ͼ�����');  
disp('6--������,�˳�'); 
disp('======================='); 
choice=input('������ѡ��1-6��:'); 
disp('=======================');

switch choice 
       case 1
           disp('1--JPEG ѹ��'); 
           factor=input('������quality(50:10:100):'); 
           imwrite(wimage,'a-jpeg.jpg','jpg','quality',factor);
           ImageB=imread('a-jpeg.jpg');
       case 2
           disp('2--��ת'); 
           angle=input('������angle(0.1,0.2,0.23,0.27):'); 
           k=imrotate(wimage,angle,'crop');
           imwrite(k,'a-angle.bmp','bmp');
           ImageB=imread('a-angle.bmp');
       case 3
           disp('3--��˹��ͨ�˲�');
            hh=fspecial('gaussian',3,0.5);
            wimageR=wimage(:,:,1);
            wimageG=wimage(:,:,2);
            wimageB=wimage(:,:,3);
            kkkk1=filter2(hh,wimageR);
            kkkk2=filter2(hh,wimageG);
            kkkk3=filter2(hh,wimageB);
            [m1,m2]=size(wimageR);
            %���ɵ�ͼ����ɫ����    
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
           disp('4--��Ӱ�����'); 
            noise0=uint8(20*randn(size(wimage)));
            k=wimage+noise0; 
            imwrite(k,'a-noise.bmp','bmp');
            ImageB=imread('a-noise.bmp');
       case 5 
           disp('5--ͼ�����');  
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
           disp('6--���������˳�');
           disp('======================='); 
           break; 
       otherwise 
            disp('�����������Ч���֣�ͼ��δ�ܹ���');
            ImageB=imread('wimage.bmp');
end
         dpsnr=psnr(ImageA,ImageB)
      
end
         