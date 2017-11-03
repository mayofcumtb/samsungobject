clear;
clc;
close all;
%%.mat��ʽתxml��ʽ
filepath='clean_InAnnotations/';

file=dir([filepath,'*.mat']);

minazi=0; maxazi=0; minele=0; maxele=0; minthe=0; maxthe=0;

for k=1:length(file)
    load(strcat(filepath,file(k).name));
    imname=strrep(file(k).name,'mat','jpg');%ͼ���ļ�����mat�ļ���һ��
    imsize=round([object.bbox(4)-object.bbox(2),object.bbox(3)-object.bbox(1),3]);%ͼ���С
    
    %����xml��ʽ�ڵ�
    CreatenodeIn=com.mathworks.xml.XMLUtils.createDocument('annotation');
    RootIn=CreatenodeIn.getDocumentElement;%���ڵ�
    [minazi, maxazi, minele, maxele, minthe, maxthe,suc1]=writeXML(minazi, maxazi, minele, maxele, minthe, maxthe,imname,imsize,object,CreatenodeIn,RootIn,1); 
    tempname=['clean_InXML\',imname];
    tempname=strrep(tempname,'.jpg','.xml');
    xmlwrite(tempname,CreatenodeIn);     
end

save AngleValue minazi maxazi minele maxele minthe maxthe;