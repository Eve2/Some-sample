
%1 Load image
A = imread('Lee.jpg');

%2 Show image & RGB components
figure, imshow(A)
R = A(:,:,1);
G = A(:,:,2);
B = A(:,:,3);
figure, imshow(R),title('Red component')
figure, imshow(G),title('Green component')
figure, imshow(B),title('Blue component')

%3 Show YCbCr components
R = double(R);
G = double(G);
B = double(B);

Y = 0.299*R + 0.587*G + 0.114*B;
Cb = -0.168736*R - 0.331264*G + 0.5*B + 128;
Cr = 0.5*R - 0.418688*G - 0.081312*B + 128;

Ycomp = uint8(Y);
Cbcomp = uint8(Cb);
Crcomp = uint8(Cr);

figure, imshow(Ycomp),title('Y component')
figure, imshow(Cbcomp),title('Cb component')
figure, imshow(Crcomp),title('Cr component')


%Compression 1

Y1 =(floor(Y/4))*4;
Cb1 =(floor(Cb/4))*4;
Cr1 =floor(Cr/4)*4;

Y1comp = uint8(Y1);
Cb1comp = uint8(Cb1);
Cr1comp = uint8(Cr1);

figure, imshow(Y1comp),title('Y1 component')
figure, imshow(Cb1comp),title('Cb1 component')
figure, imshow(Cr1comp),title('Cr1 component')

R1 = Y1 + 0*(Cb1-128) + 1.4020*(Cr1-128);
G1 = Y1 - 0.3441*(Cb1-128) - 0.7141*(Cr1-128);
B1 = 0.9998*Y1 + 1.7720*(Cb1-128) + (Cr1-128);

A1(:,:,1) = R1;
A1(:,:,2) = G1;
A1(:,:,3) = B1;
A1 = uint8(A1);
figure, imshow(A1)


%Compression 2

Y2 =floor(Y/16)*16;
Cb2 =floor(Cb/16)*16;
Cr2 =floor(Cr/16)*16;

Y2comp = uint8(Y2);
Cb2comp = uint8(Cb2);
Cr2comp = uint8(Cr2);

figure, imshow(Y2comp),title('Y2 component')
figure, imshow(Cb2comp),title('Cb2 component')
figure, imshow(Cr2comp),title('Cr2 component')

R2 = Y2 + 0*(Cb2-128) + 1.4020*(Cr2-128);
G2 = Y2 - 0.3441*(Cb2-128) - 0.7141*(Cr2-128);
B2 = 0.9998*Y2 + 1.7720*(Cb2-128) + (Cr2-128);

A2(:,:,1) = R2;
A2(:,:,2) = G2;
A2(:,:,3) = B2;
A2 = uint8(A2);
figure, imshow(A2)


%Compression 3

Y3 =floor(Y/4)*4;
Cb3 =floor(Cb/8)*8;
Cr3 =floor(Cr/8)*8;

Y3comp = uint8(Y3);
Cb3comp = uint8(Cb3);
Cr3comp = uint8(Cr3);

figure, imshow(Y3comp),title('Y3 component')
figure, imshow(Cb3comp),title('Cb3 component')
figure, imshow(Cr3comp),title('Cr3 component')

R3 = Y3 + 0*(Cb3-128) + 1.4020*(Cr3-128);
G3 = Y3 - 0.3441*(Cb3-128) - 0.7141*(Cr3-128);
B3 = 0.9998*Y3 + 1.7720*(Cb3-128) + (Cr3-128);

A3(:,:,1) = R3;
A3(:,:,2) = G3;
A3(:,:,3) = B3;
A3 = uint8(A3);
figure, imshow(A3)


PSNR1 = psnr(A,A1)

PSNR2 = psnr(A,A2)

PSNR3 = psnr(A,A3)










