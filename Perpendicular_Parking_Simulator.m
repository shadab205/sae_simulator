%% Perpendicular Parking Simulation of Robot
% Initial coordinates of the rectangle
y_US_pos = 20;
x_US_pos = 7.5;

x_BackAxle_mid = 4;
y_BackAxle_mid = 7.5;


x1 = 274.391; % x-coordinate of top-left corner
y1 = 200; % y-coordinate of top-left corner
x2 = x1 + 29; % x-coordinate of bottom-right corner
y2 = y1 + 15; % y-coordinate of bottom-right corner


% Destination coordinates
new_y1 = 230.875; % new x-coordinate of top-left corner
new_x1 = 251.1; % new y-coordinate of top-left corner
new_y2 = new_x1 + 29; % new x-coordinate of bottom-right corner
new_x2 = new_y1 + 15; % new y-coordinate of bottom-right corner



% Create a figure and plot the initial rectangle
figure;
r_left = rectangle('Position',[0 260 178 43.5], 'FaceColor', 'r','EdgeColor','b','LineWidth',3);
line_centre = line([178 200.2],[303.5 303.5],'color','b','LineWidth',3);
r_right = rectangle('Position',[200.2 260 178 43.5], 'FaceColor', 'r','EdgeColor','b','LineWidth',3);
axis([0 320 0 320])
hold on

Point_0 = [227, 220];
Point_1 = [189.1  303.5-11.25];
%Point_1 = [(r_left.Position(3) + ((r_right.Position(1)-(r_left.Position(1)+r_left.Position(3)))/4)), 240+((r_left.Position(2) + r_left.Position(4) - r_left.Position(2))/2)]


distance = [sqrt((Point_0(1) - Point_1(1))^2 + (Point_0(2) - Point_1(2))^2)];
radius_arc = distance/2;
beta1_start = 270;
beta1_end = 200;
beta1_angle = beta1_start - beta1_end;
num_points = 100;
center_arc1 = [Point_0(1), Point_0(2) + sin(beta1_angle)];
beta1 = linspace(deg2rad(beta1_start), deg2rad(beta1_end), num_points);

% Draw horizontal line
x_start = 0;
y_start = 179.98;
x_end = 227;
y_end = 179.98;

% Draw vertical line
xv_start = 189.141;
yv_start = 205.49;
xv_end = Point_1(1);
yv_end = Point_1(2);

num_steps = 100;

straight_line = line([x_start x_end], [y_start y_end], 'color', 'g', 'LineWidth', 2);
vertical_line = line([xv_start xv_end], [yv_start yv_end], 'color', 'r', 'LineWidth', 2);


% Coordinates of Arc1
arc1_x = center_arc1(1) + radius_arc * cos(beta1);
arc1_y = center_arc1(2) + radius_arc * sin(beta1);

hold on
arc_curve = plot(arc1_x, arc1_y, 'b','LineWidth',2);

% Initialize rectangle plot
rect = rectangle('Position', [x1, y1, x2 - x1, y2 - y1], 'EdgeColor', 'm', 'LineWidth', 2);
title('EV3 Robot Simulator - Perpendicular Parking');


% Move the rectangle along the horizontal line
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

% Move the rectangle along arc_curve
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

% Move the rectangle along arc_curve
for i = 1:num_steps
    % Calculate the x-coordinate for each step
    yv_step = yv_start + (yv_end - yv_start) * (i / num_steps);

    % Update rectangle coordinates
    x1_vline = xv_start;
    y1_vline = yv_step;
    x2_vline = xv_start + 29;
    y2_vline = yv_step + 15;

    yv_BackAxle_mid = 24;
    xv_BackAxle_mid = 7.5;
    
    % Update rectangle position
    set(rect, 'Position', [x1_vline - xv_BackAxle_mid/2, y1_vline - yv_BackAxle_mid - xv_BackAxle_mid, y2_vline - y1_vline - xv_BackAxle_mid, x2_vline - x1_vline + yv_BackAxle_mid/2]);
    drawnow;
    pause(0.05);
end
