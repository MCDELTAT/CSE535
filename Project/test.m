clc; clear all; close all;

set1folder = fullfile(pwd,'att_faces\s1');
set2folder = fullfile(pwd,'att_faces\s2');
set3folder = fullfile(pwd,'att_faces\s3');
set4folder = fullfile(pwd,'att_faces\s4');

persons = 4; %how many rows of data of different people
quantity = 5; %how many columns of the same person

for i = 1:persons
  checkfiles = strcat('set',num2str(i),'folder');
  if ~isdir(eval(checkfiles))
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', checkfiles);
    uiwait(warndlg(errorMessage));
    return;
  end
 

  filepattern = fullfile(eval(checkfiles), '*.pgm');
  srcFile=dir(filepattern);
  for j = 1:length(srcFile)
    basefile = srcFile(j).name;
    filename=fullfile(eval(checkfiles), basefile);
    A{j+(5*(i-1))}=double(imread(filename));
    %figure, pcolor(flipud(A{i})), shading interp, colormap(gray)
  end
end 

[r c] = size(A);
figure(111)
for i = 1:c
  subplot(c/quantity, c/persons, i);
  pcolor(flipud(A{i})), shading interp, colormap(gray)
  axis off;
end  

for i = 1:quantity
  if(i==1)
    avg1=A{i};
    avg2=A{i+5};
    avg3=A{i+10};
    avg4=A{i+15};
  else  
    avg1=avg1+A{i};
    avg2=avg2+A{i+5};
    avg3=avg3+A{i+10};
    avg4=avg4+A{i+15};
  end
end

avg1=avg1/quantity;
avg2=avg2/quantity;
avg3=avg3/quantity;
avg4=avg4/quantity;

figure(222)
subplot(persons/2,persons/2,1)
pcolor(flipud(avg1)), shading interp, colormap(gray), axis off;  
subplot(persons/2,persons/2,2)
pcolor(flipud(avg2)), shading interp, colormap(gray), axis off;   
subplot(persons/2,persons/2,3)
pcolor(flipud(avg3)), shading interp, colormap(gray), axis off;   
subplot(persons/2,persons/2,4)
pcolor(flipud(avg4)), shading interp, colormap(gray), axis off;   

for i=1:c
  Data(i,:) = [reshape(A{i},1,112*92)];
end

Corr = Data.' * Data;
[V, D] = eigs(Corr, 20, 'lm');

figure(333);
subplot(2,2,1),face1=reshape(V(:,1),112,92); 
pcolor(flipud(face1)), shading interp, colormap(gray), axis off;  
subplot(2,2,2),face1=reshape(V(:,2),112,92); 
pcolor(flipud(face1)), shading interp, colormap(gray), axis off;  
subplot(2,2,3),face1=reshape(V(:,3),112,92); 
pcolor(flipud(face1)), shading interp, colormap(gray), axis off;
 
for i = 1:c
  proj(i,:)=Data(i,:)*V;
end



r1 = double(imread('1.pgm'));
r2 = double(imread('7.pgm'));
r3 = double(imread('2.pgm'));
figure(444)
%subplot(2,2,1);
%pcolor(flipud(r1)), shading interp, colormap(gray)
%title('r1')
%subplot(2,2,2);
pcolor(flipud(r2)), shading interp, colormap(gray)
title('r2')
%subplot(2,2,3);
%pcolor(flipud(r3)), shading interp, colormap(gray)
%title('r3')
Vec=reshape(r2,1,112,92);
projrec=Vec*V;

for i = 1:c
  res(i,:)=abs(proj(i,:)-projrec);
end

index = -1;
for i = 1:c
  thesum(i,:)=sum(res(i,:));
  if(thesum(i,:)/c < 500)
    index = i;
  end
  thesum(i,:)/c
end
thesum;
thesum/c
index
myset = detectSet(index)
msgbox(sprintf('detected %s', myset));
