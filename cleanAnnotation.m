clear;
clc;
close all;
%%.mat格式转xml格式
filepath='clean_InAnnotations/';

file=dir([filepath,'*.mat']);

minazi=0; maxazi=0; minele=0; maxele=0; minthe=0; maxthe=0;

for k=1:length(file)
    load(strcat(filepath,file(k).name));
    imname=strrep(file(k).name,'mat','jpg');%图像文件名与mat文件名一致
    imsize=round([object.bbox(4)-object.bbox(2),object.bbox(3)-object.bbox(1),3]);%图像大小
    
    %创建xml格式节点
    CreatenodeIn=com.mathworks.xml.XMLUtils.createDocument('annotation');
    RootIn=CreatenodeIn.getDocumentElement;%根节点
    [minazi, maxazi, minele, maxele, minthe, maxthe,suc1]=writeXML(minazi, maxazi, minele, maxele, minthe, maxthe,imname,imsize,object,CreatenodeIn,RootIn,1); 
    tempname=['clean_InXML\',imname];
    tempname=strrep(tempname,'.jpg','.xml');
    xmlwrite(tempname,CreatenodeIn);     
end

save AngleValue minazi maxazi minele maxele minthe maxthe;