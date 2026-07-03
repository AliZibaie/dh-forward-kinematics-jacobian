function [J] = JacobianMatrix(varargin)

% Order per joint: [a, alpha, d, theta]

% Error handling: Check if arguments are multiple of 4
n_args = nargin;
if mod(n_args, 4) ~= 0
    error('Number of arguments must be multiple of 4 (each joint: a, alpha, d, theta)');
end

n_joints = n_args / 4;

[TE, RE, PE] = link2global(varargin{1:n_joints*4});

J = sym(zeros(6, n_joints));

% Loop through each joint (4 parameters per joint)
for i = 1:n_joints
    idx = (i-1)*4 + 1;
    [Ti, Ri, Pi] = link2global(varargin{1:idx+3});
    z = Ri(:, 3);
    J(1:3, i) = simplify(cross(z, PE-Pi));
    J(4:6, i) = z;
    % isequal(T_in_global, link2global(varargin{1:16})) it works!
end

end
