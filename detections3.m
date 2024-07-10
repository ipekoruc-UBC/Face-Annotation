function detections3(hobject,callbackdata,arr)
tic
 val=hobject.Value;
 maps=hobject.String;
 newmap=maps{val};
 path='';
 pathfinal=strcat(path,newmap);
 cd(pathfinal);
 filestr=strcat(pathfinal,'/',newmap,'.mat');
 listing=dir('IMG_*.jpg');
 [m,n]=size(listing);
 num=m;
 %initial declarations
str='0001';%The starting index for the images
filename='IMG_0001';% the filename of the first image
flag=0;
i=1;
string={'FrontalFaceCART','FrontalFaceLBP','ProfileFace','UpperBody'}; %the different variants of the Viola Jones that are being used
while i<=num
    filename1=strcat(filename,'.jpg');
    n=exist(filename1);  %checks if such a file exists
    if n~=0
        jpegimg=imread(filename,'jpeg');
        disp(i);
        facedetec(i).flag=0;
        facedetec(i).image=filename1;   % storing the filename and do an imread again if required
        segments(i).line=double.empty(0,4);
        facedetec(i).bboxes=double.empty(0,4);% create an empty array to concatenate with bboxes
        facedetec(i).regarding=uint8.empty(0,1);% A variable that we use to disregard size for any image
        facedetec(i).d=cellstr(char.empty(0,1));
        facedetec(i).f=cellstr(char.empty(0,1));
        facedetec(i).gender= cellstr(char.empty(0,1));
         facedetec(i).pose1=cellstr(char.empty(0,1));
         facedetec(i).familiar=cellstr(char.empty(0,1)); % fam abbreviated for familiar
         facedetec(i).ethnic=cellstr(char.empty(0,1)); % cau abbreviated for caucasian
        facedetec(i).anydetection=0; %tells us if any detections(faces or false alarms) in that image
        facedetec(i).NoPeople=0;
       for a=1:4
            facedetector1=vision.CascadeObjectDetector(char(string(a))); %declaring the object that applies the Viola Jones for us
            facedetector1.MergeThreshold=14;
            facedetector1.MinSize = [60 60];
            bboxes=step(facedetector1,jpegimg);%stores all the boxes detected
            [m,n]=size(bboxes);
            if m~=0 %executes only if there are any detections
            facedetec(i).anydetection=1;%means that there is some detection in the image 
            facedetec(i).bboxes=[facedetec(i).bboxes;bboxes];%  concatenating bboxes from all three algorithms
            end
       end
        [m,n]=size(facedetec(i).bboxes);
        if m~=0
          flag=0;
          for row=1:m
             facedetec(i).regarding(row,1)=1; % by default regard size for all images
             facedetec(i).gender(row,:)=cellstr('f');
             
             facedetec(i).pose1(row,:)=cellstr('fr');
             facedetec(i).familiar(row,:)=cellstr('fam'); % fam abbreviated for familiar
             facedetec(i).ethnic(row,:)=cellstr('cau'); % cau abbreviated for caucasian
             conv=char(facedetec(i).pose1(row,:)); 
             conv1=char(facedetec(i).familiar(row,:));
             conv2=char(facedetec(i).ethnic(row,:));
             r=num2str(facedetec(i).bboxes(row,3));
             str3='red';
             if flag==0
                 c=char(str3);
                 f1=char(strcat(r,' ,',conv,' ,',conv1,',',conv2));
             else
                 c=char(c,str3);
                 mn=char(strcat(r,' ,',conv,' ,',conv1,',',conv2));
                 f1=char(f1,mn);
             end
             f=cellstr(f1);
             flag=1;
             d=cellstr(c);
          end
        end
          if facedetec(i).anydetection==1
           facedetec(i).d=d;% colors corresponding to the gender which is set to red for all boxes by default to indicate female
           facedetec(i).f=f; % concatenation of size,pose and familiarity for all faces which is initially set to frontal for all
           disp(facedetec(i).bboxes);
           ifaces=insertObjectAnnotation(jpegimg,'rectangle',facedetec(i).bboxes,facedetec(i).f,'FontSize',24,'Color',facedetec(i).d); % show image with all detections annotated     
           figure(i),imshow(ifaces);% display the annotated figure  
           close all;% close the figure 
          else
            imshow(jpegimg);
            close all;
          end
        i=i+1;
    end
    str=str2double(str)+1; %incrementing str value which is a string ,hence the conversion first                                                    
    str=num2str(str);% converting str back to a string
    noofzeros=4-length(str);% all strings have 4 alphanumerics, so we need to append the appropriate number of zeros
    zerostr='';
    for k=1:noofzeros
        zerostr=strcat(zerostr,'0');  %loop to obtain a string with appropriate number of zeros
    end
    str=strcat(zerostr,str);%obtaining a string with the desired alphanumeric
    filename=strcat('IMG_',str);%obtaining the filename before testing
end
cd('..');
analyzed=0;
total=num;
filestr=strcat(pathfinal,'/',newmap,'.mat');
save(filestr,'facedetec','segments','total','-v7.3','analyzed');  % Save the data structure and the number of indexes that had an image 
clear all;
toc;








                
    

