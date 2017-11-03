function d=RM2Angle(R)
ele=asin(-R(3));
if ele>=0
    ele1=pi-ele;
else
    ele1=-pi-ele;
end
se=sin(ele);ce=cos(ele);
se1=sin(ele1);ce1=cos(ele1);

the=acos(R(9)/ce);
the1=-the;

st=sin(the);ct=cos(the);
st1=sin(the1);ct1=cos(the1);

azi=acos(R(1)/ce);
azi1=-azi;

sa=sin(azi);ca=cos(azi);
sa1=sin(azi1);ca1=cos(azi1);

%奇数行存sin值，偶数行存cos值。
sc(1,1)=sa;sc(1,2)=se;sc(1,3)=st;
sc(2,1)=ca;sc(2,2)=ce;sc(2,3)=ct;

sc(3,1)=sa;sc(3,2)=se;sc(3,3)=st1;
sc(4,1)=ca;sc(4,2)=ce;sc(4,3)=ct1;

sc(5,1)=sa1;sc(5,2)=se;sc(5,3)=st;
sc(6,1)=ca1;sc(6,2)=ce;sc(6,3)=ct;

sc(7,1)=sa1;sc(7,2)=se;sc(7,3)=st1;
sc(8,1)=ca1;sc(8,2)=ce;sc(8,3)=ct1;

for i=9:16
    sc(i,1)=sc(i-8,1);
    if mod(i,2)==1
        sc(i,2)=se1;
    else
        sc(i,2)=ce1;
    end
    sc(i,3)=sc(i-8,3);
end


for i=1:8
    d(i)=0;
    d(i)=abs(sc(2*i,1)*sc(2*i-1,2)*sc(2*i-1,3)-sc(2*i-1,1)*sc(2*i,2)-R(4))+abs(sc(2*i,1)*sc(2*i-1,2)*sc(2*i,3)+sc(2*i-1,1)*sc(2*i-1,3)-R(7))+abs(sc(2*i-1,1)*sc(2*i,2)-R(2));
    d(i)=d(i)+abs(sc(2*i-1,1)*sc(2*i-1,2)*sc(2*i-1,3)+sc(2*i,1)*sc(2*i,3)-R(5))+abs(sc(2*i-1,1)*sc(2*i-1,2)*sc(2*i,3)-sc(2*i,1)*sc(2*i-1,3)-R(8))+abs(sc(2*i,2)*sc(2*i-1,3)-R(6));
end

[md,ind]=min(d);

disp(['minD:',num2str(md)]);
if ind==2||ind==4
    the=the1;
end
if ind==3||ind==4
    azi=azi1;
end

d=d(ind);