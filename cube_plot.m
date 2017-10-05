function cube_plot(origin, angles, X, Y, Z, color)
% CUBE_PLOT plots a cube with dimension of X, Y, Z.
%
% INPUTS:
% origin = set origin point for the cube in the form of [x,y,z].
% X      = cube length along x direction.
% Y      = cube length along y direction.
% Z      = cube length along z direction.
% color  = STRING, the color patched for the cube.
%         List of colors
%         b blue
%         g green
%         r red
%         c cyan
%         m magenta
%         y yellow
%         k black
%         w white

% ax = axes('XLim',[-7 7],'YLim',[-7 7],'ZLim',[-7 7]);
% view(3);
% grid on;

% Define the vertexes of the unit cubic
ver = [1 1 0;
    0 1 0;
    0 1 1;
    1 1 1;
    0 0 1;
    1 0 1;
    1 0 0;
    0 0 0];
%  Define the faces of the unit cubic
fac = [1 2 3 4;
    4 3 5 6;
    6 7 8 5;
    1 2 8 7;
    6 7 1 4;
    2 3 5 8];

% disp([angles(1) angles(2) angles(3)]);

ver(:,1) = ver(:,1)-X/2;
ver(:,2) = ver(:,2)-Y/2;
ver(:,3) = ver(:,3)-Z/2;

% disp(ver);

xRot = rotx(-radtodeg(angles(1)));
yRot = roty(-radtodeg(angles(2)));
zRot = rotz(-radtodeg(angles(3)));

% disp([xRot yRot zRot]);

cube = [ver(:,1)*X+origin(1),ver(:,2)*Y+origin(2),ver(:,3)*Z+origin(3)];

rotate = xRot*yRot*zRot;

for i=1:8
    cube(i,:) = cube(i,:)*rotate;
end

% disp(cube);

patch('Faces',fac,'Vertices',cube,'FaceColor',color);
end