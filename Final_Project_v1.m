% Create uniform mesh
clear all; close all; clc;

nx=128;                         % Number of grid points in x
ny=64;                         % Number of grid points in y
x=linspace(0,2,nx+1);          % x-Grid (location of cell faces)
y=linspace(0,1,ny+1);          % y-Grid (location of cell faces)
xm=x(1:end-1)+(x(2)-x(1))/2;   % x-Grid (location of cell centers)
ym=y(1:end-1)+(y(2)-y(1))/2;   % y-Grid (location of cell centers)
dx=xm(2)-xm(1);                % Grid spacing in x
dy=ym(2)-ym(1);                % Grid spacing in y

%setting up initial conditions, zero everywhere
u = zeros(129,65); %store velocities at face centers
v = zeros(129,65); %store velocities at face centers

u(1,:) = exp(-(y - 0.5).^2./(0.05^2)); %initialize u with jet conditions

