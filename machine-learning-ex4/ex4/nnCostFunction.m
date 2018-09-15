function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1); % number of training examples
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%


%% Compute costfunction by forward propagation.
%% Use backpropagation to computeht the gradient

a_1 = [ones(m,1),X];
z_2 = a_1 * Theta1';
a_2 = [ones(m,1),sigmoid(z_2)];
z_3 = a_2 * Theta2';
a_3 = sigmoid(z_3);
h = a_3;

label = (1:num_labels)' ;
Delta1 = zeros(hidden_layer_size, input_layer_size+1);
Delta2 = zeros(num_labels,hidden_layer_size+1);

for i = 1:m
    yi = (label == y(i)); % change lable to num_lables dimension, namely (0,0,..,1,0,0)
    J = J - ( log(h(i,:))*yi+log(1-h(i,:))*(1-yi) ) ;
    %%% use backpropagation to computeht the gradient
    a3_i = h(i,:)' ;
    z2_i = z_2(i,:)';
    z2_i = [1;z2_i];
    a2_i = a_2(i,:)';
    %a2_i = a2_i(2:end)' ;
    a1_i = a_1(i,:)';
    %a1_i = a1_i(2:end);
    
    delta3 = a3_i - yi ;
    delta2 = Theta2'*delta3.*sigmoidGradient(z2_i);
    delta2 = delta2(2:end);
    Delta1 = Delta1 + delta2*a1_i';
    Delta2 = Delta2 + delta3 * a2_i' ;
    
end

J = J/m;

%regulization without theta_l0 l = 1,2
temp_theta1 = Theta1(:,2:input_layer_size+1);
temp_theta2 = Theta2(:,2:hidden_layer_size+1);

temp_theta1 = temp_theta1.^2 ;
temp_theta2 = temp_theta2.^2 ;
J = J +lambda * ( sum(temp_theta1(:)) + sum(temp_theta2(:)) )/(2*m) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D1 = Delta1/m ;
D2 = Delta2/m ;

D1(:,2:end) = D1(:,2:end) + lambda * Theta1(:,2:end)/m ;
D2(:,2:end) = D2(:,2:end) + lambda * Theta2(:,2:end)/m ;

Theta1_grad = D1;
Theta2_grad = D2;

    
    















% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
