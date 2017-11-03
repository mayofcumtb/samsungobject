clear;
clc;

load('2008_006696.mat');

I=imread('2008_006696.jpg');

[vertices,faces]=load_off_file('07.off');
hf1 = figure(1);
iptsetpref('ImshowBorder','tight'); 
set(0,'DefaultFigureMenu','none'); 
format compact; 
imshow(I);%原始图像
hold on;




cmap = colormap(hsv(9));
x=(record.objects.bbox(1)+record.objects.bbox(3))/2;
y=(record.objects.bbox(2)+record.objects.bbox(4))/2;
%x2d = project_3d_msid(convertToCube(vertices), 0, 42.7128, 5.8434, 1, 0.9223, [x,y], 3000);
x2d = project_3d_msid(convertToCube(vertices), 350.6147, 20.5305, 6.8762, 1, -1.7653, [x,y], 3000);
cube_face = [1 3 ; 1 2 ; 3 4; 2 4 ; 5 7; 3 5; 1 7; 7 8; 5 6; 6 8; 2 8; 4 6;];
index_color = 1;
patch('vertices', x2d, 'faces', cube_face, ...
    'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'b');
bbox = record.objects(1).bbox;
bbox_draw = [bbox(1) bbox(2) bbox(3)-bbox(1) bbox(4)-bbox(2)];
rectangle('Position', bbox_draw, 'EdgeColor', 'g', 'LineWidth', 1);
cls = record.objects(1).class;
text(bbox(1), bbox(2), cls, 'BackgroundColor', [.7 .9 .7]);

[vertices,faces]=load_off_file('D:\ZairanWang\ObjectNet3D\CAD\off\diningtable\01.off');
%[vertices,faces]=load_off_file('07.off');
% obj = load_obj_file('D:\ZairanWang\ObjectNet3D\CAD\off\bookshelf\04.obj');
% faces = obj.f3';
% vertices = obj.v';
%vertices(:,[2,3]) = vertices(:,[3,2]);
%vertices(:,2) = -vertices(:,2);

x=800;
y=800;
z=3;
cmap = colormap(hsv(9));

im=uint8(zeros([x,y,z]));
hf3 = figure(1);
%set(hf3,'visible','off');
imshow(im);%原始图像
hold on;

d=1;
x2d = project_3d_msid(vertices, 0, 20, d*3, 1, 0, [y/2,x/2], 2000);
index_color = 1;
patch('vertices', x2d, 'faces', faces, ...
   'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');

