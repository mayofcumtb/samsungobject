clear;
clc;
close all;

[vertices,faces]=load_off_file('obj_01.off');
imgname='E:\Database\t-less_toolkit-master\01\rgb\0114.png';
I=imread(imgname);

cmap = colormap(hsv(9));

im=uint8(zeros(size(I)));
[x,y,z]=size(I);
hf3 = figure(1);
%set(hf3,'visible','off');

subplot(1,3,1);imshow(I);

subplot(1,3,2);imshow(im);
%x2d = project_3d_msid(vertices, -92, 51, 8, 1, 28, [x/2,y/2], 2000);
x2d = project_3d_msid(vertices, 10, 20, 800, 1, 10, [y/2,x/2], 2000);
index_color = 1;
patch('vertices', x2d, 'faces', faces, ...
   'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');

subplot(1,3,3);imshow(I);
%title(imgfile(k).name);
patch('vertices', x2d, 'faces', faces, ...
   'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');
%pause;

load('pillow.mat'); 
vertices=pillow(1).vertices;
faces=pillow(1).faces;

for sub=1:20
disp('SubClass:');
disp(sub);
imgpath='F:/ZairanWang/sys/pillow/';
imgpath=strcat(imgpath,num2str(sub,'%02d'),'/');
annpath='../no_crop_uniform_data_no_background/Annotations/';

imgfile=dir([imgpath,'*.png']);

for k=1:10%length(imgfile)
    disp(k);
    
    imgname=imgfile(k).name;
    disp(imgname);
    ind= find(imgname=='_');
    a=str2double(imgname(ind(2)+2:ind(3)-1));
    e=str2double(imgname(ind(3)+2:ind(4)-1));
    theta=str2double(imgname(ind(4)+2:ind(5)-1));
    
    d=str2double(imgname(ind(5)+2:end-4));
    
    imgname=strcat(imgpath,imgname);
    I=imread(imgname);
    %load('../cads.mat')
    % vertices=cads{21,1}(1).vertices;
    % faces=cads{21,1}(1).faces;
    
    %[vertices,faces]=load_off_file('D:\ZairanWang\ObjectNet3D\CAD\off\diningtable\01.off');
    %[vertices,faces]=load_off_file('07.off');
    % obj = load_obj_file('D:\ZairanWang\ObjectNet3D\CAD\off\bookshelf\04.obj');
    % faces = obj.f3';
    % vertices = obj.v';
    %vertices(:,[2,3]) = vertices(:,[3,2]);
    %vertices(:,2) = -vertices(:,2);


    cmap = colormap(hsv(9));

    im=uint8(zeros(size(I)));
    [x,y,z]=size(I);
    hf3 = figure(1);
    %set(hf3,'visible','off');
   
    subplot(1,3,1);imshow(I);
    
    subplot(1,3,2);imshow(im);
    %x2d = project_3d_msid(vertices, -92, 51, 8, 1, 28, [x/2,y/2], 2000);
    x2d = project_3d_msid(vertices, a, e, d*2, 1, -theta, [y/2,x/2], 2000);
    index_color = 1;
    patch('vertices', x2d, 'faces', faces, ...
       'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');

    subplot(1,3,3);imshow(I);
    %title(imgfile(k).name);
    patch('vertices', x2d, 'faces', faces, ...
       'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');
   pause;
end
end
% imshow(im);%Ô­Ê¼Í¼Ïñ
% hold on;
% 
% d=1;
% x2d = project_3d_msid(vertices, 0, 20, d*3, 1, 0, [y/2,x/2], 2000);
% index_color = 1;
% patch('vertices', x2d, 'faces', faces, ...
%    'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');

