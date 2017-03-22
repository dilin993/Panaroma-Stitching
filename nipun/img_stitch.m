%select more than 4 points using show_ims.m
load('im1_points.mat');
load('im2_points.mat');
H1 = homography_mod(im1_cords',im2_cords');

im1 = imread('im1.jpg');
im2 = imread('im2.jpg');

h1 = size(im1,1);
h2 = size(im2,1);

w1 = size(im1,2); 
w2 = size(im2,2);

points = H1*[   [0,w2,0,w2];
                [0,0,h2,h2];
                [1,1,1,1]];
            
x_min = min( points(1,:));
y_min = min( points(2,:));


x_max = max( points(1,:));
y_max = max( points(2,:));


img_out = uint8(zeros( floor(max([y_max-y_min,h1,h1-y_min])) ,floor(max([x_max-x_min,w1,w1-x_min])) ,3));

%im1_placement
LT_x=1;LT_y=1;RB_x=w1;RB_y=h2;
LT_x2=int16(x_min); LT_y2= int16(y_min);

if(x_min<0) 
    LT_x = -int16(x_min);
    LT_x2 = 1;
    %LT_y2 = 1;
end

if(y_min<0) 
    LT_y = -int16(y_min); 
    LT_y2 = 1;
end

if(x_max>w1) 
    RB_x = int16(LT_x+w1); end

if(y_max>h1) 
    RB_y = int16(LT_y+h1); end

img_out((LT_y:LT_y+h1-1),(LT_x:LT_x+w1-1),:) = im1;


%im2 placement

del_x= points(1,2)-points(1,1);
del_y= points(2,2)-points(2,1);

angle = atan2(del_y,del_x)*(180/pi);
J = imrotate(im2,-angle,'bilinear','loose');

[h2,w2,d] = size(J);
img_out(LT_y2:LT_y2+h2-1,LT_x2:LT_x2+w2-1,:)=J/2+img_out(LT_y2:LT_y2+h2-1,LT_x2:LT_x2+w2-1,:)/2;

imshow(img_out);

