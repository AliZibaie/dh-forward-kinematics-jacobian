clc; clear all; close all;

lim1 = [-90, 90];
lim2 = [-180, 90];
lim3 = [-180, 80];
lim4 = [0, 45];
lim5 = [-90, 90];
lim6 = [-15, 40];

N = 500; 

theta1 = deg2rad(lim1(1) + diff(lim1)*rand(1,N));
theta2 = deg2rad(lim2(1) + diff(lim2)*rand(1,N));
theta3 = deg2rad(lim3(1) + diff(lim3)*rand(1,N));
theta4 = deg2rad(lim4(1) + diff(lim4)*rand(1,N));
theta5 = deg2rad(lim5(1) + diff(lim5)*rand(1,N));
theta6 = deg2rad(lim6(1) + diff(lim6)*rand(1,N));


P = zeros(3,N);

for i = 1:N
    T = eye(4);
    T = link2global( ...
    0, 0, 13, theta1(i), ...
    0, -pi/2, 0, theta2(i) + pi/2, ...
    8, 0, 0, theta3(i), ...
    8, 0, 0, theta4(i) + pi/2, ...
    0, -pi/2, 0, theta5(i), ...
    0, pi/2, 0, theta6(i) - pi/2);
    P(:,i) = T(1:3,4);  
end


figure;
scatter3(P(1,:), P(2,:), P(3,:), 5, 'filled');
xlabel('X (in)');
ylabel('Y (in)');
zlabel('Z (in)');
title('6-DOF Robot Workspace (DH-Based)');
grid on;
axis equal;
view(45,30);