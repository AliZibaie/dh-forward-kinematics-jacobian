clc;clear all;close all;
% Joint 1
a0 = 0; alpha0 = 0; d1 = 0; theta1 = sym('theta1');

% Joint 2
a1 = sym('a2'); alpha1 = -pi/2; d2 = 0; theta2 = sym('theta2');

a2 = sym('a3'); alpha2 = 0; d3 = 0; theta3 = sym('theta3');

% Joint 4
a3 = sym('a4'); alpha3 = pi/2; d4 = sym('d4'); theta4 = sym('theta4');

% Joint 5
a4 = sym('a5'); alpha4 = -pi/2; d5 = sym('d5'); theta5 = sym('theta5');

% Joint 6
a5 = sym('a6'); alpha5 = 0; d6 = sym('d6'); theta6 = sym('theta6');


J = JacobianMatrix(a0, alpha0, d1, theta1, ...
                   a1, alpha1, d2, theta2, ...
                   a2, alpha2, d3, theta3, ...
                   a3, alpha3, d4, theta4, ...
                   a4, alpha4, d5, theta5, ...
                   a5, alpha5, d6, theta6);


detJ = det(J);
% i do this bc it does not matter for us just to be positive value to find
% singularities!
detJ = subs(detJ, [a0, a1, a2, a3, a4, a5], [0.2, 0.2,0.2, 0.2,0.2,0.2]);
detJ = subs(detJ, [d1, d2, d3, d4, d5, d6], [0.2, 0.2,0.2, 0.2,0.2,0.2]);

detJ_simple = simplify(detJ);


detJ_factor = factor(detJ_simple);

singularity_eqs = {};

for i = 1:length(detJ_factor)
    factor_i = detJ_factor(i);  
    if has(factor_i, [theta1, theta2, theta3, theta4, theta5, theta6])
        singularity_eqs{end+1} = (factor_i == 0);
    end
end

disp('Singularity equations (each must be zero):');
for i = 1:length(singularity_eqs)
    pretty(singularity_eqs{i})
end

