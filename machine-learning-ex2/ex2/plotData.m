function plotData(X, y)
%PLOTDATA Plots the data points X and y into a new figure 
%   PLOTDATA(x,y) plots the data points with + for the positive examples
%   and o for the negative examples. X is assumed to be a Mx2 matrix.

% Create New Figure
figure; hold on;

% ====================== YOUR CODE HERE ======================
% Instructions: Plot the positive and negative examples on a
%               2D plot, using the option 'k+' for the positive
%               examples and 'ko' for the negative examples.
%
non_zero_position = find(y);
zero_postion = find(~y);
list_1 = X(non_zero_position,:);
list_2 = X(zero_postion,:);

plot(list_1(:,1),list_1(:,2),'k+','LineWidth', 2,'MarkerSize', 7)
plot(list_2(:,1),list_2(:,2),'ko','MarkerFaceColor', 'y', 'MarkerSize', 7)
xlabel('Exam1 Score')
ylabel('Exam2 Scoere')









% =========================================================================



hold off;

end
