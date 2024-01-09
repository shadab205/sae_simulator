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
f1.Position=[100,600,1200,250]
%r_left = rectangle('Position',[0 (2.5*dy_robo) (5*dx_robo) (1.5*dy_robo)], 'FaceColor', 'r','EdgeColor','b','LineWidth',3);
%line_centre = line([(5*dx_robo) (5*dx_robo+1.5*dx_robo)],[(2.5*dy_robo+1.5*dy_robo) (2.5*dy_robo+1.5*dy_robo)],'color','b','LineWidth',3);
%r_right = rectangle('Position',[(5*dx_robo+1.5*dx_robo) (2.5*dy_robo) (3*dx_robo) (1.5*dy_robo)], 'FaceColor', 'r','EdgeColor','b','LineWidth',3);
%axis([-1*dx_robo 11*dx_robo -1*dy_robo 5*dy_robo]);
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
title('EV3 Robot Simulator - Parallel Parking');

% Draw straight line
x_start = 0;
y_start = 0;
x_end = 6.55*dx_robo;
y_end = dy_robo/2;
num_steps = 100;

straight_line = line([x_start x_end], [y_start+dy_robo/2 y_start+dy_robo/2], 'color', 'g', 'LineWidth', 1.5);

% center_offsetx=7.5;
% center_offsety=5;
% radius = 220;
% center = [1950-center_offsetx, y_car+radius-center_offsety];
% %theta = linspace(deg2rad(270), deg2rad(180), num_steps);
% % Define the angle range for the arc (in radians)
% %theta = linspace(0, pi/2, 100);  % 0 to 90 degrees
% 
% % Calculate the coordinates of the points on the arc
% theta=0
% x = center(1) + radius * cos(theta);
% y = center(2) + radius * sin(theta);
% 
% % Plot the arc
% plot(center(1),center(2),'.')
% hold on
% plot(x, y, '.', 'LineWidth', 1);
% 
% center2 = [1650-center_offsetx, 465-center_offsety];
% radius2 = radius;
% theta2 = linspace(deg2rad(0), deg2rad(90), num_steps);
% % Define the angle range for the arc (in radians)
% %theta = linspace(0, pi/2, 100);  % 0 to 90 degrees
% 
% % Calculate the coordinates of the points on the arc
% xarc2 = center2(1) + radius2 * cos(theta2);
% yarc2 = center2(2) + radius2 * sin(theta2);
% 
% % Plot the arc
% plot(center2(1),center2(2),'.')
% hold on
% plot(xarc2, yarc2, '.', 'LineWidth', 1);

vehicle_speed=166 
% Move the rectangle along the straight line
for i = 1:118
    % Calculate the x-coordinate for each step

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

    % Update rectangle position
    %set(rect, 'Position', [x1_line, y1_line, x2_line, y2_line]);
    %poly1 = rotate(rect,45);
    %drawnow;
    %pause(sample_time/1000);
end
% Move the rectangle along the straight line

%arc1
x=x_car;
y=y_car;
theta=0;
speed=76;
for i = 1:54
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


for i = 1:18
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
speed=166;
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


for i = 1:10
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

speed=166;
for i = 1:2
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
