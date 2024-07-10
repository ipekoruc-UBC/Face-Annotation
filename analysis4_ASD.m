    function analysis4_ASD(source,callbackdata)
     val=source.Value;
     maps= source.String;
     newmap =  maps{val};
     path='';
     pathfinal=strcat(path,newmap);
     cd(pathfinal);
     addpath(path);
     str=strcat(newmap,'.mat');
     p=load(str);
     if p.analyzed==1
          facedetec1 = p.facedetec1;
          segments=p.segments;
     else
         facedetec1 = p.facedetec;
         segments=p.segments;
     end
     facedetec = p.facedetec;
     total=p.total;
     prev=1;
     img=imread(facedetec1(1).image);
     bboxes=facedetec1(1).bboxes;
     [m,n]=size(bboxes);
     num=1;
     if m~=0
      ifaces=insertObjectAnnotation(img,'rectangle',bboxes,facedetec1(num).f,'Color',facedetec1(num).d,'FontSize',29);
      figure(1),imshow((ifaces)),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
     else
      figure(1),imshow(img),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
     end
      a=uicontrol('Style','slider','Callback',@display_slider_value,'Min',0,'Max',(total-1),'SliderStep',[(1/(total-1)) (10/(total-1))] );
      a.Position=[20 20 130 50];
      f=uicontrol('Style','pushbutton','String','Select Correct Detections','Callback',@func1);
      f.Position=[210 20 80 50];
      g=uicontrol('Style','pushbutton','String','Add Faces','Callback',@func2);
      g.Position=[300 20 80 50];
      h=uicontrol('Style','pushbutton','String','Update','Callback',@func3);
      h.Position=[400 20 80 50];
      d=uicontrol('Style','pushbutton','String','Restore','Callback',{@restore});
      d.Position=[500 20 80 50];
      u=uicontrol('Style','pushbutton','String','Delete','Callback',{@delete});
      u.Position=[600 20 80 50];
      u.Visible='on';
      v=uicontrol('Style','pushbutton','String','Gender','Callback',@gender);
      v.Position=[700 20 80 50];
      z=uicontrol('Style','pushbutton','String','Pose','Callback',@pose);
      z.Position=[800 20 80 50];
      e=uicontrol('Style','pushbutton','String','Familiarity','Callback',{@familiar});
      e.Position=[900 20 80 50];
      e1=uicontrol('Style','pushbutton','String','Ethnicity','Callback',{@ethnic});
      e1.Position=[1000 20 80 50];
      e2=uicontrol('Style','pushbutton','String','Save','Callback',{@save1});
      e2.Position=[1100 20 80 50];
      e3=uicontrol('Style','pushbutton','String','Disregard Size','Callback',@disregard);
      e3.Position=[1200 20 80 50];
      e6=uicontrol('Style','pushbutton','String','AddLine','Callback',@lines);
      e6.Position=[1300 20 80 50];
      e4=uicontrol('Style','edit','Callback',{@edit});
      e4.Position=[1200 600 80 50];
      e5=uicontrol('Style','text','Position',[1200 650 60 25],'String','Enter Pg No.');
      
      e7=uicontrol('Style','edit','Callback',{@people});
      e7.Position=[1200 700 80 50];
      e8=uicontrol('Style','text','Position',[1200 750 60 25],'String','No. of people');
     
   
      
%     end
   function display_slider_value(hobject,callbackdata)
     newval = num2str(hobject.Value);
     num=int64(hobject.Value);
     num=num+1;
     disp(num);
      if prev >=1
         disp('here');
         if  facedetec1(prev).flag==0
           facedetec1(prev).regarding=uint8.empty(0,1);
           facedetec1(prev).bboxes= double.empty(0,4);
           facedetec1(prev).d=cellstr(char.empty(0,4));
           facedetec1(prev).f=cellstr(char.empty(0,1));
           facedetec1(prev).gender= cellstr(char.empty(0,1));
           facedetec1(prev).pose1=cellstr(char.empty(0,1));
           facedetec1(prev).familiar=cellstr(char.empty(0,1)); % fam abbreviated for familiar
           facedetec1(prev).ethnic=cellstr(char.empty(0,1)); % cau abbreviated for caucasian
         end
      end
      disp(facedetec1(num).regarding);
     disp(['Slider moved to ' newval]);
     disp(num);
     img=imread(facedetec1(num).image);
     bboxes=facedetec1(num).bboxes;
     [m,n]=size(bboxes);
     if m~=0
         disp(facedetec1(num).bboxes);
         ifaces=insertObjectAnnotation(img,'rectangle',bboxes,facedetec1(num).f,'Color',facedetec1(num).d,'FontSize',29);
         figure(1),imshow((ifaces)),title(['Image number is ', num2str(num) '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
     else
       figure(1),imshow(img),title(['Image number is ', num2str(num) '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
     end
   a=uicontrol('Style','slider','Callback',@display_slider_value,'Min',0,'Max',(p.total-1),'SliderStep',[(1/(total-1)) (10/(total-1))] );
   a.Position=[20 20 130 50];
   a.Value=num-1;
   f=uicontrol('Style','pushbutton','String','Select Correct Detections','Callback',@func1);
   f.Position=[210 20 80 50];
   g=uicontrol('Style','pushbutton','String','Add Faces','Callback',@func2);
   g.Position=[300 20 80 50];
   h=uicontrol('Style','pushbutton','String','Update','Callback',@func3);
   h.Position=[400 20 80 50];
   d=uicontrol('Style','pushbutton','String','Restore','Callback',{@restore});
   d.Position=[500 20 80 50];
   u=uicontrol('Style','pushbutton','String','Delete','Callback',{@delete});
   u.Position=[600 20 80 50];
   u.Visible='on';
   v=uicontrol('Style','pushbutton','String','Gender','Callback',@gender);
   v.Position=[700 20 80 50];
   z=uicontrol('Style','pushbutton','String','Pose','Callback',@pose);
   z.Position=[800 20 80 50];
   e=uicontrol('Style','pushbutton','String','Familairity','Callback',{@familiar});
   e.Position=[900 20 80 50];
   e1=uicontrol('Style','pushbutton','String','Ethnicity','Callback',{@ethnic});
   e1.Position=[1000 20 80 50];
   e2=uicontrol('Style','pushbutton','String','Save','Callback',{@save1});
   e2.Position=[1100 20 80 50];
   e3=uicontrol('Style','pushbutton','String','Disregard Size','Callback',@disregard);
   e3.Position=[1200 20 80 50];   
   e4=uicontrol('Style','edit','Callback',{@edit});
   e4.Position=[1200 600 80 50];
   e6=uicontrol('Style','pushbutton','String','AddLine','Callback',@lines);
   e6.Position=[1300 20 80 50];
   e5=uicontrol('Style','text','Position',[1200 650 60 25],'String','Enter Pg No.');
   
    e7=uicontrol('Style','edit','Callback',{@people});
    e7.Position=[1200 700 80 50];
    e8=uicontrol('Style','text','Position',[1200 750 60 25],'String','No. of people');
      
   prev=num;  
   disp(num);
   end



     function restore(hobject1,callbackdata1)
       facedetec1(num).bboxes = facedetec(num).bboxes;
       facedetec1(num).d=facedetec(num).d;
       facedetec1(num).f=facedetec(num).f;
       facedetec1(num).gender=facedetec(num).gender;
       facedetec1(num).ethnic=facedetec(num).ethnic;
       facedetec1(num).pose1=facedetec(num).pose1;
       facedetec1(num).familiar=facedetec(num).familiar;
       facedetec1(num).regarding=facedetec(num).regarding;
       img = imread(facedetec1(num).image);
       bboxes = facedetec1(num).bboxes;
       [m,n] = size(bboxes);
       if m~=0
         ifaces=insertObjectAnnotation(img,'rectangle',bboxes,facedetec1(num).f,'Color',facedetec1(num).d,'FontSize',29);
         figure(1);imshow((ifaces)),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
       else
         figure(1),imshow(img),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
       end
       a=uicontrol('Style','slider','Callback',@display_slider_value,'Min',0,'Max',(p.total-1),'SliderStep',[(1/(total-1)) (10/(total-1))] );
       a.Position=[20 20 130 50];
       a.Value=num-1;
       f=uicontrol('Style','pushbutton','String','Select Correct Detections','Callback',@func1);
       f.Position=[210 20 80 50];
       g=uicontrol('Style','pushbutton','String','Add Faces','Callback',@func2);
       g.Position=[300 20 80 50];
       h=uicontrol('Style','pushbutton','String','Update','Callback',@func3);
       h.Position=[400 20 80 50];
       d=uicontrol('Style','pushbutton','String','Restore','Callback',{@restore});
       d.Position=[500 20 80 50];
       u=uicontrol('Style','pushbutton','String','Delete','Callback',{@delete});
       u.Position=[600 20 80 50];
       u.Visible='on';
       v=uicontrol('Style','pushbutton','String','Gender','Callback',@gender);
       v.Position=[700 20 80 50];
       z=uicontrol('Style','pushbutton','String','Pose','Callback',@pose);
       z.Position=[800 20 80 50];
       e=uicontrol('Style','pushbutton','String','Familairity','Callback',{@familiar});
       e.Position=[900 20 80 50];
       e1=uicontrol('Style','pushbutton','String','Ethnicity','Callback',{@ethnic});
       e1.Position=[1000 20 80 50];
       e2=uicontrol('Style','pushbutton','String','Save','Callback',{@save1});
       e2.Position=[1100 20 80 50];
       e3=uicontrol('Style','pushbutton','String','Disregard Size','Callback',@disregard);
       e3.Position=[1200 20 80 50];
       e6=uicontrol('Style','pushbutton','String','AddLine','Callback',@lines);
       e6.Position=[1300 20 80 50];
       e4=uicontrol('Style','edit','Callback',{@edit});
       e4.Position=[1200 600 80 50];
       e5=uicontrol('Style','text','Position',[1200 650 60 25],'String','Enter Pg No.');
       disp(['prev value is ' prev]);
       prev=num;  
      disp(num);
 end
     function func1(hobject,callbackdata)  %function to select correct detections
         facedetec1(num).flag=1; 
         [x,y]=getpts;
         [m,n]=size(facedetec1(num).bboxes);
         index=0;
         flag=0;
         for row=1:m
            xbegin= facedetec1(num).bboxes(row,1);
            ybegin= facedetec1(num).bboxes(row,2);
            width = facedetec1(num).bboxes(row,3);
            xv=[xbegin xbegin (xbegin+width) (xbegin+width)];
            yv=[ybegin (ybegin+width) (ybegin+width) ybegin];
            in = inpolygon(x,y,xv,yv);
            f=any(in);
            if f==0
                flag=1;
                index=index+1;
                ind(index)=row;
            end
         end
        if flag==1
            disp(facedetec1(num).bboxes);
            [facedetec1(num).bboxes,ps]=removerows(facedetec1(num).bboxes,'ind',ind);
            [facedetec1(num).d,ps]=removerows(facedetec1(num).d,'ind',ind);
            [facedetec1(num).f,ps]=removerows(facedetec1(num).f,'ind',ind);
            [facedetec1(num).regarding,ps]=removerows(facedetec1(num).regarding,'ind',ind);
            disp(facedetec1(num).pose1);
            [facedetec1(num).pose1,ps]=removerows(facedetec1(num).pose1,'ind',ind);
            [facedetec1(num).familiar,ps]=removerows(facedetec1(num).familiar,'ind',ind);
            [facedetec1(num).ethnic,ps]=removerows(facedetec1(num).ethnic,'ind',ind);
            disp(' displaying bboxes after modification' );
            disp(facedetec1(num).bboxes);
            clear ind;
        end
    end
      function func2(hobject,callbackdata) %callback function for addition of face
         facedetec1(num).flag=1;
         [I,rect]=imcrop();
         facedetec1(num).bboxes=[facedetec1(num).bboxes;rect];
         disp('bboxes after addition are');
         disp(bboxes);
         [m,n]=size(facedetec1(num).bboxes);
         disp(num);
         disp(m);
         facedetec1(num).d(m,:)=cellstr('red');
         pq=num2str(facedetec1(num).bboxes(m,3));
         facedetec1(num).regarding(m,1)=1;
         facedetec1(num).gender(m,:)=cellstr('f');
         facedetec1(num).pose1(m,:)=cellstr('fr');
         facedetec1(num).familiar(m,:)=cellstr('fam');
         facedetec1(num).ethnic(m,:)=cellstr('cau');
         conv=char(facedetec1(num).pose1(m,:));
         conv1=char(facedetec1(num).familiar(m,:));
         conv2=char(facedetec1(num).ethnic(m,:));
         facedetec1(num).f(m,:)=cellstr(char(strcat(pq,' ,',conv,' ,',conv1,',',conv2)));
         img = imread(facedetec1(num).image);
        bboxes=facedetec1(num).bboxes;
        disp('After updating bboxes');
         disp(bboxes);
        [m,n]=size(bboxes);
        if m~=0
          ifaces=insertObjectAnnotation(img,'rectangle',bboxes,facedetec1(num).f,'Color',facedetec1(num).d,'FontSize',29);
          figure(1),imshow((ifaces)),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
        else
          figure(1),imshow(img),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
       end         
    end
    function func3(hobject,callbackdata)   % %function for updation 
       if facedetec1(num).flag == 0
          facedetec1(num).bboxes= double.empty(0,4);
          facedetec1(num).d=cellstr(char.empty(0,4));
          facedetec1(num).f=cellstr(char.empty(0,1));
           facedetec1(num).gender= cellstr(char.empty(0,1));
           facedetec1(num).pose1=cellstr(char.empty(0,1));
           facedetec1(num).familiar=cellstr(char.empty(0,1)); 
           facedetec1(num).ethnic=cellstr(char.empty(0,1)); 
           facedetec1(num).regarding=uint8.empty(0,1);
       end
       img = imread(facedetec1(num).image);
       bboxes=facedetec1(num).bboxes;
       disp('After updating bboxes');
       disp(bboxes);
       [m,n]=size(bboxes);
       if m~=0
         ifaces=insertObjectAnnotation(img,'rectangle',bboxes,facedetec1(num).f,'Color',facedetec1(num).d,'FontSize',29);
         figure(1),imshow((ifaces)),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
       else
         figure(1),imshow(img),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
       end
   a=uicontrol('Style','slider','Callback',@display_slider_value,'Min',0,'Max',(p.total-1),'SliderStep',[(1/(total-1)) (10/(total-1))] );
   a.Position=[20 20 130 50];
   a.Value=num-1;
   f=uicontrol('Style','pushbutton','String','Select Correct Detections','Callback',@func1);
   f.Position=[210 20 80 50];
   g=uicontrol('Style','pushbutton','String','Add Faces','Callback',@func2);
   g.Position=[300 20 80 50];
   h=uicontrol('Style','pushbutton','String','Update','Callback',@func3);
   h.Position=[400 20 80 50];
   d=uicontrol('Style','pushbutton','String','Restore','Callback',{@restore});
   d.Position=[500 20 80 50];
   u=uicontrol('Style','pushbutton','String','Delete','Callback',{@delete});
   u.Position=[600 20 80 50];
   u.Visible='on';
   v=uicontrol('Style','pushbutton','String','Gender','Callback',@gender);
   v.Position=[700 20 80 50];
   z=uicontrol('Style','pushbutton','String','Pose','Callback',@pose);
   z.Position=[800 20 80 50];
   e=uicontrol('Style','pushbutton','String','Familairity','Callback',{@familiar});
   e.Position=[900 20 80 50];
   e1=uicontrol('Style','pushbutton','String','Ethnicity','Callback',{@ethnic});
   e1.Position=[1000 20 80 50];
   e2=uicontrol('Style','pushbutton','String','Save','Callback',{@save1});
   e2.Position=[1100 20 80 50];
   e3=uicontrol('Style','pushbutton','String','Disregard Size','Callback',@disregard);
   e3.Position=[1200 20 80 50];
   e6=uicontrol('Style','pushbutton','String','AddLine','Callback',@lines);
   e6.Position=[1300 20 80 50];
   e4=uicontrol('Style','edit','Callback',{@edit});
   e4.Position=[1200 600 80 50];
   e5=uicontrol('Style','text','Position',[1200 650 60 25],'String','Enter Pg No.');
   disp(['prev value is ' prev]);
   prev=num;  
   disp(num);

    end

    function delete(hobject,callbackdata)
       [x,y]=ginput(1);
       facedetec1(num).flag=1;
       [m,n]=size(facedetec1(num).bboxes);
       disp(['value of m is' num2str(m)]);
       disp(['value of n is' num2str(n)]);
       index=0,flag=0;
       for row=1:m
           xbegin=facedetec1(num).bboxes(row,1);
           ybegin=facedetec1(num).bboxes(row,2);
           width=facedetec1(num).bboxes(row,3);
           xv=[xbegin xbegin (xbegin+width) (xbegin+width)];
           yv=[ybegin (ybegin+width) (ybegin+width) ybegin];
           in =inpolygon(x,y,xv,yv);
           f=any(in);
           if f==1
               flag=1;
               rowdel=row;
               break
           end
       end
       if flag==1
           disp(facedetec1(num).bboxes);
           disp(num);
           disp(facedetec1(num).regarding);
           disp('I am here');
           [facedetec1(num).bboxes,ps]=removerows(facedetec1(num).bboxes,rowdel);
           disp(facedetec1(num).d);
           [facedetec1(num).d,ps]=removerows(facedetec1(num).d,rowdel);
           [facedetec1(num).regarding,ps]=removerows(facedetec1(num).regarding,rowdel);
           [facedetec1(num).f,ps]=removerows(facedetec1(num).f,rowdel);
           [facedetec1(num).gender,ps]=removerows(facedetec1(num).gender,rowdel);
           [facedetec1(num).pose1,ps]=removerows(facedetec1(num).pose1,rowdel);
           [facedetec1(num).familiar,ps]=removerows(facedetec1(num).familiar,rowdel);
           [facedetec1(num).ethnic,ps]=removerows(facedetec1(num).ethnic,rowdel);
           disp(facedetec1(num).bboxes);
           img=imread(facedetec1(num).image);
           bboxes=facedetec1(num).bboxes;
           [m,n]=size(bboxes); 
           if m~=0
             ifaces=insertObjectAnnotation(img,'rectangle',bboxes,facedetec1(num).f,'Color',facedetec1(num).d,'FontSize',29);
             figure(1),imshow((ifaces)),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
           else
             figure(1),imshow(img),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
           end
   a=uicontrol('Style','slider','Callback',@display_slider_value,'Min',0,'Max',(p.total-1),'SliderStep',[(1/(total-1)) (10/(total-1))] );
   a.Position=[20 20 130 50];
   a.Value=num-1;
   f=uicontrol('Style','pushbutton','String','Select Correct Detections','Callback',@func1);
   f.Position=[210 20 80 50];
   g=uicontrol('Style','pushbutton','String','Add Faces','Callback',@func2);
   g.Position=[300 20 80 50];
   h=uicontrol('Style','pushbutton','String','Update','Callback',@func3);
   h.Position=[400 20 80 50];
   d=uicontrol('Style','pushbutton','String','Restore','Callback',{@restore});
   d.Position=[500 20 80 50];
   u=uicontrol('Style','pushbutton','String','Delete','Callback',{@delete});
   u.Position=[600 20 80 50];
   u.Visible='on';
   v=uicontrol('Style','pushbutton','String','Gender','Callback',@gender);
   v.Position=[700 20 80 50];
   z=uicontrol('Style','pushbutton','String','Pose','Callback',@pose);
   z.Position=[800 20 80 50];
   e=uicontrol('Style','pushbutton','String','Familairity','Callback',{@familiar});
   e.Position=[900 20 80 50];
   e1=uicontrol('Style','pushbutton','String','Ethnicity','Callback',{@ethnic});
   e1.Position=[1000 20 80 50];
   e2=uicontrol('Style','pushbutton','String','Save','Callback',{@save1});
   e2.Position=[1100 20 80 50];
   e3=uicontrol('Style','pushbutton','String','Disregard Size','Callback',@disregard);
   e3.Position=[1200 20 80 50];   
   e4=uicontrol('Style','edit','Callback',{@edit});
   e4.Position=[1200 600 80 50];
   e6=uicontrol('Style','pushbutton','String','AddLine','Callback',@lines);
   e6.Position=[1300 20 80 50];
   e5=uicontrol('Style','text','Position',[1200 650 60 25],'String','Enter Pg No.');
   disp(['prev value is ' prev]);
   prev=num;  
   disp(num);

      
        end
    end
    function disregard(hobject,callbackdata)
       [x,y]= getpts;
       [m,n] = size(facedetec1(num).bboxes);
       for row=1:m
            xbegin = facedetec1(num).bboxes(row,1);
            ybegin = facedetec1(num).bboxes(row,2);
            width =  facedetec1(num).bboxes(row,3);
            height = facedetec1(num).bboxes(row,4);
            xv=[xbegin xbegin (xbegin+width) (xbegin+width)];
            yv=[ybegin (ybegin+height) (ybegin+height) ybegin];
            in=inpolygon(x,y,xv,yv);
            f=any(in);
            if f==1    
                conv=char(facedetec1(num).pose1(row,:));
                conv1=char(facedetec1(num).familiar(row,:));
                conv2=char(facedetec1(num).ethnic(row,:));
               if facedetec1(num).regarding(row,1)==1
                   facedetec1(num).regarding(row,1)=0;
                   pq=char(strcat(conv,' ,',conv1,',',conv2));
               else
                    facedetec1(num).regarding(row,1)=1;
                   pq= num2str(facedetec1(num).bboxes(row,3));
                   pq=char(strcat(pq,' ,',conv,' ,',conv1,',',conv2));                    
                   
               end
              facedetec1(num).f(row,:)=cellstr(pq);
            end
       end
       img=imread(facedetec1(num).image);
       bboxes=facedetec1(num).bboxes;
       if m~=0
         ifaces=insertObjectAnnotation(img,'rectangle',bboxes,facedetec1(num).f,'Color',facedetec1(num).d,'FontSize',29);
         figure(1),imshow((ifaces)),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
       else
         figure(1),imshow(img),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
       end
   a=uicontrol('Style','slider','Callback',@display_slider_value,'Min',0,'Max',(p.total-1),'SliderStep',[(1/(total-1)) (10/(total-1))] );
   a.Position=[20 20 130 50];
   a.Value=num-1;
   f=uicontrol('Style','pushbutton','String','Select Correct Detections','Callback',@func1);
   f.Position=[210 20 80 50];
   g=uicontrol('Style','pushbutton','String','Add Faces','Callback',@func2);
   g.Position=[300 20 80 50];
   h=uicontrol('Style','pushbutton','String','Update','Callback',@func3);
   h.Position=[400 20 80 50];
   d=uicontrol('Style','pushbutton','String','Restore','Callback',{@restore});
   d.Position=[500 20 80 50];
   u=uicontrol('Style','pushbutton','String','Delete','Callback',{@delete});
   u.Position=[600 20 80 50];
   u.Visible='on';
   v=uicontrol('Style','pushbutton','String','Gender','Callback',@gender);
   v.Position=[700 20 80 50];
   z=uicontrol('Style','pushbutton','String','Pose','Callback',@pose);
   z.Position=[800 20 80 50];
   e=uicontrol('Style','pushbutton','String','Familairity','Callback',{@familiar});
   e.Position=[900 20 80 50];
   e1=uicontrol('Style','pushbutton','String','Ethnicity','Callback',{@ethnic});
   e1.Position=[1000 20 80 50];
   e2=uicontrol('Style','pushbutton','String','Save','Callback',{@save1});
   e2.Position=[1100 20 80 50];   
   e3=uicontrol('Style','pushbutton','String','Disregard Size','Callback',@disregard);
   e3.Position=[1200 20 80 50];
   e6=uicontrol('Style','pushbutton','String','AddLine','Callback',@lines);
   e6.Position=[1300 20 80 50];
   e4=uicontrol('Style','edit','Callback',{@edit});
   e4.Position=[1200 600 80 50];
   e5=uicontrol('Style','text','Position',[1200 650 60 25],'String','Enter Pg No.');
   disp(['prev value is ' prev]);
   prev=num;  
   disp(num);
 
    end
       
                
    function gender(hobject,callbackdata)
       [x,y]= getpts;
       [m,n] = size(facedetec1(num).bboxes);
       for row=1:m
            xbegin = facedetec1(num).bboxes(row,1);
            ybegin = facedetec1(num).bboxes(row,2);
            width =  facedetec1(num).bboxes(row,3);
            height = facedetec1(num).bboxes(row,4);
            xv=[xbegin xbegin (xbegin+width) (xbegin+width)];
            yv=[ybegin (ybegin+height) (ybegin+height) ybegin];
            in=inpolygon(x,y,xv,yv);
            f=any(in);
            disp(row);
                 disp(facedetec1(num).gender);
            if f==1
                if strcmp(facedetec1(num).gender(row,:),cellstr('f'))== 1
                    facedetec1(num).d(row,:)=cellstr('blue');
                    facedetec1(num).gender(row,:)=cellstr('m');
                else
                  facedetec1(num).d(row,:)=cellstr('red');
                  facedetec1(num).gender(row,:)=cellstr('f');
                end
            end
            
       end
       img=imread(facedetec1(num).image);
       bboxes=facedetec1(num).bboxes;
       if m~=0
         ifaces=insertObjectAnnotation(img,'rectangle',bboxes,facedetec1(num).f,'Color',facedetec1(num).d,'FontSize',29);
         figure(1),imshow((ifaces)),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
       else
         figure(1),imshow(img),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
       end
   a=uicontrol('Style','slider','Callback',@display_slider_value,'Min',0,'Max',(p.total-1),'SliderStep',[(1/(total-1)) (10/(total-1))] );
   a.Position=[20 20 130 50];
   a.Value=num-1;
   f=uicontrol('Style','pushbutton','String','Select Correct Detections','Callback',@func1);
   f.Position=[210 20 80 50];
   g=uicontrol('Style','pushbutton','String','Add Faces','Callback',@func2);
   g.Position=[300 20 80 50];
   h=uicontrol('Style','pushbutton','String','Update','Callback',@func3);
   h.Position=[400 20 80 50];
   d=uicontrol('Style','pushbutton','String','Restore','Callback',{@restore});
   d.Position=[500 20 80 50];
   u=uicontrol('Style','pushbutton','String','Delete','Callback',{@delete});
   u.Position=[600 20 80 50];
   u.Visible='on';
   v=uicontrol('Style','pushbutton','String','Gender','Callback',@gender);
   v.Position=[700 20 80 50];
   z=uicontrol('Style','pushbutton','String','Pose','Callback',@pose);
   z.Position=[800 20 80 50];
   e=uicontrol('Style','pushbutton','String','Familairity','Callback',{@familiar});
   e.Position=[900 20 80 50];
   e1=uicontrol('Style','pushbutton','String','Ethnicity','Callback',{@ethnic});
   e1.Position=[1000 20 80 50];
   e2=uicontrol('Style','pushbutton','String','Save','Callback',{@save1});
   e2.Position=[1100 20 80 50];   
   e3=uicontrol('Style','pushbutton','String','Disregard Size','Callback',@disregard);
   e3.Position=[1200 20 80 50];
   e6=uicontrol('Style','pushbutton','String','AddLine','Callback',@lines);
   e6.Position=[1300 20 80 50];
   e4=uicontrol('Style','edit','Callback',{@edit});
   e4.Position=[1200 600 80 50];
   e5=uicontrol('Style','text','Position',[1200 650 60 25],'String','Enter Pg No.');
   disp(['prev value is ' prev]);
   prev=num;  
   disp(num);
 
    end
    function pose(hobject,callbackdata)
        [x,y]=getpts;
        [m,n]=size(facedetec1(num).bboxes);
        for row=1:m
            xbegin=facedetec1(num).bboxes(row,1);
            ybegin=facedetec1(num).bboxes(row,2);
            width=facedetec1(num).bboxes(row,3);
            height=facedetec1(num).bboxes(row,4);
            xv=[xbegin xbegin (xbegin+width) (xbegin+width)];
            yv=[ybegin (ybegin+height) (ybegin+height) ybegin];
            in = inpolygon(x,y,xv,yv);
            f=any(in);
            if f==1
                 disp(row);
                 disp(facedetec1(num).pose1);
                if strcmp(facedetec1(num).pose1(row,:),cellstr('fr'))== 1
                    facedetec1(num).pose1(row,:)=cellstr('3/4');
                    conv=char(facedetec1(num).pose1(row,:));
                    conv1=char(facedetec1(num).familiar(row,:));
                    conv2=char(facedetec1(num).ethnic(row,:));
                    if facedetec1(num).regarding(row,1)==1
                       pq= num2str(facedetec1(num).bboxes(row,3));
                       pq=char(strcat(pq,' ,',conv,' ,',conv1,',',conv2));
                    else
                       pq=char(strcat(conv,' ,',conv1,',',conv2));    
                    end
                    facedetec1(num).f(row,:)=cellstr(pq);
                elseif strcmp(facedetec1(num).pose1(row,:),cellstr('3/4'))== 1
                     facedetec1(num).pose1(row,:)=cellstr('pr');
                     conv=char(facedetec1(num).pose1(row,:));
                     conv1=char(facedetec1(num).familiar(row,:));
                     conv2=char(facedetec1(num).ethnic(row,:));
                     if facedetec1(num).regarding(row,1)==1
                        pq= num2str(facedetec1(num).bboxes(row,3));
                        pq=char(strcat(pq,' ,',conv,' ,',conv1,',',conv2));
                    else
                       pq=char(strcat(conv,' ,',conv1,',',conv2));    
                    end                     
                     facedetec1(num).f(row,:)=cellstr(pq);
                elseif strcmp(facedetec1(num).pose1(row,:),cellstr('pr'))== 1
                     facedetec1(num).pose1(row,:)=cellstr('Call');
                     conv=char(facedetec1(num).pose1(row,:));
                     conv1=char(facedetec1(num).familiar(row,:));
                     conv2=char(facedetec1(num).ethnic(row,:));
                    if facedetec1(num).regarding(row,1)==1
                       pq= num2str(facedetec1(num).bboxes(row,3));
                       pq=char(strcat(pq,' ,',conv,' ,',conv1,',',conv2));
                    else
                       pq=char(strcat(conv,' ,',conv1,',',conv2));    
                    end
                     facedetec1(num).f(row,:)=cellstr(pq);                     
                else
                      facedetec1(num).pose1(row,:)=cellstr('fr');
                      conv=char(facedetec1(num).pose1(row,:));
                      conv1=char(facedetec1(num).familiar(row,:));
                      conv2=char(facedetec1(num).ethnic(row,:));
                       if facedetec1(num).regarding(row,1)==1
                          pq= num2str(facedetec1(num).bboxes(row,3));
                          pq=char(strcat(pq,' ,',conv,' ,',conv1,',',conv2));
                       else
                          pq=char(strcat(conv,' ,',conv1,',',conv2));    
                       end
                       facedetec1(num).f(row,:)=cellstr(pq);
                 end
            end
        end
       img=imread(facedetec1(num).image);
       bboxes=facedetec1(num).bboxes;
       if m~=0
         ifaces=insertObjectAnnotation(img,'rectangle',bboxes,facedetec1(num).f,'Color',facedetec1(num).d,'FontSize',29);
         figure(1),imshow((ifaces)),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
       else
         figure(1),imshow(img),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
       end
   a=uicontrol('Style','slider','Callback',@display_slider_value,'Min',0,'Max',(p.total-1),'SliderStep',[(1/(total-1)) (10/(total-1))] );
   a.Position=[20 20 130 50];
   a.Value=num-1;
   f=uicontrol('Style','pushbutton','String','Select Correct Detections','Callback',@func1);
   f.Position=[210 20 80 50];
   g=uicontrol('Style','pushbutton','String','Add Faces','Callback',@func2);
   g.Position=[300 20 80 50];
   h=uicontrol('Style','pushbutton','String','Update','Callback',@func3);
   h.Position=[400 20 80 50];
   d=uicontrol('Style','pushbutton','String','Restore','Callback',{@restore});
   d.Position=[500 20 80 50];
   u=uicontrol('Style','pushbutton','String','Delete','Callback',{@delete});
   u.Position=[600 20 80 50];
   u.Visible='on';
   v=uicontrol('Style','pushbutton','String','Gender','Callback',@gender);
   v.Position=[700 20 80 50];
   z=uicontrol('Style','pushbutton','String','Pose','Callback',@pose);
   z.Position=[800 20 80 50];
   e=uicontrol('Style','pushbutton','String','Familairity','Callback',{@familiar});
   e.Position=[900 20 80 50];
   e1=uicontrol('Style','pushbutton','String','Ethnicity','Callback',{@ethnic});
   e1.Position=[1000 20 80 50];
   e2=uicontrol('Style','pushbutton','String','Save','Callback',{@save1});
   e2.Position=[1100 20 80 50];
   e3=uicontrol('Style','pushbutton','String','Disregard Size','Callback',@disregard);
   e3.Position=[1200 20 80 50];
   e6=uicontrol('Style','pushbutton','String','AddLine','Callback',@lines);
   e6.Position=[1300 20 80 50];
   e4=uicontrol('Style','edit','Callback',{@edit});
   e4.Position=[1200 600 80 50];
   e5=uicontrol('Style','text','Position',[1200 650 60 25],'String','Enter Pg No.');
   disp(['prev value is ' prev]);
   prev=num;  
   disp(num);
 
    end
    function familiar(hobject,callbackdata)
     [x,y]=getpts;
        [m,n]=size(facedetec1(num).bboxes);
        for row=1:m
            xbegin=facedetec1(num).bboxes(row,1);
            ybegin=facedetec1(num).bboxes(row,2);
            width=facedetec1(num).bboxes(row,3);
            height=facedetec1(num).bboxes(row,4);
            xv=[xbegin xbegin (xbegin+width) (xbegin+width)];
            yv=[ybegin (ybegin+height) (ybegin+height) ybegin];
            in = inpolygon(x,y,xv,yv);
            f=any(in);
            if f==1
                if strcmp(facedetec1(num).familiar(row,:),cellstr('fam'))== 1
                    facedetec1(num).familiar(row,:)=cellstr('str');
                    conv=char(facedetec1(num).pose1(row,:));
                    conv1=char(facedetec1(num).familiar(row,:));
                    conv2=char(facedetec1(num).ethnic(row,:));
                    if facedetec1(num).regarding(row,1)==1
                       pq= num2str(facedetec1(num).bboxes(row,3));
                       pq=char(strcat(pq,' ,',conv,' ,',conv1,',',conv2));
                    else
                       pq=char(strcat(conv,' ,',conv1,',',conv2));    
                    end
                    facedetec1(num).f(row,:)=cellstr(pq);
                elseif strcmp(facedetec1(num).familiar(row,:),cellstr('str'))== 1
                    facedetec1(num).familiar(row,:)=cellstr('CAll');
                    conv=char(facedetec1(num).pose1(row,:));
                    conv1=char(facedetec1(num).familiar(row,:));
                    conv2=char(facedetec1(num).ethnic(row,:));
                    if facedetec1(num).regarding(row,1)==1
                       pq= num2str(facedetec1(num).bboxes(row,3));
                       pq=char(strcat(pq,' ,',conv,' ,',conv1,',',conv2));
                    else
                       pq=char(strcat(conv,' ,',conv1,',',conv2));    
                    end
                    facedetec1(num).f(row,:)=cellstr(pq);
                else
                      facedetec1(num).familiar(row,:)=cellstr('fam');
                      conv=char(facedetec1(num).pose1(row,:));
                      conv1=char(facedetec1(num).familiar(row,:));
                      conv2=char(facedetec1(num).ethnic(row,:));
                     if facedetec1(num).regarding(row,1)==1
                         pq= num2str(facedetec1(num).bboxes(row,3));
                         pq=char(strcat(pq,' ,',conv,' ,',conv1,',',conv2));
                     else
                         pq=char(strcat(conv,' ,',conv1,',',conv2));    
                     end
                     facedetec1(num).f(row,:)=cellstr(pq);
                 end
            end
        end
       img=imread(facedetec1(num).image);
       bboxes=facedetec1(num).bboxes;
       if m~=0
         ifaces=insertObjectAnnotation(img,'rectangle',bboxes,facedetec1(num).f,'Color',facedetec1(num).d,'FontSize',29);
        figure(1),imshow((ifaces)),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
       else
          figure(1),imshow(img),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
       end
   a=uicontrol('Style','slider','Callback',@display_slider_value,'Min',0,'Max',(p.total-1),'SliderStep',[(1/(total-1)) (10/(total-1))] );
   a.Position=[20 20 130 50];
   a.Value=num-1;
   f=uicontrol('Style','pushbutton','String','Select Correct Detections','Callback',@func1);
   f.Position=[210 20 80 50];
   g=uicontrol('Style','pushbutton','String','Add Faces','Callback',@func2);
   g.Position=[300 20 80 50];
   h=uicontrol('Style','pushbutton','String','Update','Callback',@func3);
   h.Position=[400 20 80 50];
   d=uicontrol('Style','pushbutton','String','Restore','Callback',{@restore});
   d.Position=[500 20 80 50];
   u=uicontrol('Style','pushbutton','String','Delete','Callback',{@delete});
   u.Position=[600 20 80 50];
   u.Visible='on';
   v=uicontrol('Style','pushbutton','String','Gender','Callback',@gender);
   v.Position=[700 20 80 50];
   z=uicontrol('Style','pushbutton','String','Pose','Callback',@pose);
   z.Position=[800 20 80 50];
   e=uicontrol('Style','pushbutton','String','Familairity','Callback',{@familiar});
   e.Position=[900 20 80 50];
   e1=uicontrol('Style','pushbutton','String','Ethnicity','Callback',{@ethnic});
   e1.Position=[1000 20 80 50];
   e2=uicontrol('Style','pushbutton','String','Save','Callback',{@save1});
   e2.Position=[1100 20 80 50];
   e3=uicontrol('Style','pushbutton','String','Disregard Size','Callback',@disregard);
   e3.Position=[1200 20 80 50];
   e6=uicontrol('Style','pushbutton','String','AddLine','Callback',@lines);
   e6.Position=[1300 20 80 50];
   e4=uicontrol('Style','edit','Callback',{@edit});
   e4.Position=[1200 600 80 50];
   e5=uicontrol('Style','text','Position',[1200 650 60 25],'String','Enter Pg No.');
   disp(['prev value is ' prev]);
   prev=num;  
   disp(num);
   
    end   
        function lines(hobject,callbackdata)
         a1= getline
         [a1(1,:) a1(2,:)]
         line(a1(:,1), a1(:,2))
        [m,n] = size(facedetec1(num).bboxes);
        for row=1:m
            xbegin=facedetec1(num).bboxes(row,1);
            ybegin=facedetec1(num).bboxes(row,2);
            width=facedetec1(num).bboxes(row,3);
            height=facedetec1(num).bboxes(row,4);
            xv=[xbegin xbegin (xbegin+width) (xbegin+width)];
            yv=[ybegin (ybegin+height) (ybegin+height) ybegin];
            in = inpolygon(a1(:,1),a1(:,2),xv,yv);
            f=any(in);
            if f==1 
                segments(num).line(row,:)=[a1(1,:) a1(2,:)];
            end
        end
   a=uicontrol('Style','slider','Callback',@display_slider_value,'Min',0,'Max',(p.total-1),'SliderStep',[(1/(total-1)) (10/(total-1))] );
   a.Position=[20 20 130 50];
   a.Value=num-1;
   f=uicontrol('Style','pushbutton','String','Select Correct Detections','Callback',@func1);
   f.Position=[210 20 80 50];
   g=uicontrol('Style','pushbutton','String','Add Faces','Callback',@func2);
   g.Position=[300 20 80 50];
   h=uicontrol('Style','pushbutton','String','Update','Callback',@func3);
   h.Position=[400 20 80 50];
   d=uicontrol('Style','pushbutton','String','Restore','Callback',{@restore});
   d.Position=[500 20 80 50];
   u=uicontrol('Style','pushbutton','String','Delete','Callback',{@delete});
   u.Position=[600 20 80 50];
   u.Visible='on';
   v=uicontrol('Style','pushbutton','String','Gender','Callback',@gender);
   v.Position=[700 20 80 50];
   z=uicontrol('Style','pushbutton','String','Pose','Callback',@pose);
   z.Position=[800 20 80 50];
   e=uicontrol('Style','pushbutton','String','Familairity','Callback',{@familiar});
   e.Position=[900 20 80 50];
   e1=uicontrol('Style','pushbutton','String','Ethnicity','Callback',{@ethnic});
   e1.Position=[1000 20 80 50];
   e2=uicontrol('Style','pushbutton','String','Save','Callback',{@save1});
   e2.Position=[1100 20 80 50];
   e3=uicontrol('Style','pushbutton','String','Disregard Size','Callback',@disregard);
   e3.Position=[1200 20 80 50];
   e6=uicontrol('Style','pushbutton','String','AddLine','Callback',@lines);
   e6.Position=[1300 20 80 50];
   e4=uicontrol('Style','edit','Callback',{@edit});
   e4.Position=[1200 600 80 50];
   e5=uicontrol('Style','text','Position',[1200 650 60 25],'String','Enter Pg No.');
   disp(['prev value is ' prev]);
   prev=num;  
   disp(num);
 
    end 
            
     function ethnic(hobject,callbackdata)
     [x,y]=getpts;
        [m,n] = size(facedetec1(num).bboxes);
        for row=1:m
            xbegin=facedetec1(num).bboxes(row,1);
            ybegin=facedetec1(num).bboxes(row,2);
            width=facedetec1(num).bboxes(row,3);
            height=facedetec1(num).bboxes(row,4);
            xv=[xbegin xbegin (xbegin+width) (xbegin+width)];
            yv=[ybegin (ybegin+height) (ybegin+height) ybegin];
            in = inpolygon(x,y,xv,yv);
            f=any(in);
            if f==1
                if strcmp(facedetec1(num).ethnic(row,:),cellstr('cau'))== 1
                    facedetec1(num).ethnic(row,:)=cellstr('easia');
                    conv=char(facedetec1(num).pose1(row,:));
                    conv1=char(facedetec1(num).familiar(row,:));
                    conv2=char(facedetec1(num).ethnic(row,:));
                    if facedetec1(num).regarding(row,1)==1
                       pq= num2str(facedetec1(num).bboxes(row,3));
                       pq=char(strcat(pq,' ,',conv,' ,',conv1,',',conv2));
                    else
                       pq=char(strcat(conv,' ,',conv1,',',conv2));    
                    end
                    facedetec1(num).f(row,:)=cellstr(pq);

                elseif strcmp(facedetec1(num).ethnic(row,:),cellstr('easia'))== 1
                    facedetec1(num).ethnic(row,:)=cellstr('afr');
                    conv=char(facedetec1(num).pose1(row,:));
                    conv1=char(facedetec1(num).familiar(row,:));
                    conv2=char(facedetec1(num).ethnic(row,:));
                    if facedetec1(num).regarding(row,1)==1
                       pq= num2str(facedetec1(num).bboxes(row,3));
                       pq=char(strcat(pq,' ,',conv,' ,',conv1,',',conv2));
                    else
                       pq=char(strcat(conv,' ,',conv1,',',conv2));    
                    end
                    facedetec1(num).f(row,:)=cellstr(pq);     
                elseif strcmp(facedetec1(num).ethnic(row,:),cellstr('afr'))== 1
                    facedetec1(num).ethnic(row,:)=cellstr('Call');
                    conv=char(facedetec1(num).pose1(row,:));
                    conv1=char(facedetec1(num).familiar(row,:));
                    conv2=char(facedetec1(num).ethnic(row,:));
                    if facedetec1(num).regarding(row,1)==1
                       pq= num2str(facedetec1(num).bboxes(row,3));
                       pq=char(strcat(pq,' ,',conv,' ,',conv1,',',conv2));
                    else
                       pq=char(strcat(conv,' ,',conv1,',',conv2));    
                    end
                    facedetec1(num).f(row,:)=cellstr(pq);                    
                    
                else
                      facedetec1(num).ethnic(row,:)=cellstr('cau');
                      conv=char(facedetec1(num).pose1(row,:));
                      conv1=char(facedetec1(num).familiar(row,:));
                      conv2=char(facedetec1(num).ethnic(row,:));
                    if facedetec1(num).regarding(row,1)==1
                       pq= num2str(facedetec1(num).bboxes(row,3));
                       pq=char(strcat(pq,' ,',conv,' ,',conv1,',',conv2));
                    else
                       pq=char(strcat(conv,' ,',conv1,',',conv2));    
                    end
                    facedetec1(num).f(row,:)=cellstr(pq);
                 end
            end
        end
       img=imread(facedetec1(num).image);
       bboxes=facedetec1(num).bboxes;
       if m~=0
         ifaces=insertObjectAnnotation(img,'rectangle',bboxes,facedetec1(num).f,'Color',facedetec1(num).d,'FontSize',29);
         figure(1),imshow((ifaces)),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
       else
          figure(1),imshow(img),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
       end
   a=uicontrol('Style','slider','Callback',@display_slider_value,'Min',0,'Max',(p.total-1),'SliderStep',[(1/(total-1)) (10/(total-1))] );
   a.Position=[20 20 130 50];
   a.Value=num-1;
   f=uicontrol('Style','pushbutton','String','Select Correct Detections','Callback',@func1);
   f.Position=[210 20 80 50];
   g=uicontrol('Style','pushbutton','String','Add Faces','Callback',@func2);
   g.Position=[300 20 80 50];
   h=uicontrol('Style','pushbutton','String','Update','Callback',@func3);
   h.Position=[400 20 80 50];
   d=uicontrol('Style','pushbutton','String','Restore','Callback',{@restore});
   d.Position=[500 20 80 50];
   u=uicontrol('Style','pushbutton','String','Delete','Callback',{@delete});
   u.Position=[600 20 80 50];
   u.Visible='on';
   v=uicontrol('Style','pushbutton','String','Gender','Callback',@gender);
   v.Position=[700 20 80 50];
   z=uicontrol('Style','pushbutton','String','Pose','Callback',@pose);
   z.Position=[800 20 80 50];
   e=uicontrol('Style','pushbutton','String','Familairity','Callback',{@familiar});
   e.Position=[900 20 80 50];
   e1=uicontrol('Style','pushbutton','String','Ethnicity','Callback',{@ethnic});
   e1.Position=[1000 20 80 50];
   e2=uicontrol('Style','pushbutton','String','Save','Callback',{@save1});
   e2.Position=[1100 20 80 50];
   e3=uicontrol('Style','pushbutton','String','Disregard Size','Callback',@disregard);
   e3.Position=[1200 20 80 50];
   e6=uicontrol('Style','pushbutton','String','AddLine','Callback',@lines);
   e6.Position=[1300 20 80 50];
   e4=uicontrol('Style','edit','Callback',{@edit});
   e4.Position=[1200 600 80 50];
   e5=uicontrol('Style','text','Position',[1200 650 60 25],'String','Enter Pg No.');
   disp(['prev value is ' prev]);
   prev=num;  
   disp(num);
 
    end 
    function save1(hobject,callbackdata)
        analyzed=1;
        filestr=strcat(newmap,'.mat');
        disp(filestr);
        save(filestr,'facedetec1','facedetec','total','analyzed','segments');
        
    end
    function edit(hobject,callbackdata)
         entered=hobject.String ;
         entered=str2double(entered);
         disp(num);
         num=entered;
         img=imread(facedetec1(num).image);
         bboxes=facedetec1(num).bboxes;
         [m,n]=size(bboxes);
        if m~=0
         ifaces=insertObjectAnnotation(img,'rectangle',bboxes,facedetec1(num).f,'Color',facedetec1(num).d,'FontSize',29);
         figure(1),imshow((ifaces)),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
        else
         figure(1),imshow(img),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
        end
        a=uicontrol('Style','slider','Callback',@display_slider_value,'Min',0,'Max',(p.total-1),'SliderStep',[(1/(total-1)) (10/(total-1))] );
        a.Position=[20 20 130 50];
        a.Value=num-1;
        f=uicontrol('Style','pushbutton','String','Select Correct Detections','Callback',@func1);
        f.Position=[210 20 80 50];
        g=uicontrol('Style','pushbutton','String','Add Faces','Callback',@func2);
        g.Position=[300 20 80 50];
        h=uicontrol('Style','pushbutton','String','Update','Callback',@func3);
        h.Position=[400 20 80 50];
        d=uicontrol('Style','pushbutton','String','Restore','Callback',{@restore});
        d.Position=[500 20 80 50];
        u=uicontrol('Style','pushbutton','String','Delete','Callback',{@delete});
        u.Position=[600 20 80 50];
        u.Visible='on';
        v=uicontrol('Style','pushbutton','String','Gender','Callback',@gender);
        v.Position=[700 20 80 50];
        z=uicontrol('Style','pushbutton','String','Pose','Callback',@pose);
        z.Position=[800 20 80 50];
        e=uicontrol('Style','pushbutton','String','Familairity','Callback',{@familiar});
        e.Position=[900 20 80 50];
       e1=uicontrol('Style','pushbutton','String','Ethnicity','Callback',{@ethnic});
       e1.Position=[1000 20 80 50];
       e2=uicontrol('Style','pushbutton','String','Save','Callback',{@save1});
       e2.Position=[1100 20 80 50];
       e3=uicontrol('Style','pushbutton','String','Disregard Size','Callback',@disregard);
       e3.Position=[1200 20 80 50];
       e6=uicontrol('Style','pushbutton','String','AddLine','Callback',@lines);
       e6.Position=[1300 20 80 50];
       e4=uicontrol('Style','edit','Callback',{@edit});
       e4.Position=[1200 600 80 50];
       e5=uicontrol('Style','text','Position',[1200 650 60 25],'String','Enter Pg No.');
       prev=num;  
       disp(num);
    end
    

function people(hobject,callbackdata)
         entered=hobject.String ;
         entered=str2double(entered);
         facedetec1(num).NoPeople=entered;
         
         bboxes=facedetec1(num).bboxes;
        [m,n]=size(bboxes);
        if m~=0
          ifaces=insertObjectAnnotation(img,'rectangle',bboxes,facedetec1(num).f,'Color',facedetec1(num).d,'FontSize',29);
          figure(1),imshow((ifaces)),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
        else
          figure(1),imshow(img),title(['Image number is ', num2str(num)  '   Number of people is ', num2str(facedetec1(num).NoPeople)]);
       end         
        a=uicontrol('Style','slider','Callback',@display_slider_value,'Min',0,'Max',(p.total-1),'SliderStep',[(1/(total-1)) (10/(total-1))] );
        a.Position=[20 20 130 50];
        a.Value=num-1;
        f=uicontrol('Style','pushbutton','String','Select Correct Detections','Callback',@func1);
        f.Position=[210 20 80 50];
        g=uicontrol('Style','pushbutton','String','Add Faces','Callback',@func2);
        g.Position=[300 20 80 50];
        h=uicontrol('Style','pushbutton','String','Update','Callback',@func3);
        h.Position=[400 20 80 50];
        d=uicontrol('Style','pushbutton','String','Restore','Callback',{@restore});
        d.Position=[500 20 80 50];
        u=uicontrol('Style','pushbutton','String','Delete','Callback',{@delete});
        u.Position=[600 20 80 50];
        u.Visible='on';
        v=uicontrol('Style','pushbutton','String','Gender','Callback',@gender);
        v.Position=[700 20 80 50];
        z=uicontrol('Style','pushbutton','String','Pose','Callback',@pose);
        z.Position=[800 20 80 50];
        e=uicontrol('Style','pushbutton','String','Familairity','Callback',{@familiar});
        e.Position=[900 20 80 50];
       e1=uicontrol('Style','pushbutton','String','Ethnicity','Callback',{@ethnic});
       e1.Position=[1000 20 80 50];
       e2=uicontrol('Style','pushbutton','String','Save','Callback',{@save1});
       e2.Position=[1100 20 80 50];
       e3=uicontrol('Style','pushbutton','String','Disregard Size','Callback',@disregard);
       e3.Position=[1200 20 80 50];
       e6=uicontrol('Style','pushbutton','String','AddLine','Callback',@lines);
       e6.Position=[1300 20 80 50];
       e4=uicontrol('Style','edit','Callback',{@edit});
       e4.Position=[1200 600 80 50];
       e5=uicontrol('Style','text','Position',[1200 650 60 25],'String','Enter Pg No.');
       prev=num;  
       disp(num);
    end
end    
   
    
