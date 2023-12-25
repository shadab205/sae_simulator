
%% Parallel Parking Simulation of Robot
sample_time=0.1

dx_robo=30
dy_robo=15


% Create a figure and plot the initial rectangle
f1=figure;
%r_left = rectangle('Position',[0 (2.5*dy_robo) (5*dx_robo) (1.5*dy_robo)], 'FaceColor', 'r','EdgeColor','b','LineWidth',3);
%line_centre = line([(5*dx_robo) (5*dx_robo+1.5*dx_robo)],[(2.5*dy_robo+1.5*dy_robo) (2.5*dy_robo+1.5*dy_robo)],'color','b','LineWidth',3);
%r_right = rectangle('Position',[(5*dx_robo+1.5*dx_robo) (2.5*dy_robo) (3*dx_robo) (1.5*dy_robo)], 'FaceColor', 'r','EdgeColor','b','LineWidth',3);
axis([-1*dx_robo 11*dx_robo -1*dy_robo 5*dy_robo]);
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial coordinates of the rectangle
% x_US_pos = 20;
% y_US_pos = 7.5;
% 
% x_BackAxle_mid = 4;
% y_BackAxle_mid = 7.5;
% 
% Point_0 = [283.5, 200];
% Point_1 = [193.8750  251.1000]; %[(r_left.Position(3) + ((r_right.Position(1)-(r_left.Position(1)+r_left.Position(3)))/4)), 240+((r_left.Position(2) + r_left.Position(4) - r_left.Position(2))/2)]
% distance = [sqrt((Point_0(1) - Point_1(1))^2 + (Point_0(2) - Point_1(2))^2)];
% radius_arc = distance/2;
% beta1_start = 260;
% beta1_end = 180;
% beta1_angle = beta1_start - beta1_end;
% num_points = 100;
% center_arc1 = [Point_0(1), Point_0(2) + distance/4*sin(beta1_angle/2)];
% beta1 = linspace(deg2rad(beta1_start), deg2rad(beta1_end), num_points);
% 
% 
% % Coordinates of Arc1
% arc1_x = center_arc1(1) + radius_arc * cos(beta1);
% arc1_y = center_arc1(2) + radius_arc * sin(beta1);
% 
% hold on
% arc_curve = plot(arc1_x, arc1_y, 'b','LineWidth',2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Coordinates of Arc2
% beta2_start = 0;
% beta2_end = 80;
% beta2_angle = beta2_start - beta2_end;
% center_arc2 = [center_arc1(1)-2*radius_arc, center_arc1(2)]; %Beginning of parking lot + ((43.5-29)/2) + distance btw back of rover to rear wheel shaft (5cm was assumed) = 202.25
% beta2 = linspace(deg2rad(beta2_start), deg2rad(beta2_end), num_points);
% 
% % Calculate Arc2
% arc2_x = center_arc2(1) + radius_arc * cos(beta2);
% arc2_y = center_arc2(2) + radius_arc * sin(beta2);
% 
% hold on
% arc_curve2 = plot(arc2_x, arc2_y, 'r','LineWidth',2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define the center and radius of the arc
center_offsetx=-5;
center_offsety=5;
center = [195-center_offset, 30-center_offsety];
radius = 0.5*dx_robo;
theta = linspace(deg2rad(270), deg2rad(180), num_steps);
% Define the angle range for the arc (in radians)
%theta = linspace(0, pi/2, 100);  % 0 to 90 degrees

% Calculate the coordinates of the points on the arc
x = center(1) + radius * cos(theta);
y = center(2) + radius * sin(theta);

% Plot the arc
plot(center(1),center(2),'.')
hold on
plot(x, y, '.', 'LineWidth', 1);

center2 = [165-center_offset, 30-center_offsety];
radius2 = 0.5*dx_robo;
theta2 = linspace(deg2rad(0), deg2rad(90), num_steps);
% Define the angle range for the arc (in radians)
%theta = linspace(0, pi/2, 100);  % 0 to 90 degrees

% Calculate the coordinates of the points on the arc
xarc2 = center2(1) + radius2 * cos(theta2);
yarc2 = center2(2) + radius2 * sin(theta2);

% Plot the arc
plot(center2(1),center2(2),'.')
hold on
plot(xarc2, yarc2, '.', 'LineWidth', 1);

% Move the rectangle along the straight line
for i = 1:num_steps
    % Calculate the x-coordinate for each step

    clf(f1);
    axis([-0.3*dx_robo 11*dx_robo -0.3*dy_robo 4*dy_robo]);
    x_step = x_end * (i / num_steps);
    x_car=x_step;
    y_car=y_car;
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
    plot(x_car+(dx_robo/2), y_car, '.')
    hold on; 
 
    % Update rectangle position
    %set(rect, 'Position', [x1_line, y1_line, x2_line, y2_line]);
    %poly1 = rotate(rect,45);
    %drawnow;
    pause(sample_time/10);
end
% Move the rectangle along the straight line


for i = 1:num_steps
    % Calculate the x-coordinate for each step

    clf(f1);
    axis([-0.3*dx_robo 11*dx_robo -0.3*dy_robo 4*dy_robo]);
    del_theta = theta(i)
    
    x_car=x(i);
    y_car=y(i);
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
    poly1 = rotate(pgon_car,(rad2deg(del_theta)+90),[x_car y_car]);
    poly1.Vertices
    plot(poly1);
    hold on;
    plot(pgon_r_left);
    hold on;
    plot(pgon_c_line);
    hold on;
    plot(pgon_r_right);
    plot(x_car+(dx_robo/2), y_car, '.')
    hold on; 
 
    % Update rectangle position
    %set(rect, 'Position', [x1_line, y1_line, x2_line, y2_line]);
    %poly1 = rotate(rect,45);
    %drawnow;
    pause(sample_time/10);
end

car_theta=0;
for i = 1:num_steps
    % Calculate the x-coordinate for each step

    clf(f1);
    axis([-0.3*dx_robo 11*dx_robo -0.3*dy_robo 4*dy_robo]);
    del_theta = theta2(i)
    
    x_car=xarc2(i);
    y_car=yarc2(i);
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
    poly1 = rotate(pgon_car,(rad2deg(del_theta)-90),[x_car y_car]);
    poly1.Vertices
    plot(poly1);
    hold on;
    plot(pgon_r_left);
    hold on;
    plot(pgon_c_line);
    hold on;
    plot(pgon_r_right);
    plot(x_car+(dx_robo/2), y_car, '.')
    hold on; 
 
    % Update rectangle position
    %set(rect, 'Position', [x1_line, y1_line, x2_line, y2_line]);
    %poly1 = rotate(rect,45);
    %drawnow;
    pause(sample_time/10);
end
% % Move the rectangle along both arc_curves
% for j = 1:num_points
%     dx1 = arc1_x(j) - x1; % Change in x
%     dy1 = arc1_y(j) - y1; % Change in y
%     
%     % Update rectangle coordinates
%     x1 = x1 + dx1;
%     y1 = y1 + dy1;
%     x2 = x2 + dx1;
%     y2 = y2 + dy1;
% 
%     % Update the rectangle's position
%     set(rect, 'Position', [x1 - x_BackAxle_mid, y1 - y_BackAxle_mid, x2 - x1, y2 - y1]);
%     
%     drawnow; % Refresh the figure
%     pause(sample_time); % Pause for smoother animation
% end
% for k = 1:num_points
%     dx2 = arc2_x(k) - x1; % Change in x
%     dy2 = arc2_y(k) - y1; % Change in y
%     
%     % Update rectangle coordinates
%     x1 = x1 + dx2;
%     y1 = y1 + dy2;
%     x2 = x2 + dx2;
%     y2 = y2 + dy2;
% 
%     % Update the rectangle's position
%     set(rect, 'Position', [x1 - x_BackAxle_mid, y1 - y_BackAxle_mid, x2 - x1, y2 - y1]);
%     drawnow; % Refresh the figure
%     pause(sample_time); % Pause for smoother animation
% end