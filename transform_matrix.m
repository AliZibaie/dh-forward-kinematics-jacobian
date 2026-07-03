function [T, rotationMatrix, point] = transform_matrix(a_i_1_input, alpha_i_1_input, d_i_input, theta_i_input)
syms a_i_1 alpha_i_1 d_i theta_i
c = @cos;
s = @sin;

% member i with respect to i-1
T_i = [c(theta_i) -s(theta_i) 0 a_i_1;
    c(alpha_i_1)*s(theta_i) c(alpha_i_1)*c(theta_i) -s(alpha_i_1) -s(alpha_i_1)*d_i;
    s(alpha_i_1)*s(theta_i) s(alpha_i_1)*c(theta_i) c(alpha_i_1) c(alpha_i_1)*d_i;
    0 0 0 1];

T = subs(T_i, [a_i_1, alpha_i_1, d_i, theta_i], [a_i_1_input, alpha_i_1_input, d_i_input, theta_i_input]);
T = simplify(T);

rotationMatrix = T(1:3, 1:3);
point = T(1:3, 4);

end

%usage :
% T_test = transform_matrix(a_0, alpha_0, d_1, theta_1)