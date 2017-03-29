%% Problem 1
IMG=imread('natalie.jpg');
%IMG=imread('angelina.jpg');
%figure,imshow(IMG),title('Original');
% a. color img to gray
I=rgb2gray(IMG);
%subplot(1,2,1)
figure,imshow(I),title('Original');
% b. dct
IDCT = I;
IDCT=dct2(IDCT);
figure,imshow(log(abs(IDCT)),[]), colormap(jet(64)), colorbar
% c 1/2
[n,m]=size(IDCT);
IDCT2 = IDCT;
IDCT4 = IDCT;
IDCT8 = IDCT;
IDCT16 = IDCT;

L = n/2;
L = round(L);
for i=L:n
   for j=1:m
       IDCT2(i,j)=0;
   end
end
K2=idct2(IDCT2);
figure(3)
subplot(2,2,1)
imshow(K2,[0,255]);
% e 1/4
L=n/4;
L = round(L);
for i=L:n
   for j=1:m
       IDCT4(i,j)=0;
   end
end
K4=idct2(IDCT4);
subplot(2,2,2)
imshow(K4,[0,255]);
% f 1/8
L=n/8;
L = round(L);
for i=L:n
   for j=1:m
       IDCT8(i,j)=0;
   end
end
K8=idct2(IDCT8);
subplot(2,2,3)

imshow(K8,[0,255]);
% g 1/16

[n,m]=size(IDCT);
L=n/16;
L = round(L);
for i=L:n
   for j=1:m
       IDCT16(i,j)=0;
   end
end
K16=idct2(IDCT16);
subplot(2,2,4)
imshow(K16,[0,255]);

%% h
%IMG=imread('natalie.jpg');
IMG=imread('angelina.jpg');
%figure,imshow(IMG),title('Original');
% a. color img to gray
I=rgb2gray(IMG);
%subplot(1,2,1)
figure,imshow(I),title('Original');
% b. dct
IDCT = I;
IDCT=dct2(IDCT);
figure,imshow(log(abs(IDCT)),[]), colormap(jet(64)), colorbar
% c 1/2
[n,m]=size(IDCT);
IDCT2 = IDCT;
IDCT4 = IDCT;
IDCT8 = IDCT;
IDCT16 = IDCT;

L = n/2;
L = round(L);
for i=L:n
   for j=1:m
       IDCT2(i,j)=0;
   end
end
K2=idct2(IDCT2);
figure(3)
subplot(2,2,1)
imshow(K2,[0,255]);
% e 1/4
L=n/4;
L = round(L);
for i=L:n
   for j=1:m
       IDCT4(i,j)=0;
   end
end
K4=idct2(IDCT4);
subplot(2,2,2)
imshow(K4,[0,255]);
% f 1/8
L=n/8;
L = round(L);
for i=L:n
   for j=1:m
       IDCT8(i,j)=0;
   end
end
K8=idct2(IDCT8);
subplot(2,2,3)

imshow(K8,[0,255]);
% g 1/16

[n,m]=size(IDCT);
L=n/16;
L = round(L);
for i=L:n
   for j=1:m
       IDCT16(i,j)=0;
   end
end
K16=idct2(IDCT16);
subplot(2,2,4)
imshow(K16,[0,255]);


%% Problem 2
%a
A=imread('natalie.jpg');
B=imread('angelina.jpg');
A=rgb2gray(A);
B=rgb2gray(B);

[a,b] = size(A);
[c,d] = size(B);
e = min(a,c);
f = min(b,d);

C = A(round((a-e)/2)+1:round((a-(a-e)/2)),round((b-f)/2)+1:round((b-(b-f)/2)));
D = B(round((c-e)/2)+1:round((c-(c-e)/2)),round(((d-f)/2))+1:round(d-(d-f)/2));
figure
subplot(2,1,1)
imshow(C),title('Original Face One')
subplot(2,1,2)
imshow(D),title('Original Face Two')
% b Laplacian pyramid
%h = fspecial('laplacian', 0.2);
C1 = imfilter(C,fspecial('laplacian', 0.2));
%figure
%imshow(C1)
%h = fspecial('laplacian', 0.2);
D1 = imfilter(D,fspecial('laplacian', 0.2));
% figure
% imshow(D1)
% c binary mask Gaussian
mask1 = zeros(e,f);
mask1(:,1:f/2) = 1;

mask2 = zeros(e,f);
mask2(:,(f/2+1):f) = 1;

mask1 = imfilter(mask1,fspecial('gaussian',80,40),'replicate');
mask2 = imfilter(mask2,fspecial('gaussian',80,40),'replicate');
% figure
% imshow(mask1)
% figure
% imshow(mask2)
% d 
for i = 1:e
    for j = 1:f
        Cm(i,j)= C(i,j).*mask1(i,j);
    end
end

for i = 1:e
    for j = 1:f
        Dm(i,j)= D(i,j).*mask2(i,j);
    end
end

figure
subplot(2,1,1)
imshow(Cm),title('Face One with Mask')
subplot(212)
imshow(Dm),title('Face Two with Mask')
% e add weighted pyramids & reconstruct
%
New = Cm + Dm;
%New1 = gray2rgb(New);
%rgbNew = cat(3,New,New,New);
%New1=New(:,:,[1 1 1]);
figure
imshow(New),title('Blended Image')













