close all
%% Parallel Parking Simulation of Robot
sample_time=0.1

dx_robo=300
dy_robo=150

speed=166
wheel_base=155
turn_radius=260
steer_angle=(atan(wheel_base/turn_radius))
rad2deg(steer_angle)
% Create a figure and plot the initial rectangle
f1=figure;
f1.Position=[50,100,1200,250]
hold on;

r_left_x1=0;
r_left_x2=0;
r_left_x3=5*dx_robo;
r_left_x4=5*dx_robo;

r_left_y1=2*dy_robo;
r_left_y2=2*dy_robo+1.5*dy_robo;
r_left_y3=2*dy_robo;
r_left_y4=2*dy_robo+1.5*dy_robo;

pgon_r_left = polyshape([r_left_x1 r_left_x2 r_left_x4 r_left_x3],[r_left_y1 r_left_y2 r_left_y4 r_left_y3]);
plot(pgon_r_left);

center_line_x1=5*dx_robo;
center_line_x2=5*dx_robo;
center_line_x3=5*dx_robo+1.5*dx_robo;
center_line_x4=5*dx_robo+1.5*dx_robo;

center_line_y1=2*dy_robo+1.5*dy_robo;
center_line_y2=2*dy_robo+1.6*dy_robo;
center_line_y3=2*dy_robo+1.5*dy_robo;
center_line_y4=2*dy_robo+1.6*dy_robo;
pgon_c_line = polyshape([center_line_x1 center_line_x2 center_line_x4 center_line_x3],[center_line_y1 center_line_y2 center_line_y4 center_line_y3]);
plot(pgon_c_line);

r_right_x1=5*dx_robo+1.5*dx_robo;
r_right_x2=5*dx_robo+1.5*dx_robo;
r_right_x3=5*dx_robo+1.5*dx_robo+3*dx_robo;
r_right_x4=5*dx_robo+1.5*dx_robo+3*dx_robo;

r_right_y1=2*dy_robo;
r_right_y2=2*dy_robo+1.5*dy_robo;
r_right_y3=2*dy_robo;
r_right_y4=2*dy_robo+1.5*dy_robo;

pgon_r_right = polyshape([r_right_x1 r_right_x2 r_right_x4 r_right_x3],[r_right_y1 r_right_y2 r_right_y4 r_right_y3]);
plot(pgon_r_right);

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

%Echoes of Ultrasonic Sensor
intp_line_x = [0 1499 1500 1949 1950 2850];
intp_line_y = [300 300 525 525 300 300];

detect_flag = 0;
parking_spot_detected = 0;

vehicle_speed=166 

%parking_spot_detected == 1
    % Move the rectangle along the straight line
    for i = 1:118
        % Calculate the x-coordinate for each step
        
        %clf(f1);
        axis([-2*dx_robo 11*dx_robo -2*dy_robo 4*dy_robo]);
        x_step = x_end * (i / num_steps);
        
        x_car=x_car+(vehicle_speed*cos(0)*sample_time)
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
        y_rand=-25 + (25+25)*rand(1);
        new2_line_y = new2_line_y + y_rand;
        plot(x_car, new2_line_y, 'r*', 'LineWidth', 5)
        
        plot(pgon_car);
        hold on;
        %poly1 = rotate(pgon_car,45*i/num_steps,[x_car y_car]);
        %poly1.Vertices
        %plot(poly1);
        hold on;
        plot(pgon_r_left);
        hold on;
        plot(pgon_c_line);
        hold on;
        plot(pgon_r_right);
        hold on;
        plot(x_car, y_car, '.')
        hold on;
        plot(x_car, y_car, '.')
        
        
       % pause(sample_time/10);
        
        %Check for Parking Spot
        distance = new2_line_y - y_car - dy_robo/2; % distance = US echoes - top edge of car
        
        %distance = intp_line_y(3) - intp_line_y(2) - y_car;
        if distance >= 350 && detect_flag == 0 %distance is the ehoe length for current car position(x_car,y_car)
            start_distance = x_car
            detect_flag = 1;
            parking_spot_detected = 0;
        end
        if detect_flag == 1
            park_distance = x_car - start_distance
            if park_distance > 425
                parking_spot_detected = 1;
            else
                parking_spot_detected = 0;
            end
            if distance < 350
                detect_flag = 0;
            end
        end
        
        if parking_spot_detected == 1
            break;
        end
    end
     %    arc1
    x=x_car;
    y=y_car;
    theta=0;
    speed=166;
    % move forward
    % Move the rectangle along the straight line
        for i = 1:7
        % Calculate the x-coordinate for each step
        i
        %clf(f1);
        axis([-2*dx_robo 11*dx_robo -2*dy_robo 4*dy_robo]);
        del_theta = speed/wheel_base*tan(0);
        theta=theta+(del_theta*0.1);
        rad2deg(theta)
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
        plot(pgon_r_left);
        hold on;
        plot(pgon_c_line);
        hold on;
        plot(pgon_r_right);
        hold on;
        plot(x_car, y_car, '.', 'LineWidth', 1);
        
        pause(sample_time);
    end
    theta=0;
    speed=76;
    
    for i = 1:25
        % Calculate the x-coordinate for each step
        i
        %clf(f1);
        axis([-2*dx_robo 11*dx_robo -2*dy_robo 4*dy_robo]);
        del_theta = -speed/wheel_base*tan(steer_angle);
        theta=theta+(del_theta*0.1);
        rad2deg(theta)
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
        plot(pgon_r_left);
        hold on;
        plot(pgon_c_line);
        hold on;
        plot(pgon_r_right);
        hold on;
        plot(x_car, y_car, '.', 'LineWidth', 1);
        
        pause(sample_time);
    end
    
    %move backward
    for i = 1:30
        % Calculate the x-coordinate for each step
        i
        %clf(f1);
        axis([-02*dx_robo 11*dx_robo -02*dy_robo 4*dy_robo]);
        del_theta = -speed/wheel_base*-tan(0);
        
        theta=theta+(del_theta*0.1);
        rad2deg(theta)
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
        plot(pgon_r_left);
        hold on;
        plot(pgon_c_line);
        hold on;
        plot(pgon_r_right);
        hold on;
        plot(x_car, y_car, '.', 'LineWidth', 1);
        pause(sample_time);
    end
    speed=76;
    for i = 1:5
        % Calculate the x-coordinate for each step
        i
        %clf(f1);
        axis([-02*dx_robo 11*dx_robo -02*dy_robo 4*dy_robo]);
        del_theta = -speed/wheel_base*tan(steer_angle);
        
        theta=theta+(del_theta*0.1);
        rad2deg(theta)
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
        plot(pgon_r_left);
        hold on;
        plot(pgon_c_line);
        hold on;
        plot(pgon_r_right);
        hold on;
        plot(x_car, y_car, '.', 'LineWidth', 1);
        pause(sample_time*2);
    end
    
    
    for i = 1:25
        % Calculate the x-coordinate for each step
        i
        %clf(f1);
        axis([-02*dx_robo 11*dx_robo -02*dy_robo 4*dy_robo]);
        del_theta = -speed/wheel_base*-tan(steer_angle);
        
        theta=theta+(del_theta*0.1);
        rad2deg(theta)
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
        plot(pgon_r_left);
        hold on;
        plot(pgon_c_line);
        hold on;
        plot(pgon_r_right);
        hold on;
        plot(x_car, y_car, '.', 'LineWidth', 1);
        pause(sample_time);
    end
    
    speed=76;
    for i = 1:5
        % Calculate the x-coordinate for each step
        i
        %clf(f1);
        axis([-02*dx_robo 11*dx_robo -02*dy_robo 4*dy_robo]);
        del_theta = speed/wheel_base*tan(steer_angle);
        
        theta=theta+(del_theta*0.1);
        rad2deg(theta)
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
        plot(pgon_r_left);
        hold on;
        plot(pgon_c_line);
        hold on;
        plot(pgon_r_right);
        hold on;
        plot(x_car, y_car, '.', 'LineWidth', 1);
        pause(sample_time*2);
    end
