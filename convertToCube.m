function [ cube_vertex ] = convertToCube( mesh_vertex )
%   ��ͼ��Ķ�������Ϣת��Ϊ��������Ϣ�� ��Ҫԭ�����ҳ�����������ֵ����Сֵ��
%   Ȼ�������������Ϣ������ϳ�Ϊ������Ľṹ��Ϣ
%   �˴���ʾ��ϸ˵��
% get max values
max_values = max(mesh_vertex, [], 1);
x_max = max_values(1);
y_max = max_values(2);
z_max = max_values(3);

% get min values
min_values = min(mesh_vertex, [], 1);
x_min = min_values(1);
y_min = min_values(2);
z_min = min_values(3);

% cube_vertex = [ 
%     x_max, y_max, z_max;
%     x_min, y_max, z_max;
%     x_max, y_min, z_max;
%     x_max, y_max, z_min;
%     x_max, y_min, z_min;
%     x_min, y_max, z_max;
%     x_min, y_min, z_max;
%     x_min, y_min, z_min
%     ];
%% Because the face sequence is defined so the vertex sequence can not change!!!
cube_vertex = [
    x_max y_min z_min; % vertex 1
    x_max y_max z_min; % vertex 2
    x_max y_min z_max; % vertex 3
    x_max y_max z_max; % vertex 4
    
    x_min y_min z_max; % vertex 7
    x_min y_max z_max; % vertex 8
    x_min y_min z_min; % vertex 5
    x_min y_max z_min; % vertex 6
    ];
end

