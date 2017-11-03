clear;
clc;
close all;

cmap = colormap(hsv(9));
[vertices,faces]=load_off_file('obj_01.off');

filename='gt.yml';

fid = fopen(filename, 'r');
R=zeros(3,3);
im=uint8(zeros([400,400]));
T=[-15.00029155, 0.16714724, 633.68225328];
K=[1075.65091572, 0.00000000, 225.06888344, 0.00000000, 1073.90347929, 199.72159802, 0.00000000, 0.00000000, 1.00000000];
K=reshape(K,3,3)';
while ~feof(fid)  
    fgetl(fid);
    line=fgetl(fid);
    line=line(15:end-1);
    str = regexp(line, ',', 'split');
    for i=1:length(str)
        R(i)=str2double(str{i});
    end
    
    R=R';
    a=[R,T'];
    b=K*a;
    x=[vertices ones(size(vertices,1), 1)];
    x=x';
    c=b*x;
    c(1,:) = c(1,:) ./ c(3,:);
    c(2,:) = c(2,:) ./ c(3,:);
    c = c(1:2,:)';
    
    figure(1), 
    subplot(1,2,1),imshow(im);
    hold on,
    index_color = 1;
    patch('vertices', c, 'faces', faces, ...
       'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');
   
   [azi,the,ele]=dcm2angle(R,'zyx');
   a=azi;
    e=-ele;
    theta=the;
    Rz = [cos(a) -sin(a) 0; sin(a) cos(a) 0; 0 0 1];   %rotate by a
    Rx = [1 0 0; 0 cos(e) -sin(e); 0 sin(e) cos(e)];   %rotate by e
    Rz2= [cos(theta), -sin(theta),0; sin(theta), cos(theta), 0; 0,0,1];
    R = Rz2*Rx*Rz;
    
    a=[R,T'];
    b=K*a;
    %x=[vertices ones(size(vertices,1), 1)];
    %x=x';
    c=b*x;
    c(1,:) = c(1,:) ./ c(3,:);
    c(2,:) = c(2,:) ./ c(3,:);
    c = c(1:2,:)';

    subplot(1,2,2), imshow(im);
    hold on,
    index_color = 1;
    patch('vertices', c, 'faces', faces, ...
       'FaceColor', cmap(index_color,:), 'FaceAlpha', 0.2, 'EdgeColor', 'none');
    pause;
    close all;
    
    fgetl(fid);
    fgetl(fid);
    fgetl(fid);
end
