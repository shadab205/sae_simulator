close all
%% Parallel Parking Simulation of Robot
sample_time=0.1

dx_robo=300
dy_robo=150
global showPlotFlag;
showPlotFlag = true;
% Create a checkbox


speed=166
wheel_base=155
turn_radius=260
steer_angle=(atan(wheel_base/turn_radius))
rad2deg(steer_angle)
% Create a figure and plot the initial rectangle
global f1;
global checkbox;

f1=figure;
f1.Position=[50,100,1200,250]
hold on;
%checkbox = uicontrol('Style', 'checkbox', 'String', 'Show Plot', 'Value', 1, 'Position', [10, 10, 100, 20], 'Callback', @checkboxCallback);

axis([-2*dx_robo 11*dx_robo -2*dy_robo 4*dy_robo]);

r_left_x1=0;
r_left_x2=0;
r_left_x3=5*dx_robo;
r_left_x4=5*dx_robo;

r_left_y1=1.5*dy_robo;
r_left_y2=1.5*dy_robo+1.5*dy_robo;
r_left_y3=1.5*dy_robo;
r_left_y4=1.5*dy_robo+1.5*dy_robo;

pgon_r_left = polyshape([r_left_x1 r_left_x2 r_left_x4 r_left_x3],[r_left_y1 r_left_y2 r_left_y4 r_left_y3]);
%plot(pgon_r_left, 'Tag', 'pgon_right');

center_line_x1=5*dx_robo;
center_line_x2=5*dx_robo;
center_line_x3=5*dx_robo+1.5*dx_robo;
center_line_x4=5*dx_robo+1.5*dx_robo;

center_line_y1=1.5*dy_robo+1.5*dy_robo;
center_line_y2=1.5*dy_robo+1.6*dy_robo;
center_line_y3=1.5*dy_robo+1.5*dy_robo;
center_line_y4=1.5*dy_robo+1.6*dy_robo;
pgon_c_line = polyshape([center_line_x1 center_line_x2 center_line_x4 center_line_x3],[center_line_y1 center_line_y2 center_line_y4 center_line_y3]);
%plot(pgon_c_line);

r_right_x1=5*dx_robo+1.5*dx_robo;
r_right_x2=5*dx_robo+1.5*dx_robo;
r_right_x3=5*dx_robo+1.5*dx_robo+3*dx_robo;
r_right_x4=5*dx_robo+1.5*dx_robo+3*dx_robo;

r_right_y1=1.5*dy_robo;
r_right_y2=1.5*dy_robo+1.5*dy_robo;
r_right_y3=1.5*dy_robo;
r_right_y4=1.5*dy_robo+1.5*dy_robo;

pgon_r_right = polyshape([r_right_x1 r_right_x2 r_right_x4 r_right_x3],[r_right_y1 r_right_y2 r_right_y4 r_right_y3]);
%plot(pgon_r_right);

%robo_coordinates of left bottom corner
x_car=0;
y_car=dy_robo/2;

x1 = x_car; % x-coordinate of top-left corner
y1 = y_car + dy_robo/2; % y-coordinate of top-left corner
x2 = x_car; % x-coordinate of bottom-right corner
y2 = y_car - dy_robo/2; % y-coordinate of bottom-right corner
x3 = x_car+dx_robo; % x-coordinate of bottom-right corner
y3 = y_car + dy_robo/2; % y-coordinate of bottom-right corner
x4 = x_car+dx_robo; % x-coordinate of bottom-right corner
y4 = y_car - dy_robo/2; % y-coordinate of bottom-right corner
% Initialize rectangle plot
pgon_car = polyshape([x1 x2 x4 x3],[y1 y2 y4 y3]);
plot(pgon_car);
title('EV3 Robot Simulator - Parallel Parking with Parking Spot Detection');

% Draw straight line
x_start = 0;
y_start = 0;
x_end = 6.55*dx_robo;
y_end = dy_robo/2;
num_steps = 100;

straight_line = line([x_start x_end], [y_start+dy_robo/2 y_start+dy_robo/2], 'color', 'g', 'LineWidth', 1.5);
intp_line_x = [0 1499 1500 1949 1950 2850];
intp_line_y = [1.5*dy_robo 1.5*dy_robo 1.5*dy_robo+1.5*dy_robo 1.5*dy_robo+1.5*dy_robo 1.5*dy_robo 1.5*dy_robo];


% Sample list of items
listOfItems = {'Scenario: Valid Parking Spot', 'Scenario: Invalid Obj1', 'Scenario: Valid Parking Space, Invalid Obj2', 'Scenario: Invalid Parking Space', 'Scenario: Invalid Obj2', 'Scenario: Single Faulty Echo'};

% Create a list dialog box
[selected, ok] = listdlg('ListString', listOfItems, 'PromptString', 'Select an Scenario:', 'SelectionMode', 'single','ListSize', [250, 100]);

% Check if the user clicked 'OK'
if ok
    % Display the selected option
    disp(['You selected: ' listOfItems{selected}]);
else
    disp('User canceled the selection.');
end

%Echoes of Ultrasonic Sensor
scenario = selected
if scenario == 1
intp_line_x = [0 1499 1500 1949 1950 2850];
intp_line_y = [1.5*dy_robo 1.5*dy_robo 1.5*dy_robo+1.5*dy_robo 1.5*dy_robo+1.5*dy_robo 1.5*dy_robo 1.5*dy_robo];
elseif scenario ==2
intp_line_x = [0 70 71 1499 1500 1949 1950 2850];
intp_line_y = [1.5*dy_robo 1.5*dy_robo 3.5*dy_robo 3.5*dy_robo 1.5*dy_robo+1.5*dy_robo 1.5*dy_robo+1.5*dy_robo 1.5*dy_robo 1.5*dy_robo];
elseif scenario ==3
intp_line_x = [0 1499 1500 1949 1950 2850];
intp_line_y = [1.5*dy_robo 1.5*dy_robo 1.5*dy_robo+1.5*dy_robo 1.5*dy_robo+1.5*dy_robo 3.5*dy_robo 3.5*dy_robo];
elseif scenario ==4
intp_line_x = [0 1499 1500 1949-200 1950-200 2850-200];
intp_line_y = [1.5*dy_robo 1.5*dy_robo 1.5*dy_robo+1.5*dy_robo 1.5*dy_robo+1.5*dy_robo 1.5*dy_robo 1.5*dy_robo];
elseif scenario ==5
intp_line_x = [0 1499 1500 1949 1950 2020 2021 2850];
intp_line_y = [1.5*dy_robo 1.5*dy_robo 1.5*dy_robo+1.5*dy_robo 1.5*dy_robo+1.5*dy_robo 1.5*dy_robo 1.5*dy_robo 3.5*dy_robo 3.5*dy_robo];    
elseif scenario ==6
intp_line_x = [0 1499 1500 1949 1950 2850];
intp_line_y = [1.5*dy_robo 1.5*dy_robo 1.5*dy_robo+1.5*dy_robo 1.5*dy_robo+1.5*dy_robo 1.5*dy_robo 1.5*dy_robo];     
else
    disp('wrong input, scenario one selected');
end
    
detect_flag = 0;
parking_spot_detected = 0;
detect_obj1_flag = 0;
obj1_valid = 0;
obj1_last_distance=0;
start_distance_obj1=0;
obj1_distance=0;
parking_length_detected=0;

detect_obj2_flag = 0;
obj2_valid = 0;
obj2_last_distance=0;
start_distance_obj2=0;
obj2_distance=0;

park_flag=0
question = 'Do you want to Display the objects?';
dlgtitle = 'Confirmation';
defaultans = 'Yes';
%response = questdlg(question, dlgtitle, 'Yes', 'No', defaultans);
% if strcmp(response, 'Yes')
%     plot(pgon_r_left);
%     hold on;
%     plot(pgon_c_line);
%     hold on;
%     plot(pgon_r_right);
%     showPlotFlag = 1;
% else
%     
%     showPlotFlag = 0;
% end

showPlotFlag = 0;
vehicle_speed=166
for i = 1:160%118
    % Calculate the x-coordinate for each step
    if i==100
        disp('hi')
    end
    %clf(f1);
    axis([-2*dx_robo 11*dx_robo -2*dy_robo 4*dy_robo]);
    x_step = x_end * (i / num_steps);
    
    x_car=x_car+(vehicle_speed*cos(0)*sample_time);
    y_car=y_car+(vehicle_speed*sin(0)*sample_time);
    
    x1 = x_car; % x-coordinate of top-left corner
    y1 = y_car + dy_robo/2; % y-coordinate of top-left corner
    x2 = x_car; % x-coordinate of bottom-right corner
    y2 = y_car - dy_robo/2; % y-coordinate of bottom-right corner
    x3 = x_car+dx_robo; % x-coordinate of bottom-right corner
    y3 = y_car + dy_robo/2; % y-coordinate of bottom-right corner
    x4 = x_car+dx_robo; % x-coordinate of bottom-right corner
    y4 = y_car - dy_robo/2; % y-coordinate of bottom-right corner
    % Initialize rectangle plot
    pgon_car = polyshape([x1 x2 x4 x3],[y1 y2 y4 y3]);
    pgon_r_left = polyshape([r_left_x1 r_left_x2 r_left_x4 r_left_x3],[r_left_y1 r_left_y2 r_left_y4 r_left_y3]);
    pgon_c_line = polyshape([center_line_x1 center_line_x2 center_line_x4 center_line_x3],[center_line_y1 center_line_y2 center_line_y4 center_line_y3]);
    pgon_r_right = polyshape([r_right_x1 r_right_x2 r_right_x4 r_right_x3],[r_right_y1 r_right_y2 r_right_y4 r_right_y3]);
    
    hold on
    % Plot Ultrasonic Sensor Echoes
    new2_line_y = interp1(intp_line_x,intp_line_y, x_car);
    y_rand=-15 + (15+15)*rand(1);
    new2_line_y = new2_line_y + y_rand;
    if scenario ==6
        if i==100
            new2_line_y = new2_line_y - 100
        end    
    end
    plot(x_car, new2_line_y, 'r.', 'LineWidth', 5)
    
    plot(pgon_car);
    hold on;
    %poly1 = rotate(pgon_car,45*i/num_steps,[x_car y_car]);
    %poly1.Vertices
    %plot(poly1);
    hold on;
    
    if showPlotFlag == 1
        plot(pgon_r_left);
        hold on;
        plot(pgon_c_line);
        hold on;
        plot(pgon_r_right);
    end
    hold on;
    plot(x_car, y_car, '.')
    hold on;
    plot(x_car, y_car, '.')
    
    
    pause(sample_time/10);
    
    %Check for Parking Spot
    distance = new2_line_y - y_car - dy_robo/2 % distance = US echoes - top edge of car

    %distance = intp_line_y(3) - intp_line_y(2) - y_car;
    if distance<200 && detect_obj1_flag == 0 && detect_flag==0 && detect_obj2_flag==0
        start_distance_obj1 = x_car;
        detect_obj1_flag = 1;
        obj1_valid = 0;
    end
    if detect_obj1_flag == 1
        obj1_distance = x_car - start_distance_obj1
        if obj1_distance > 150
            obj1_valid = 1
        else
            obj1_valid = 0;
        end
        if distance < 200
            obj1_last_distance = distance;
        end
    end
    if distance >= 200 && detect_flag == 0 && obj1_valid ==1 && detect_obj2_flag==0 %distance is the ehoe length for current car position(x_car,y_car)
        start_distance = x_car;
        detect_flag = 1;
        parking_length_detected = 0;
        detect_obj1_flag =0 ;
    end
    if detect_flag == 1
        park_distance = x_car - start_distance;
        if park_distance > 425 && park_distance < 525
            parking_length_detected = 1;
        elseif park_distance > 525
            detect_flag = 0
            parking_length_detected = 0;
        end
        if distance - obj1_last_distance < 200 && park_distance < 425
            detect_flag = 0;
            parking_length_detected=0;
        end
    end
    
    if distance <=200 && parking_length_detected == 1 && detect_obj2_flag==0
        start_distance_obj2 = x_car;
        detect_obj2_flag = 1;
        obj2_valid = 0;
        detect_flag=0;
    end
    if detect_obj2_flag == 1
        obj2_distance = x_car - start_distance_obj2
        if obj2_distance > 95
            obj2_valid = 1;
        else
            obj2_valid = 0;
        end
        if distance > 200 
            detect_obj2_flag = 0
            obj1_valid =0 
            obj2_valid =0
            detect_flag =0
            detect_obj1_flag=0
            parking_length_detected=0
        end
    end    
    if obj1_valid == 1 && obj2_valid == 1 && parking_length_detected ==1
        parking_spot_detected =1
    end
    if parking_spot_detected == 1
        question = 'Do you want to Initiate a Park';
        dlgtitle = 'Park Confirmation';
        defaultans = 'Yes';
        response = questdlg(question, dlgtitle, 'Yes', 'No', defaultans);
        if strcmp(response, 'Yes')
            park_flag=1;
            parking_spot_detected=0;
            detect_flag=0;
            park_distance=0;
            break;
        else
            park_flag=0
            parking_spot_detected=0;
            detect_flag=0;
            park_distance=0;
            obj1_valid=0;
            obj2_valid=0;
            parking_length_detected=0;
            detect_obj1_flag=0;
            detect_obj2_flag=0;
        end
        
    end
end

if park_flag == 1
    %    arc1
    x=x_car;
    y=y_car;
    theta=0;
    speed=166;
    % move forward
    % Move the rectangle along the straight line
    for i = 1:1
        % Calculate the x-coordinate for each step
        i;
        %clf(f1);
        axis([-2*dx_robo 11*dx_robo -2*dy_robo 4*dy_robo]);
        del_theta = -speed/wheel_base*tan(0);
        theta=theta+(del_theta*0.1);
        rad2deg(theta);
        x_car=x_car+(-speed)*cos(theta)*0.1;
        y_car=y_car+(-speed)*sin(theta)*0.1;
        
        x1 = x_car; % x-coordinate of top-left corner
        y1 = y_car + dy_robo/2; % y-coordinate of top-left corner
        x2 = x_car; % x-coordinate of bottom-right corner
        y2 = y_car - dy_robo/2; % y-coordinate of bottom-right corner
        x3 = x_car+dx_robo; % x-coordinate of bottom-right corner
        y3 = y_car + dy_robo/2; % y-coordinate of bottom-right corner
        x4 = x_car+dx_robo; % x-coordinate of bottom-right corner
        y4 = y_car - dy_robo/2; % y-coordinate of bottom-right corner
        % Initialize rectangle plot
        pgon_car = polyshape([x1 x2 x4 x3],[y1 y2 y4 y3]);
        pgon_r_left = polyshape([r_left_x1 r_left_x2 r_left_x4 r_left_x3],[r_left_y1 r_left_y2 r_left_y4 r_left_y3]);
        pgon_c_line = polyshape([center_line_x1 center_line_x2 center_line_x4 center_line_x3],[center_line_y1 center_line_y2 center_line_y4 center_line_y3]);
        pgon_r_right = polyshape([r_right_x1 r_right_x2 r_right_x4 r_right_x3],[r_right_y1 r_right_y2 r_right_y4 r_right_y3]);
        
        plot(pgon_car);
        %hold on;
        actual_car = rotate(pgon_car,rad2deg(theta),[x_car y_car]);
        %actual_car.Vertices
        
        if showPlotFlag == 1
            plot(pgon_r_left);
            hold on;
            plot(pgon_c_line);
            hold on;
            plot(pgon_r_right);
        end
        hold on;
        
        plot(x_car, y_car, '.', 'LineWidth', 1);
        
        pause(sample_time);
    end
    theta=0;
    speed=76;
    
    for i = 1:20
        % Calculate the x-coordinate for each step
        i;
        %clf(f1);
        axis([-2*dx_robo 11*dx_robo -2*dy_robo 4*dy_robo]);
        del_theta = -speed/wheel_base*tan(steer_angle);
        theta=theta+(del_theta*0.1);
        rad2deg(theta);
        x_car=x_car+(-speed)*cos(theta)*0.1;
        y_car=y_car+(-speed)*sin(theta)*0.1;
        
        x1 = x_car; % x-coordinate of top-left corner
        y1 = y_car + dy_robo/2; % y-coordinate of top-left corner
        x2 = x_car; % x-coordinate of bottom-right corner
        y2 = y_car - dy_robo/2; % y-coordinate of bottom-right corner
        x3 = x_car+dx_robo; % x-coordinate of bottom-right corner
        y3 = y_car + dy_robo/2; % y-coordinate of bottom-right corner
        x4 = x_car+dx_robo; % x-coordinate of bottom-right corner
        y4 = y_car - dy_robo/2; % y-coordinate of bottom-right corner
        % Initialize rectangle plot
        pgon_car = polyshape([x1 x2 x4 x3],[y1 y2 y4 y3]);
        pgon_r_left = polyshape([r_left_x1 r_left_x2 r_left_x4 r_left_x3],[r_left_y1 r_left_y2 r_left_y4 r_left_y3]);
        pgon_c_line = polyshape([center_line_x1 center_line_x2 center_line_x4 center_line_x3],[center_line_y1 center_line_y2 center_line_y4 center_line_y3]);
        pgon_r_right = polyshape([r_right_x1 r_right_x2 r_right_x4 r_right_x3],[r_right_y1 r_right_y2 r_right_y4 r_right_y3]);
        
        %plot(pgon_car);
        %hold on;
        actual_car = rotate(pgon_car,rad2deg(theta),[x_car y_car]);
        %actual_car.Vertices
        plot(actual_car);
        hold on;
        
        if showPlotFlag == 1
            plot(pgon_r_left);
            hold on;
            plot(pgon_c_line);
            hold on;
            plot(pgon_r_right);
        end
        hold on;
        plot(x_car, y_car, '.', 'LineWidth', 1);
        
        pause(sample_time);
    end
    
    %move backward
    for i = 1:29
        % Calculate the x-coordinate for each step
        i;
        %clf(f1);
        axis([-02*dx_robo 11*dx_robo -02*dy_robo 4*dy_robo]);
        del_theta = -speed/wheel_base*-tan(0);
        
        theta=theta+(del_theta*0.1);
        rad2deg(theta);
        x_car=x_car+(-speed)*cos(theta)*0.1;
        y_car=y_car+(-speed)*sin(theta)*0.1;
        
        x1 = x_car; % x-coordinate of top-left corner
        y1 = y_car + dy_robo/2; % y-coordinate of top-left corner
        x2 = x_car; % x-coordinate of bottom-right corner
        y2 = y_car - dy_robo/2; % y-coordinate of bottom-right corner
        x3 = x_car+dx_robo; % x-coordinate of bottom-right corner
        y3 = y_car + dy_robo/2; % y-coordinate of bottom-right corner
        x4 = x_car+dx_robo; % x-coordinate of bottom-right corner
        y4 = y_car - dy_robo/2; % y-coordinate of bottom-right corner
        % Initialize rectangle plot
        pgon_car = polyshape([x1 x2 x4 x3],[y1 y2 y4 y3]);
        pgon_r_left = polyshape([r_left_x1 r_left_x2 r_left_x4 r_left_x3],[r_left_y1 r_left_y2 r_left_y4 r_left_y3]);
        pgon_c_line = polyshape([center_line_x1 center_line_x2 center_line_x4 center_line_x3],[center_line_y1 center_line_y2 center_line_y4 center_line_y3]);
        pgon_r_right = polyshape([r_right_x1 r_right_x2 r_right_x4 r_right_x3],[r_right_y1 r_right_y2 r_right_y4 r_right_y3]);
        
        %plot(pgon_car);
        %hold on;
        actual_car = rotate(pgon_car,rad2deg(theta),[x_car y_car]);
        %actual_car.Vertices
        plot(actual_car);
        hold on;
        
        if showPlotFlag == 1
            plot(pgon_r_left);
            hold on;
            plot(pgon_c_line);
            hold on;
            plot(pgon_r_right);
        end
        hold on;
        plot(x_car, y_car, '.', 'LineWidth', 1);
        pause(sample_time);
    end
    speed=76;
    for i = 1:7
        % Calculate the x-coordinate for each step
        i;
        %clf(f1);
        axis([-02*dx_robo 11*dx_robo -02*dy_robo 4*dy_robo]);
        del_theta = -speed/wheel_base*tan(steer_angle);
        
        theta=theta+(del_theta*0.1);
        rad2deg(theta);
        x_car=x_car+(-speed)*cos(theta)*0.1;
        y_car=y_car+(-speed)*sin(theta)*0.1;
        
        x1 = x_car; % x-coordinate of top-left corner
        y1 = y_car + dy_robo/2; % y-coordinate of top-left corner
        x2 = x_car; % x-coordinate of bottom-right corner
        y2 = y_car - dy_robo/2; % y-coordinate of bottom-right corner
        x3 = x_car+dx_robo; % x-coordinate of bottom-right corner
        y3 = y_car + dy_robo/2; % y-coordinate of bottom-right corner
        x4 = x_car+dx_robo; % x-coordinate of bottom-right corner
        y4 = y_car - dy_robo/2; % y-coordinate of bottom-right corner
        % Initialize rectangle plot
        pgon_car = polyshape([x1 x2 x4 x3],[y1 y2 y4 y3]);
        pgon_r_left = polyshape([r_left_x1 r_left_x2 r_left_x4 r_left_x3],[r_left_y1 r_left_y2 r_left_y4 r_left_y3]);
        pgon_c_line = polyshape([center_line_x1 center_line_x2 center_line_x4 center_line_x3],[center_line_y1 center_line_y2 center_line_y4 center_line_y3]);
        pgon_r_right = polyshape([r_right_x1 r_right_x2 r_right_x4 r_right_x3],[r_right_y1 r_right_y2 r_right_y4 r_right_y3]);
        
        %plot(pgon_car);
        %hold on;
        actual_car = rotate(pgon_car,rad2deg(theta),[x_car y_car]);
        %actual_car.Vertices
        plot(actual_car);
        hold on;
        
        if showPlotFlag == 1
            plot(pgon_r_left);
            hold on;
            plot(pgon_c_line);
            hold on;
            plot(pgon_r_right);
        end
        hold on;
        plot(x_car, y_car, '.', 'LineWidth', 1);
        pause(sample_time*2);
    end
    
    
    for i = 1:22
        % Calculate the x-coordinate for each step
        i;
        %clf(f1);
        axis([-02*dx_robo 11*dx_robo -02*dy_robo 4*dy_robo]);
        del_theta = -speed/wheel_base*-tan(steer_angle);
        
        theta=theta+(del_theta*0.1);
        rad2deg(theta);
        x_car=x_car+(-speed)*cos(theta)*0.1;
        y_car=y_car+(-speed)*sin(theta)*0.1;
        
        x1 = x_car; % x-coordinate of top-left corner
        y1 = y_car + dy_robo/2; % y-coordinate of top-left corner
        x2 = x_car; % x-coordinate of bottom-right corner
        y2 = y_car - dy_robo/2; % y-coordinate of bottom-right corner
        x3 = x_car+dx_robo; % x-coordinate of bottom-right corner
        y3 = y_car + dy_robo/2; % y-coordinate of bottom-right corner
        x4 = x_car+dx_robo; % x-coordinate of bottom-right corner
        y4 = y_car - dy_robo/2; % y-coordinate of bottom-right corner
        % Initialize rectangle plot
        pgon_car = polyshape([x1 x2 x4 x3],[y1 y2 y4 y3]);
        pgon_r_left = polyshape([r_left_x1 r_left_x2 r_left_x4 r_left_x3],[r_left_y1 r_left_y2 r_left_y4 r_left_y3]);
        pgon_c_line = polyshape([center_line_x1 center_line_x2 center_line_x4 center_line_x3],[center_line_y1 center_line_y2 center_line_y4 center_line_y3]);
        pgon_r_right = polyshape([r_right_x1 r_right_x2 r_right_x4 r_right_x3],[r_right_y1 r_right_y2 r_right_y4 r_right_y3]);
        
        %plot(pgon_car);
        %hold on;
        actual_car = rotate(pgon_car,rad2deg(theta),[x_car y_car]);
        %actual_car.Vertices
        plot(actual_car);
        hold on;
        
        if showPlotFlag == 1
            plot(pgon_r_left);
            hold on;
            plot(pgon_c_line);
            hold on;
            plot(pgon_r_right);
        end
        hold on;
        plot(x_car, y_car, '.', 'LineWidth', 1);
        pause(sample_time);
    end
    
    speed=76;
    for i = 1:5
        % Calculate the x-coordinate for each step
        i;
        %clf(f1);
        axis([-02*dx_robo 11*dx_robo -02*dy_robo 4*dy_robo]);
        del_theta = speed/wheel_base*tan(steer_angle);
        
        theta=theta+(del_theta*0.1);
        rad2deg(theta);
        x_car=x_car+(speed)*cos(theta)*0.1;
        y_car=y_car+(speed)*sin(theta)*0.1;
        
        x1 = x_car; % x-coordinate of top-left corner
        y1 = y_car + dy_robo/2; % y-coordinate of top-left corner
        x2 = x_car; % x-coordinate of bottom-right corner
        y2 = y_car - dy_robo/2; % y-coordinate of bottom-right corner
        x3 = x_car+dx_robo; % x-coordinate of bottom-right corner
        y3 = y_car + dy_robo/2; % y-coordinate of bottom-right corner
        x4 = x_car+dx_robo; % x-coordinate of bottom-right corner
        y4 = y_car - dy_robo/2; % y-coordinate of bottom-right corner
        % Initialize rectangle plot
        pgon_car = polyshape([x1 x2 x4 x3],[y1 y2 y4 y3]);
        pgon_r_left = polyshape([r_left_x1 r_left_x2 r_left_x4 r_left_x3],[r_left_y1 r_left_y2 r_left_y4 r_left_y3]);
        pgon_c_line = polyshape([center_line_x1 center_line_x2 center_line_x4 center_line_x3],[center_line_y1 center_line_y2 center_line_y4 center_line_y3]);
        pgon_r_right = polyshape([r_right_x1 r_right_x2 r_right_x4 r_right_x3],[r_right_y1 r_right_y2 r_right_y4 r_right_y3]);
        
        %plot(pgon_car);
        %hold on;
        actual_car = rotate(pgon_car,rad2deg(theta),[x_car y_car]);
        %actual_car.Vertices
        plot(actual_car);
        hold on;
        
        if showPlotFlag == 1
            plot(pgon_r_left);
            hold on;
            plot(pgon_c_line);
            hold on;
            plot(pgon_r_right);
        end
        hold on;
        plot(x_car, y_car, '.', 'LineWidth', 1);
        pause(sample_time*2);
    end
end

