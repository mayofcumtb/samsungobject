function [minazi, maxazi, minele, maxele, minthe, maxthe]=writeXML(minazi, maxazi, minele, maxele, minthe, maxthe,obj,Createnode,Root,flag)

for m=1:length(obj)
    object=obj(m);
    class=object.obj_id;
    bbox=object.bb;
    bbox=max(1,bbox);%�����С��0����ǿ�Ƹ�ֵΪ1
    truncated=0;
    occluded=0;
    difficult=0;
    imagename=object.imname;
    cad_index=0;
    azimuth=object.azi;
    elevation=object.ele;
    theta=object.the;
    if azimuth<minazi minazi=azimuth; end
    if azimuth>maxazi maxazi=azimuth; end
    if elevation<minele minele=elevation; end
    if elevation>maxele maxele=elevation; end
    if theta<minthe minthe=theta; end
    if theta>maxthe maxthe=theta; end            
    
    appendNode(Createnode,Root,imagename,class,bbox,truncated,occluded,difficult,cad_index,azimuth,elevation,theta,1);
       
end
end

function appendNode(Createnode,Root,imagename,class,bbox,truncated,occluded,difficult,cad_index,azimuth,elevation,theta,flag)
    if flag %��һ��object       

        node=Createnode.createElement('filename');
        node.appendChild(Createnode.createTextNode(imagename));
        Root.appendChild(node);

    end
    object_node=Createnode.createElement('object');
    Root.appendChild(object_node);
    node=Createnode.createElement('name');
    node.appendChild(Createnode.createTextNode(class));
    object_node.appendChild(node);

    pose_node=Createnode.createElement('pose');
    %node.appendChild(Createnode.createTextNode(sprintf('%s','Unspecified')));
    object_node.appendChild(pose_node);

    node=Createnode.createElement('azimuth');
    node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(azimuth))));
    pose_node.appendChild(node);

    node=Createnode.createElement('elevation');
    node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(elevation))));
    pose_node.appendChild(node);

    node=Createnode.createElement('theta');
    node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(theta))));
    pose_node.appendChild(node);   

    node=Createnode.createElement('truncated');
    node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(truncated))));
    object_node.appendChild(node);

    node=Createnode.createElement('difficult');
    node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(difficult))));
    object_node.appendChild(node);
    
    node=Createnode.createElement('occluded');
    node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(occluded))));
    object_node.appendChild(node);
    
    node=Createnode.createElement('cad_index');
    node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(cad_index))));
    object_node.appendChild(node);

    bndbox_node=Createnode.createElement('bndbox');
    object_node.appendChild(bndbox_node);

    node=Createnode.createElement('xmin');
    node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(bbox(1)))));
    bndbox_node.appendChild(node);

    node=Createnode.createElement('ymin');
    node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(bbox(2)))));
    bndbox_node.appendChild(node);

    node=Createnode.createElement('xmax');
    node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(bbox(3)))));
    bndbox_node.appendChild(node);

    node=Createnode.createElement('ymax');
    node.appendChild(Createnode.createTextNode(sprintf('%s',num2str(bbox(4)))));
    bndbox_node.appendChild(node);
end