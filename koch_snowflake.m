function koch_snowflake(n)
  % Initial triangle coordinates
  x = [-0.5, 0, 0.5, -0.5];
  y = [sqrt(3)/6, 2*sqrt(3)/3, sqrt(3)/6, sqrt(3)/6];
  
  % Generate n iterations of the Koch snowflake
  for i = 1:n
    % Plot the current iteration
    fill(x, y, 'k');
    hold on;
    
    % Compute the new coordinates for the next iteration
    x_new = [x(1), (x(1)+x(2))/2, (x(1)+x(2))/2+(x(2)-x(1))/2*cos(pi/3),...
             (x(2)+x(3))/2-(x(3)-x(2))/2*cos(pi/3), (x(3)+x(4))/2, x(4)];
    y_new = [y(1), (y(1)+y(2))/2, (y(1)+y(2))/2+(y(2)-y(1))/2*cos(pi/3),...
             (y(2)+y(3))/2-(y(2)-y(3))/2*cos(pi/3), (y(3)+y(4))/2, y(4)];
    
    % Update the coordinates for the next iteration
    x = x_new;
    y = y_new;
  end
  
  % Adjust the axis limits and display the final plot
  xlim([-1, 1]);
  ylim([-0.2, sqrt(3)/2+0.2]);
  axis equal;
  axis off;
  title(sprintf('Koch Snowflake (n = %d)', n));
end
