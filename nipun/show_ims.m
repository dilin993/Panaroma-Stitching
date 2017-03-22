function demoOnImageClick
clc;clear;

imObj = imread('im_1.jpg');
imObj2 = imread('im_2.jpg');
figure;
hAxes = axes();
subplot(2,1,1);
imageHandle = imshow(imObj);
subplot(2,1,2);
imageHandle2 = imshow(imObj2);
set(imageHandle,'ButtonDownFcn',@ImageClickCallback);
set(imageHandle2,'ButtonDownFcn',@ImageClickCallback2);
im1_cords=[];
im2_cords=[];

function ImageClickCallback ( objectHandle , eventData)
axesHandle  = get(objectHandle,'Parent');
coordinates = get(axesHandle,'CurrentPoint'); 
coordinates = coordinates(1,1:2);
im1_cords = [im1_cords;coordinates];
%im1_cords = coordinates;
assignin('base','im1_cords',im1_cords);
%message     = sprintf('x: %.1f , y: %.1f',coordinates (1) ,coordinates (2));
%helpdlg(message);
end

function ImageClickCallback2 ( objectHandle , eventData)
axesHandle  = get(objectHandle,'Parent');
coordinates = get(axesHandle,'CurrentPoint'); 
coordinates = coordinates(1,1:2);
im2_cords = [im2_cords;coordinates];
%im1_cords = coordinates;
assignin('base','im2_cords',im2_cords);
%message     = sprintf('x: %.1f , y: %.1f',coordinates (1) ,coordinates (2));
%helpdlg(message);
end
end