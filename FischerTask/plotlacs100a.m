function [colorfish,Posfish_upcorner,Posfish_downcorner]=plotlacs(xpos_lac,ypos_lac,size_lac,proportion_fish,shape_ratio_fish)
screens=Screen('Screens');
%HideCursor;
% screenNum=0;
% [w,rect]=Screen('OpenWindow',screenNum);
% white=WhiteIndex(w);

red=imread('red.jpg'); %read images of fishes in the lakes
bl=imread('black.jpg');

%wPtr = w;

size_lac_x=size_lac;
size_lac_y=size_lac/shape_ratio_fish;

size_fish_x=size_lac_x/10;
size_fish_y=size_lac_y/10;


k=1;

%central row
for i=1:11
    Posfish(k,:)=[xpos_lac-(i-5.5)*size_fish_x,ypos_lac];
    k=k+1;
 
end

%one row up
for i=1:10
    Posfish(k,:)=[xpos_lac-(i-5)*size_fish_x,ypos_lac+size_fish_y];
    k=k+1;
end

%one row down
for i=1:10
    Posfish(k,:)=[xpos_lac-(i-5)*size_fish_x,ypos_lac-size_fish_y];
    k=k+1;
end

%two rows up
for i=1:9
    Posfish(k,:)=[xpos_lac-(i-4.5)*size_fish_x,ypos_lac+2*size_fish_y];
    k=k+1;
end

P=0;
%two rows down
for i=1:9
    Posfish(k,:,:)=[xpos_lac-(i-4.5)*size_fish_x,ypos_lac-2*size_fish_y];
    k=k+1;
end

%three rows up
for i=1:8
    Posfish(k,:)=[xpos_lac-(i-4)*size_fish_x,ypos_lac+3*size_fish_y];
    k=k+1;
end

P=0;
%tree rows down
for i=1:8
    Posfish(k,:,:)=[xpos_lac-(i-4)*size_fish_x,ypos_lac-3*size_fish_y];
    k=k+1;
end

%four rows up
for i=1:7
    Posfish(k,:)=[xpos_lac-(i-3.5)*size_fish_x,ypos_lac+4*size_fish_y];
    k=k+1;
end

P=0;
%four rows down
for i=1:7
    Posfish(k,:,:)=[xpos_lac-(i-3.5)*size_fish_x,ypos_lac-4*size_fish_y];
    k=k+1;
end

%five rows up
for i=1:6
    Posfish(k,:)=[xpos_lac-(i-3)*size_fish_x,ypos_lac+5*size_fish_y];
    k=k+1;
end

P=0;
%five rows down
for i=1:6
    Posfish(k,:,:)=[xpos_lac-(i-3)*size_fish_x,ypos_lac-5*size_fish_y];
    k=k+1;
end

%six rows up
for i=1:5
    Posfish(k,:)=[xpos_lac-(i-2.5)*size_fish_x,ypos_lac+6*size_fish_y];
    k=k+1;
end

P=0;
%six rows down
for i=1:4
    Posfish(k,:,:)=[xpos_lac-(i-2)*size_fish_x,ypos_lac-6*size_fish_y];
    k=k+1;
end


Posfish_upcorner=round(Posfish);

Posfish_downcorner=round(Posfish+2^0.5/2*ones(100,1)*[size_fish_x,size_fish_y]);

perm_pos=randperm(100);

colorfish(perm_pos(1:round(proportion_fish*100)))=1;
colorfish(perm_pos(round(proportion_fish*100+1):100))=0;

% for k=1:100
%     if colorfish(k)==1
%         Screen('PutImage', wPtr, red, [Posfish_upcorner(k,1) Posfish_upcorner(k,2) Posfish_downcorner(k,1) Posfish_downcorner(k,2)]) 
%     elseif colorfish(k)==0
%         Screen('PutImage', wPtr, bl, [Posfish_upcorner(k,1) Posfish_upcorner(k,2) Posfish_downcorner(k,1) Posfish_downcorner(k,2)])
%     end
% end

%vbl=Screen('Flip', wPtr);


  
  