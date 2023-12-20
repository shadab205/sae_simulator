%% Parallel Parking Simulation of Robot
% Initial coordinates of the rectangle
x_US_pos = 20;
y_US_pos = 7.5;

x_BackAxle_mid = 4;
y_BackAxle_mid = 7.5;

x1 = 274.391; % x-coordinate of top-left corner
y1 = 200; % y-coordinate of top-left corner
x2 = x1 + 29; % x-coordinate of bottom-right corner
y2 = y1 + 15; % y-coordinate of bottom-right corner

% Create a figure and plot the initial rectangle
figure;
r_left = rectangle('Position',[0 260 178 22.2], 'FaceColor', 'r','EdgeColor','b','LineWidth',3);
line_centre = line([178 233.5],[282.2 282.2],'color','b','LineWidth',3);
r_right = rectangle('Position',[221.5 260 178 22.2], 'FaceColor', 'r','EdgeColor','b','LineWidth',3);
axis([0 300 0 300])
hold on

Point_0 = [283.5, 200];
Point_1 = [193.8750  251.1000]; %[(r_left.Position(3) + ((r_right.Position(1)-(r_left.Position(1)+r_left.Position(3)))/4)), 240+((r_left.Position(2) + r_left.Position(4) - r_left.Position(2))/2)]
distance = [sqrt((Point_0(1) - Point_1(1))^2 + (Point_0(2) - Point_1(2))^2)];
radius_arc = distance/2;
beta1_start = 260;
beta1_end = 180;
beta1_angle = beta1_start - beta1_end;
num_points = 100;
center_arc1 = [Point_0(1), Point_0(2) + distance/4*sin(beta1_angle/2)];
beta1 = linspace(deg2rad(beta1_start), deg2rad(beta1_end), num_points);

% Draw straight line
x_start = 0;
y_start = 168.417;
x_end = 274.542;
y_end = 168.417;
num_steps = 100;

straight_line = line([x_start x_end], [y_start y_end], 'color', 'g', 'LineWidth', 2);

% Coordinates of Arc1
arc1_x = center_arc1(1) + radius_arc * cos(beta1);
arc1_y = center_arc1(2) + radius_arc * sin(beta1);

hold on
arc_curve = plot(arc1_x, arc1_y, 'b','LineWidth',2);

% Initialize rectangle plot
rect = rectangle('Position', [x1, y1, x2 - x1, y2 - y1], 'EdgeColor', 'm', 'LineWidth', 2);
title('EV3 Robot Simulator - Parallel Parking');


% Coordinates of Arc2
beta2_start = 0;
beta2_end = 80;
beta2_angle = beta2_start - beta2_end;
center_arc2 = [center_arc1(1)-2*radius_arc, center_arc1(2)]; %Beginning of parking lot + ((43.5-29)/2) + distance btw back of rover to rear wheel shaft (5cm was assumed) = 202.25
beta2 = linspace(deg2rad(beta2_start), deg2rad(beta2_end), num_points);

% Calculate Arc2
arc2_x = center_arc2(1) + radius_arc * cos(beta2);
arc2_y = center_arc2(2) + radius_arc * sin(beta2);

hold on
arc_curve2 = plot(arc2_x, arc2_y, 'r','LineWidth',2);

% Move the rectangle along the straight line
for i = 1:num_steps
    % Calculate the x-coordinate for each step
    x_step = x_end * (i / num_steps);

    % Update rectangle coordinates
    x1_line = x_step;
    y1_line = y_start;
    x2_line = x_step + 29;
    y2_line = y_start + 15;

    % Update rectangle position
    set(rect, 'Position', [x1_line - x_BackAxle_mid, y1_line - y_BackAxle_mid, x2_line - x1_line, y2_line - y1_line]);
    drawnow;
    pause(0.05);
end

% Move the rectangle along both arc_curves
for j = 1:num_points
    dx1 = arc1_x(j) - x1; % Change in x
    dy1 = arc1_y(j) - y1; % Change in y
    
    % Update rectangle coordinates
    x1 = x1 + dx1;
    y1 = y1 + dy1;
    x2 = x2 + dx1;
    y2 = y2 + dy1;

    % Update the rectangle's position
    set(rect, 'Position', [x1 - x_BackAxle_mid, y1 - y_BackAxle_mid, x2 - x1, y2 - y1]);
    drawnow; % Refresh the figure
    pause(0.05); % Pause for smoother animation
end
for k = 1:num_points
    dx2 = arc2_x(k) - x1; % Change in x
    dy2 = arc2_y(k) - y1; % Change in y
    
    % Update rectangle coordinates
    x1 = x1 + dx2;
    y1 = y1 + dy2;
    x2 = x2 + dx2;
    y2 = y2 + dy2;

    % Update the rectangle's position
    set(rect, 'Position', [x1 - x_BackAxle_mid, y1 - y_BackAxle_mid, x2 - x1, y2 - y1]);
    drawnow; % Refresh the figure
    pause(0.05); % Pause for smoother animation
end