function [T, rotationMatrix, point] = link2global(varargin)
% link2global: Computes end-effector pose from DH parameters
% Usage: T = link2global(a1,alpha1,d1,theta1, a2,alpha2,d2,theta2, ...)
% Order per joint: [a, alpha, d, theta]

% Error handling: Check if arguments are multiple of 4
n_args = nargin;
if mod(n_args, 4) ~= 0
    error('Number of arguments must be multiple of 4 (each joint: a, alpha, d, theta)');
end

n_joints = n_args / 4;

% Initialize transformation matrix
T = eye(4);

% Loop through each joint (4 parameters per joint)
for i = 1:n_joints
    idx = (i-1)*4 + 1;  % Starting index for current joint
    a = varargin{idx};
    alpha = varargin{idx+1};
    d = varargin{idx+2};
    theta = varargin{idx+3};
    
    T_temp = transform_matrix(a, alpha, d, theta);
    T = T * T_temp;
end

rotationMatrix = T(1:3, 1:3);
point = T(1:3, 4);

end