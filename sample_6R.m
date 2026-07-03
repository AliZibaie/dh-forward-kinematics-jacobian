clc;clear all;close all;

a_0 = 0;
alpha_0 = 0;
d_1 = 0;
theta_1 = sym('theta1');

disp('joint 1 with respect to 0')
T1 = transform_matrix(a_0, alpha_0, d_1, theta_1)

a_1 = sym('a2');
alpha_1 = -(pi/2);
d_2 = sym('d2');
theta_2 = sym('theta2') + (pi/2);

disp('joint 2 with respect to 1')
T2 = transform_matrix(a_1, alpha_1, d_2, theta_2)
disp('joint 2 with respect to 0')
T20 = link2global(a_0, alpha_0, d_1, theta_1, ...
    a_1, alpha_1, d_2, theta_2)

a_2 = 0;
alpha_2 = 0;
d_3 = 0;
theta_3 = sym('theta3') - (pi/2);

disp('joint 3 with respect to 2')
T3 = transform_matrix(a_2, alpha_2, d_3, theta_3)
disp('joint 3 with respect to 0')
T30 = link2global(a_0, alpha_0, d_1, theta_1, ...
    a_1, alpha_1, d_2, theta_2, ...
    a_2, alpha_2, d_3, theta_3)

a_3 = sym('a4');
alpha_3 = (pi/2);
d_4 = sym('d4');
theta_4 = sym('theta4') + (pi/2);

disp('joint 4 with respect to 3')
T4 = transform_matrix(a_3, alpha_3, d_4, theta_4)
disp('joint 4 with respect to 0')
T40  = link2global(a_0, alpha_0, d_1, theta_1, ...
    a_1, alpha_1, d_2, theta_2, ...
    a_2, alpha_2, d_3, theta_3, ...
    a_3, alpha_3, d_4, theta_4)

a_4 = sym('a5');
alpha_4 = -(pi/2);
d_5 = sym('d5');
theta_5 = sym('theta5');

disp('joint 5 with respect to 4')
T5 = transform_matrix(a_4, alpha_4, d_5, theta_5)
disp('joint 5 with respect to 0')
T50  = link2global(a_0, alpha_0, d_1, theta_1, ...
    a_1, alpha_1, d_2, theta_2, ...
    a_2, alpha_2, d_3, theta_3, ...
    a_3, alpha_3, d_4, theta_4, ...
    a_4, alpha_4, d_5, theta_5)

a_5 = sym('a6');
alpha_5 = (pi/2);
d_6 = sym('d6');
theta_6 = sym('theta6');

disp('joint 6 with respect to 5')
T6 = transform_matrix(a_5, alpha_5, d_6, theta_6)
disp('EndEffector with respect to 0')
[TE, RE, PE]  = link2global(a_0, alpha_0, d_1, theta_1, ...
    a_1, alpha_1, d_2, theta_2, ...
    a_2, alpha_2, d_3, theta_3, ...
    a_3, alpha_3, d_4, theta_4, ...
    a_4, alpha_4, d_5, theta_5, ...
    a_5, alpha_5, d_6, theta_6)

disp("Jacobian Matrix")
J = JacobianMatrix(...
    a_0, alpha_0, d_1, theta_1, ...
    a_1, alpha_1, d_2, theta_2, ...
    a_2, alpha_2, d_3, theta_3, ...
    a_3, alpha_3, d_4, theta_4, ...
    a_4, alpha_4, d_5, theta_5, ...
    a_5, alpha_5, d_6, theta_6)


%alpha
r_23 = RE(2,3);
r_13 = RE(1,3);

alpha = atan2(r_23,r_13)


%beta
r_31 = RE(3,1);
r_32 = RE(3,2);
r_33 = RE(3,3);

beta = atan2(sqrt(r_31^2+r_32^2),r_33)


%gamma
gamma = atan2(r_32,-r_31)

JacobianDeterminant = det(J) %its zero