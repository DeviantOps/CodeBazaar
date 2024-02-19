function sierpinski_triangle(n)
  % Initial triangle coordinates
  x = [0, 1, 0.5];
  y = [0, 0, sqrt(3)/2];
  
  % Generate n iterations of the Sierpinski triangle
  for i = 1:n
    % Plot the current iteration
    fill(x, y, 'k');
    hold on;
    
    % Compute the new coordinates for the next iteration
    x_new = [x(1), (x(1)+x(2))/2, x(2), (x(2)+x(3))/2, x(3), (x(3)+x(1))/2];
    y_new = [y(1), (y(1)+y(2))/2, y(2), (y(2)+y(3))/2, y(3), (y(3)+y(1))/2];
    
    % Update the coordinates for the next iteration
    x = x_new;
    y = y_new;
  end
  
  % Adjust the axis limits and display the final plot
  xlim([0, 1]);
  ylim([0, sqrt(3)/2]);
  axis equal;
  axis off;
  title(sprintf('Sierpinski Triangle (n = %d)', n));
end
