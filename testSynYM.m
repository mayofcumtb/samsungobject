clear;
clc;
clear;
clc;
close all;

datapath='/data/zairan.wang/ObjectNet3D/VOC_syn_real_no_crop_bkg/';

imagepath=strcat(datapath,'JPEGImages_C/');
annpath=strcat(datapath,'Annotations/');
target = './view_images__1/';
mkdir(target);

file=dir([imagepath,'*.jpg']);
disp(file);
cmap = colormap(hsv(9));
for k=1:length(file)
    
    imgname=file(k).name;
    disp(imgname);
    annname=strrep(imgname,'jpg','xml');
    disp(strcat(annpath,annname));
    xmlDoc = xmlread(strcat(annpath,annname));
    name_array = xmlDoc.getElementsByTagName('name');
    name = char(name_array.item(0).getTextContent());
    
    azi_array = xmlDoc.getElementsByTagName('azimuth');
    azi = str2double(azi_array.item(0).getTextContent());
    
    ele_array = xmlDoc.getElementsByTagName('elevation');
    ele = str2double(ele_array.item(0).getTextContent());
    
    the_array = xmlDoc.getElementsByTagName('theta');
    the = str2double(the_array.item(0).getTextContent());
    
    d_array = xmlDoc.getElementsByTagName('distance');
    d = str2double(d_array.item(0).getTextContent());

%     disp(name);
%     disp(azi);
%     disp(ele);
%     disp(the);
%     disp('res');
    
    I=imread(strcat(imagepath,imgname));
    im=uint8(zeros(size(I)));
    [x,y,z]=size(I);
    hf = figure(1);
    set(hf,'visible', 'off');
    set(0,'CurrentFigure',hf)
    %figure('visible', 'off');
    %set(handle(jWindow),'Enabled',false);
    %set(hf3,'visible','off');
   
    subplot(1,3,1);imshow(I);
    
    subplot(1,3,2);imshow(im);
    
    load(strcat(name,'.mat'));
    vertices=data(1).vertices;
    faces=data(1).faces;
    %x2d = project_3d_msid(vertices, -92, 51, 8, 1, 28, [x/2,y/2], 2000);
    x2d = project_3d_msid(vertices, azi, ele, d*2, 1, the, [y/2,x/2], 2000);
    index_color = 1;
    patch('vertices', x2d, 'faces', faces, ...
       'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');

    subplot(1,3,3);
    imshow(I);
    %title(imgfile(k).name);
    patch('vertices', x2d, 'faces', faces, ...
       'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');
   
   print(gcf,'-djpeg',strcat(target,imgname));
   %saveas(hf,strcat(target,imgname))
   %pause;
   %close all;
end

