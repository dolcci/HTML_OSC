%%connect arduino
%clear all;
%clc
a= arduino();
imu= mpu9250(a);
%%read the magnet infromation;
magReadings = readMagneticField(imu);

%% calibration

%display(['Fusion algorithms use magnetometer readings which need to compensate for magnetic distortions.' ...
   % 'The given code snippet can be used to find the correction values for compensating Hard Iron Distortions. When the code '...
  %  'is executing, rotate the sensor around x axis from 0 to 360 degree. For other axes, modify the code accordingly and rotate the ' ...
    %'sensor along that axis'],'Compensating Hard Iron Distortions');
tic;
stopTimer = 100;
magReadings=[];
while(toc<stopTimer)
    % Rotate the sensor around x axis from 0 to 360 degree.
    % Take 2-3 rotations to improve accuracy.
    % For other axes, rotate around that axis.
    [accel,gyro,mag] = read(imu);
   % magReadings = [magReadings;mag];
end

% For y axis, use magReadings (:,2) and for z axis use magReadings(:,3)
magx_min = min(magReadings(:,1));
magx_max = max(magReadings(:,1));
magx_correction = (magx_max+magx_min)/2;

%% send from Matlab to Max
%Hs=dsp.UDPSender('RemoteIPAddress','127.0.0.1','RemoteIPPort',7400);

%test1= oscwrite('/x',{num2str(magReadings(1))});
%test2= oscwrite('/y',{num2str(magReadings(2))});
%test3= oscwrite('/z',{num2str(magReadings(3))});
%test1= oscwrite('/x',{magReadings(1)});
%test2= oscwrite('/y',{magReadings(2)});
%test3= oscwrite('/z',{magReadings(3)});
%step(Hs,test1);
%step(Hs,test2);
%step(Hs,test3);

%% read

Hr = dsp.UDPReceiver('LocalIPPort',7401);
dR =[];
out = 0;
trial= 28;
i=0 ;
    
while out==0
    dR = step(Hr);
    if isempty(dR)==0
        [tag,data]= oscread(dR);
       break
    end
end
disp('end')
disp([tag data]);

data = cell2mat(data);
target = 'push ';
    
trail=28;

    if data==11111
        
        magReadings= readMagneticField(imu);
        Hs=dsp.UDPSender('RemoteIPAddress','127.0.0.1','RemoteIPPort',7400);
        
        test1= oscwrite('/x',{magReadings(1)});
        test2= oscwrite('/y',{magReadings(2)});
        test3= oscwrite('/z',{magReadings(3)});
        
        step(Hs,test1);
        step(Hs,test2);
        step(Hsq,test3);
        
    else
        disp('error')

    end
release(Hr)




%% for and 

for i=1:trial
    
    
end

while i==0
    pause(100)
    
    if fuga
        
    end
    
    if hoge
        break
    end
end




%% 

stop =1 
trail = [];
while hoge~=1
    
    % waiting maxmsp startsignals
    
   dR=[];
   dR=step(Hr);
   if ~isempty(dR)
       [tag,data]= oscread(dR);
       
    if tag == '/space'
        
        % strcmp(space(1:6), target(1:6))
        %before that space='/space '
        % get the data from arduino
        
        % sent
        
        % increase stop value
       % stop= stop+1;
       
       
       if stop= trail
           break
    end
    end
   
     % if something wrong happen
     hoge = 1;
     if hoge == 1
         error();
     end
     
     
end
