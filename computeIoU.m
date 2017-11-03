function iou = computeIoU( imname,pa1,pa2,cmap )
%COMPUTEIOU 此处显示有关此函数的摘要
%   此处显示详细说明

%clear;
%clc;
%imname='..\Images\n02747802_3613.jpeg';

I=imread(imname);

im=uint8(zeros(size(I)));


hf1 = figure(1);
set(hf1,'visible','off');
% iptsetpref('ImshowBorder','tight'); 
% set(0,'DefaultFigureMenu','none'); 
% format compact; 
imshow(im);%原始图像
hold on;
% overlap the CAD model
%vertex = cads{cls_index}(cad_index).vertices;
%face = cads{cls_index}(cad_index).faces;
% projection function

%load st;

x2d = project_3d_msid(pa1.vertex, pa1.a, pa1.e, pa1.d, pa1.f, pa1.theta, pa1.principal, pa1.viewport);


index_color = 1;

patch('vertices', x2d, 'faces', pa1.face, ...
   'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');

%x2d = project_3d_msid(convertToCube(pa1.vertex), pa1.a, pa1.e, pa1.d, pa1.f, pa1.theta, pa1.principal, pa1.viewport);
%cube_face = [1 3 ; 1 2 ; 3 4; 2 4 ; 5 7; 3 5; 1 7; 7 8; 5 6; 6 8; 2 8; 4 6;];
% patch('vertices', x2d, 'faces', cube_face, ...
%     'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'b');
 

 
%e=e-10;
hf2 = figure(2);
set(hf2,'visible','off');
iptsetpref('ImshowBorder','tight'); 
set(0,'DefaultFigureMenu','none'); 
format compact; 
imshow(im);
hold on;
x2d1 = project_3d_msid(pa2.vertex, pa2.a, pa2.e, pa2.d, pa2.f, pa2.theta, pa2.principal, pa2.viewport);
patch('vertices', x2d1, 'faces', pa2.face, ...
   'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');

% x2d = project_3d_msid(convertToCube(pa2.vertex), pa2.a, pa2.e, pa2.d, pa2.f, pa2.theta, pa2.principal, pa2.viewport);
% patch('vertices', x2d, 'faces', cube_face, ...
%     'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'b');
  
 
filename1='..\0.png';
filename2='..\1.png';
hgexport(hf1, filename1, hgexport('factorystyle'), 'Format', 'png');
hgexport(hf2, filename2, hgexport('factorystyle'), 'Format', 'png');

im1=imread(filename1);
im2=imread(filename2);
im1=rgb2gray(im1);
im2=rgb2gray(im2);

n=im1&im2;
u=im1|im2;
iou=sum(n(:)>0)/sum(u(:)>0);
figure(3);
subplot(1,3,1);imshow(I);
subplot(1,3,2);imshow(im);
patch('vertices', x2d, 'faces', pa1.face, ...
   'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');
subplot(1,3,3);imshow(im);
patch('vertices', x2d1, 'faces', pa2.face, ...
   'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');
disp(iou);