clear;
clc;
close all;

datapath='/data/zairan.wang/Dataset/T-less/JPEGImages/';
xmlpath='/data/zairan.wang/Dataset/T-less/Annotations/';
fidop = fopen('all.txt', 'w');

camDir=dir(datapath);
minazi=0; maxazi=0; minele=0; maxele=0; minthe=0; maxthe=0;
for i=3:length(camDir)
    camDirname=camDir(i).name;%canon
    disp(['Camera:',camDirname]);
    subDir=dir(strcat(datapath,camDirname));
    for j=3:length(subDir)
        subDirname=subDir(j).name;%01
        disp(['SubDir:',subDirname]);
        if  exist(strcat(datapath,camDirname,'/',subDirname,'/rgb'),'dir')==0||exist(strcat(datapath,camDirname,'/',subDirname,'/depth'),'dir')==0
            disp('rgb or depth images do not exist!!!!!!!!!');
            continue;
        end
        fid = fopen(strcat(datapath,camDirname,'/',subDirname,'/gt.yml'), 'r');
        R=zeros(3,3);
        bb=zeros(1,4);
        while ~feof(fid)  
            line=fgetl(fid);%img ID
            line=line(1:end-1);
            imname=str2double(line);
            imname=strcat(num2str(imname,'%04d'),'.png');
            line=fgetl(fid);%Rotaion matrix
            line=line(15:end-1);
            str = regexp(line, ',', 'split');
            for k=1:length(str)
                R(k)=str2double(str{k});
            end
            R=R';
            [azi,the,ele]=dcm2angle(R,'zyx');
            ele=-ele;
            
            
            
            fgetl(fid);%Translation matrix
            line=fgetl(fid);%bounding box
            line=line(12:end-1);
            str = regexp(line, ',', 'split');
            for k=1:length(str)
                bb(k)=str2double(str{k});
            end
            bb(3)=bb(1)+bb(3);
            bb(4)=bb(2)+bb(4);
            line=fgetl(fid);%cad index
            line=line(11:end);
            obj_id=line;
            
            obj.imname=imname;
            obj.azi=azi;
            obj.ele=ele;
            obj.the=the;
            obj.bb=bb;
            obj.obj_id=obj_id;
            %disp(obj);
            %write XML
            CreatenodeIn=com.mathworks.xml.XMLUtils.createDocument('annotation');
            RootIn=CreatenodeIn.getDocumentElement;%��ڵ�
            [minazi, maxazi, minele, maxele, minthe, maxthe]=writeXML(minazi, maxazi, minele, maxele, minthe, maxthe,obj,CreatenodeIn,RootIn); 
            tempname=[xmlpath,camDirname,'/',subDirname,'/',imname];
            tempname=strrep(tempname,'.png','.xml');
            xmlwrite(tempname,CreatenodeIn);     
            
            line=strcat(camDirname,'/',subDirname,'/',imname);
            fprintf(fidop,'%s\n',line);
            
        end
        fclose(fid);
%         imgfile=dir([strcat(datapath,camDirname,'/',subDirname),'*.png']);
%         for k=1:length(imgfile)
%         end
    end
end

fclose(fidop);


