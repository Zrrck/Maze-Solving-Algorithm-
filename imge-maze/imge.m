clc; clear all; close all;


I = rgb2gray(imread('capture.png'));

tresh= graythresh(I);
I2 = imbinarize(I,0.47);
    
L = bwlabeln(I2,8);
I3=L==0;


s=regionprops(I3,'all');

[r,c]=find(L==1);
rc=[r,c];
[h,w]=size(I3);
    for i=1:1:h
        for j=1:1:w
         
           I4(i,j) =0.7*I3(i,j)+0.3*I3(i,j);
        end
    end
       for i=1:1:h
        for j=1:1:w
            if(j<45 || j>250 || i<19 || i>179 )
         
           I3(i,j)=0;
         
     
            end
        end
       end
    figure,imshow(I);title('Orginal')
figure,imshow(I2);title('Binary')
    figure,imshow(I3);title('')
BW = I3;
imshow(BW);
figure;imshow(s(20).Image);
figure;imshow(s(21).Image);
figure;
% 
continue_it = 1;
while continue_it
BW_old=BW;
BW_del=zeros(size(BW));
for i=2:size(BW,1)-1
    for j = 2:size(BW,2)-1
        P = [BW(i,j) BW(i-1,j) BW(i-1,j+1) BW(i,j+1) BW(i+1,j+1) BW(i+1,j) BW(i+1,j-1) BW(i,j-1) BW(i-1,j-1) BW(i-1,j)];
        if P(2)*P(4)*P(6)==0 && P(4)*P(6)*P(8)==0 && sum(P(2:end-1))<=6 && sum(P(2:end-1)) >=2
            A = 0;
            for k = 2:size(P(:),1)-1
                if P(k) == 0 && P(k+1)==1
                    A = A+1;
                end%if
            end%for
            if (A==1)
                BW_del(i,j)=1;
            end%if
        end%if
    end%for
end%for
BW(find(BW_del==1))=0;
for i=2:size(BW,1)-1
    for j = 2:size(BW,2)-1
        P = [BW(i,j) BW(i-1,j) BW(i-1,j+1) BW(i,j+1) BW(i+1,j+1) BW(i+1,j) BW(i+1,j-1) BW(i,j-1) BW(i-1,j-1) BW(i-1,j)];
        if P(2)*P(4)*P(8)==0 && P(2)*P(6)*P(8)==0 && sum(P(2:end-1))<=6 && sum(P(2:end-1)) >=2
            A = 0;
            for k = 2:size(P(:),1)-1
                if P(k) == 0 && P(k+1)==1
                    A = A+1;
                end%if
            end%for
            if (A==1)
                BW_del(i,j)=1;
            end%if
        end%if
    end%for
end%for
BW(find(BW_del==1))=0;
if prod(BW_old(:)==BW(:))
   continue_it=0;
end%if
end%while
imshow(BW);
