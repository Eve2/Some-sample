clear
%% Load an image showing a few easily distinguishable objects
A = imread('abc.jpg');
figure(1), imshow(A),title('Original Image');

%convert RGB to Lum. Y(greyscale)
Agray = rgb2gray(A);
figure(2), subplot(1,2,1),imshow(Agray),title('Luminance Y');

%Lum. to thresholded image
Abw = im2bw(Agray);
subplot(1,2,2),imshow(Abw),title('Black and White');

% median filter clean up the image
%Abw = medfilt2(Abw);
%subplot(1,3,3),imshow(Abw),title('Cleaned up');

%% Morphology
[x,y] = size(Abw);
s = ones(5,5);
S = 25;
s = s/25;
Abw = double(Abw);
Temp = ones((x+4),(y+4));
Temp(5:(x+4),5:(y+4)) = Abw;
Ac = conv2(Temp,s);
Ac = Ac(5:(x+4),5:(y+4));

figure(3), subplot(3,2,1),imshow(Ac),title('Convolution');

%Dilation
ADil = Ac;
for i = 1:x
    for j = 1:y
        if Ac(i,j) < 1
            ADil(i,j) = 0;
        else
            ADil(i,j) = 1;
        end
    end
end
subplot(3,2,2), imshow(ADil),title('Dilation');

%Erosion
AEro = Ac;
for i = 1:x
    for j = 1:y
        if Ac(i,j) < 1/S
            AEro(i,j) = 0;
        else
            AEro(i,j) = 1;
        end
    end
end
subplot(3,2,3), imshow(AEro),title('Erosion');


%Majority
AMaj = Ac;
for i = 1:x
    for j = 1:y
        if Ac(i,j) < 2/S
            AMaj(i,j) = 0;
        else 
            AMaj(i,j) = 1;
        end
    end
end
subplot(3,2,4), imshow(AMaj),title('Majority');

%Opening
Temp1 = ones((x+4),(y+4));
Temp1(5:(x+4),5:(y+4)) = AEro;
AEroconv = conv2(Temp1,s);
AEroconv = AEroconv(5:(x+4),5:(y+4));
AOpen = Ac;

for i = 1:x
    for j = 1:y
        if AEroconv(i,j) < 1
            AOpen(i,j) = 0;
        else
            AOpen(i,j) = 1;
        end
    end
end

subplot(3,2,5), imshow(AOpen),title('Opening');

%Closing
Temp2 = ones((x+4),(y+4));
Temp2(5:(x+4),5:(y+4)) = ADil;
ADilconv = conv2(Temp2,s);
ADilconv = ADilconv(5:(x+4),5:(y+4));

AClo = Ac;
for i = 1:x
    for j = 1:y
        if ADilconv(i,j) < 1/S
            AClo(i,j) = 0;
        else
            AClo(i,j) = 1;
        end
    end
end

subplot(3,2,6), imshow(AClo),title('Closing');

%% Forward/

%Forward
[x,y] = size(Abw);
Abw = double(Abw);
Temp3 = Abw;
A4wr = Temp3;

for i = 1:x
    for j = 1:y
        if Temp3(i,j) == 0
            A4wr(i,j) = 1;
        elseif Temp3(i,j) == 1
            A4wr(i,j) =0;
        end
    end
end
%%

for i = 2:x
    for j = 2:y
        if A4wr(i,j) ~= 0
        A4wr(i,j) = min(A4wr(i-1,j),A4wr(i,j-1))+1;
        end
    end
end
A4wrmax = max(max(A4wr));

A4wr = A4wr/A4wrmax;
%%
for i = 1:x
    for j = 1:y
        if A4wr(i,j) == 0
            A4wr(i,j) = 1;
        elseif A4wr(i,j) == 1
            A4wr(i,j) =0;
        end
    end
end
figure(4), subplot(1,3,1),imshow(A4wr),title('Forward');

%% ASE

%South east
[x,y] = size(Abw);
Abw = double(Abw);
Temp4 = Abw;
Ase = Temp4;

for i = 1:x
    for j = 1:y
        if Temp4(i,j) == 0
            Ase(i,j) = 1;
        elseif Temp4(i,j) == 1
            Ase(i,j) =0;
        end
    end
end
%% A in South and East

for i = (x-1):-1:1
    for j = (y-1):-1:1
        if Ase(i,j) ~= 0
        Ase(i,j) = min(Ase(i+1,j),A4wr(i,j+1))+1;
        end
    end
end

Asemax = max(max(Ase));
Ase = Ase/Asemax;
%%
for i = 1:x
    for j = 1:y
        if Ase(i,j) == 0
            Ase(i,j) = 1;
        elseif Ase(i,j) == 1
            Ase(i,j) =0;
        end
    end
end
subplot(1,3,2),imshow(Ase),title('Ase');


%% Backward
Abacw = min(Ase,A4wr);
subplot(1,3,3),imshow(Abacw),title('A backward');


%% Connected components
Temp5 = ones(x+2,y+2);
Temp5(2:x+1,2:y+1) = Abw;
Aconn1 = Temp5;

k = 1;
for i = 2:x+1
    for j = 2:y+1
        if Temp5(i,j) == Temp5(i,j-1)
            Aconn1(i,j) = Aconn1(i,j-1);
        elseif Temp5(i,j) == Temp5(i-1,j)
            Aconn1(i,j) = Aconn1(i-1,j);
        else 
            k = k+1;
            Aconn1(i,j) = k;
        end
    end
end

Aconn = Aconn1;
Aconn1 = Aconn1(2:x+1,2:y+1);
Aconn1max = max(max(Aconn1));
for i = 1:x
    for j = 1:y
        if Aconn1(i,j) == 1
            Aconn1(i,j) = Aconn1max+1;
        end
    end
end

Aconn1 = Aconn1/(Aconn1max+1);
figure(5), subplot(1,2,1),imshow(Aconn1),title('Connected components 1st pass');


% Merge adjacent runs


for i = x+1:-1:2
    for j = y+1:-1:2
            if Aconn(i+1,j) ~= Aconn(i,j) && Temp5(i+1,j) == Temp5(i,j)
             Aconn(find(Aconn == Aconn(i+1,j))) = Aconn(i,j);
               
            end
    end
end


Aconn = Aconn(2:x+1,2:y+1);
Aconnmax = max(max(Aconn));
Aconn = Aconn/10;
subplot(1,2,2), imshow(Aconn),title('Connected components Merged');


 




