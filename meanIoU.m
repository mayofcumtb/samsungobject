clear;
clc;
close all;
%CLASSES=[{'aeroplane'},{'bicycle'},{'boat'},{'bottle'},{'bus'},{'car'},{'chair'},{'diningtable'},{'motorbike'},{'sofa'},{'train'},{'tvmonitor'}];
CLASSES={'__background__','bed','bench','bookshelf','cabinet','chair','diningtable','door','pillow','sofa','tvmonitor'};
cmap = colormap(hsv(9));
for k=1:length(CLASSES)
    iou{k,1}=0;%测试样本数
    iou{k,2}=[];%每个测试样本的iou
end
cadpath='D:\ZairanWang\ObjectNet3D\CAD\mat\';
file=dir([cadpath,'*.mat']);
cads={};
for k=1:length(CLASSES)-1
    cad=load(strcat(cadpath,CLASSES{k+1},'.mat'));
    fi=fieldnames(cad);
    cads{k}=getfield(cad,fi{1});
end
fidin=fopen('resultOb1.txt','r');
curNum=1;
while ~feof(fidin)
     disp(curNum);
     curNum=curNum+1;
     tline=fgetl(fidin);
     tline=regexp(tline, ' ', 'split');
     filename=tline{1};
     imname=strcat('D:\ZairanWang\ObjectNet3D\VOC2007xml\clean_InImages\',filename);
     matname=strrep(filename,'jpg','mat');
     if exist(strcat('D:\ZairanWang\ObjectNet3D\VOC2007xml\clean_InAnnotations\',matname),'file')
        load(strcat('D:\ZairanWang\ObjectNet3D\VOC2007xml\clean_InAnnotations\',matname));             
        cls = object.class;
        cls_index = find(strcmp(cls, CLASSES) == 1)-1;
        cad_index = object.cad_index;
        viewpoint = object.viewpoint;
         % azimuth
        if isfield(viewpoint, 'azimuth') == 0 || isempty(viewpoint.azimuth) == 1
            a = viewpoint.azimuth_coarse;
        else
            a = viewpoint.azimuth;
        end
        % elevation
        if isfield(viewpoint, 'elevation') == 0 || isempty(viewpoint.elevation) == 1
            e = viewpoint.elevation_coarse;
        else
            e = viewpoint.elevation;
        end

        % focal length
        f = viewpoint.focal;
        % in-plane rotation
        theta = viewpoint.theta;
        % distance
        d = viewpoint.distance;
        % principal point
        bbox=object.bbox;
        px = (bbox(3) - bbox(1))/2;
        py = (bbox(4) - bbox(2))/2;
        % viewport
        viewport = viewpoint.viewport;

        if isempty(theta), theta = 0; end
        if isempty(d), d = 5; end
        if isempty(f), f = 1; end
        if isempty(viewport), viewport = 2000; end
        if isempty(px), px = (bbox(3) - bbox(1))/2; end
        if isempty(py), py = (bbox(4) - bbox(2))/2; end
        principal = [px py];

        % overlap the CAD model
        vertex = cads{cls_index}(cad_index).vertices;
        face = cads{cls_index}(cad_index).faces;

        pa1.vertex=vertex;pa1.face=face;pa1.a=a;pa1.e=e;pa1.f=f;pa1.d=d;pa1.viewport=viewport;pa1.principal=principal;pa1.theta=theta;


         %cls=CLASSES{tline{2}+1};
         cls_indexP = str2double(tline{2});
         iou{cls_index+1,1}=iou{cls_index+1,1}+1;
         if cls_indexP>0
             pa2=pa1;
             pa2.a=str2double(tline{3});
             pa2.e=str2double(tline{4});
             pa2.theta=str2double(tline{5});
             if cls_indexP~=cls_index
                 disp(strcat('Object class: ',CLASSES{cls_index}));
                 disp(strcat('Predicted object class: ',CLASSES{cls_indexP}));
                 vertex = cads{cls_indexP}(1).vertices;
                 face = cads{cls_indexP}(1).faces;
                 pa2.vertex=vertex;
                 pa2.face=face;
             end
             %disp(tline);
             
             iou{cls_index+1,2}(iou{cls_index+1,1})=computeIoU(imname,pa1,pa2,cmap);
             close all;
         else%将图像分类为背景
             %iou{cls_index+1,1}=iou{cls_index+1,1}+1;
             iou{cls_index+1,2}(iou{cls_index+1,1})=0;
         end
     else%GT为背景图像
         iou{1,1}=iou{1,1}+1;
     end
end
fclose(fidin);
for k=1:length(iou)
    a=iou{k,2};
    a(isnan(a))=0.4;
    miou(k)=mean(a);
end
