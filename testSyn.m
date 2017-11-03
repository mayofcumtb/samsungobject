clear
clc
close all;

cmap = colormap(hsv(9));

impath='syn_images/';
cadpath='shapeData/';
savepath='proimg/';
imfile=dir(impath);%得到类别

for k=3:length(imfile)
    clsfile=dir(strcat(impath,imfile(k).name));%得到每个类别的子类别
    disp(imfile(k).name);
    for m=3:length(clsfile)
        %得到每个子类别的图像
        disp(clsfile(m).name);
        subclspath=strcat(impath,imfile(k).name,'/',clsfile(m).name,'/');
        subclsfile=dir([subclspath,'*.png']);
        obj = load_obj_file(strcat(cadpath,imfile(k).name,'/',clsfile(m).name,'/model.obj'));
        faces = obj.f3';
        vertices = obj.v';
        vertices(:,[2,3]) = vertices(:,[3,2]);
        for n=1:3%length(subclsfile)
            disp(subclsfile(n).name);
            imname=subclsfile(n).name;
            ind=find(imname=='_');
            azi=str2double(imname(ind(2)+2:ind(3)-1));
            ele=str2double(imname(ind(3)+2:ind(4)-1));
            the=str2double(imname(ind(4)+2:ind(5)-1));
            d=str2double(imname(ind(5)+2:end-4));
            
            I=imread([subclspath,imname]);
            [x,y,z]=size(I);
            im=uint8(zeros(size(I)));
            x=x/2;y=y/2;
%             hf = figure(1);
%             set(hf,'visible','off');
%             imshow(I);%原始图像
%             hold on;
%             %x2d = project_3d_msid(vertices, mod(azi+180,360), ele, d*2, 1, the, [y,x], 2000);
%             x2d = project_3d_msid(vertices, mod(azi+90,360), ele, d*2, 1, the, [y,x], 2000);
%             index_color = 1;
%             patch('vertices', x2d, 'faces', faces, ...
%                'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');
%            filename=strcat(savepath,imfile(k).name,clsfile(m).name,'_',num2str(n,'%02d'),'090.png');
%            hgexport(hf, filename, hgexport('factorystyle'), 'Format', 'png');
%            
%            hf1 = figure(2);
%            set(hf1,'visible','off');
%            imshow(I);%原始图像
%            hold on;
%             %x2d = project_3d_msid(vertices, mod(azi+180,360), ele, d*2, 1, the, [y,x], 2000);
%            x2d = project_3d_msid(vertices, mod(azi,360), ele, d*2, 1, the, [y,x], 2000);
%            index_color = 1;
%            patch('vertices', x2d, 'faces', faces, ...
%                'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');
%            filename=strcat(savepath,imfile(k).name,clsfile(m).name,'_',num2str(n,'%02d'),'000.png');
%            hgexport(hf1, filename, hgexport('factorystyle'), 'Format', 'png');
%            
%            hf2 = figure(3);
%            set(hf2,'visible','off');
%            imshow(I);%原始图像
%            hold on;
%             %x2d = project_3d_msid(vertices, mod(azi+180,360), ele, d*2, 1, the, [y,x], 2000);
%            x2d = project_3d_msid(vertices, mod(azi-90,360), ele, d*2, 1, the, [y,x], 2000);
%            index_color = 1;
%            patch('vertices', x2d, 'faces', faces, ...
%                'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');
%            filename=strcat(savepath,imfile(k).name,clsfile(m).name,'_',num2str(n,'%02d'),'190.png');
%            hgexport(hf2, filename, hgexport('factorystyle'), 'Format', 'png');
           
           hf3 = figure(1);
           set(hf3,'visible','off');
           imshow(I);%原始图像
           hold on;
            %x2d = project_3d_msid(vertices, mod(azi+180,360), ele, d*2, 1, the, [y,x], 2000);
           x2d = project_3d_msid(vertices, mod(azi+180,360), ele, d*2, 1, the, [y,x], 2000);
           index_color = 1;
           patch('vertices', x2d, 'faces', faces, ...
               'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');
           filename=strcat(savepath,imfile(k).name,clsfile(m).name,'_',num2str(n,'%02d'),'180.png');
           hgexport(hf3, filename, hgexport('factorystyle'), 'Format', 'png');           
           %pause;
           close all;
        end
    end
end

I=imread('D:\ZairanWang\PASCAL3D+\s000013.jpg');



% obj = load_obj_file('D:\ZairanWang\PASCAL3D+\model.obj');
% faces = obj.f3';
% vertices = obj.v';
% %shapenet模型与pascal3D+的模型方位角相差90度，theta角度相反
% vertices(:,[2,3]) = vertices(:,[3,2]);

% 
% 
% trimesh(faces, vertices(:,1), vertices(:,3), vertices(:,2), 'EdgeColor', 'r');
% axis equal;
% xlabel('x');
% ylabel('y');
% zlabel('z');
% view(0, 20);

[vertices, faces] = load_off_file('D:\ZairanWang\ObjectNet3D\CAD\off\bed\02.off');
%[vertices, faces] = load_off_file('01\model.off');
hf1 = figure(2);
imshow(I);%原始图像
hold on;



x2d = project_3d_msid(vertices, 275, 18, 2.5, 1, -2, [408.5,185], 2000);
index_color = 1;
patch('vertices', x2d, 'faces', faces, ...
   'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');