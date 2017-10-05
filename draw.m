function draw(x, y, z, phi, theta, psi, ax)
cla; % clear the axis from previous iterations

% generate coordinates for four cylinders
[x1, y1, z1] = cylinder(.3);
[x2, y2, z2] = cylinder(.3);
[x3, y3, z3] = cylinder(.3);
[x4, y4, z4] = cylinder(.3);

% set the cylinder height (z value)
z1(2, :) = .1;
z2(2, :) = .1;
z3(2, :) = .1;
z4(2, :) = .1;

% draw the surfaces of the four cylinders
h(1) = surface(x1,y1,z1,'FaceColor','red'); % front rotor
h(2) = surface(x2,y2,z2,'FaceColor','blue'); % back rotor
h(3) = surface(x3,y3,z3,'FaceColor','red'); % front rotor
h(4) = surface(x4,y4,z4,'FaceColor','blue'); % back rotor
% alpha(0); % make the surfaces transparent

% initialize the Transformation objects
t = hgtransform('Parent',ax); % drone translation and rotation object
% Transform object for each of the four cylinders (rotors)
t1 = hgtransform('Parent',ax);
t2 = hgtransform('Parent',ax);
t3 = hgtransform('Parent',ax);
t4 = hgtransform('Parent',ax);

% set the drone Transformation object as the parent of all cylinders
for i=1:4
    set(h(i), 'Parent', t);
end
% associate each surface with its respective Transformation object
set(h(1),'Parent',t1);
set(h(2),'Parent',t2);
set(h(3),'Parent',t3);
set(h(4),'Parent',t4);

% translation and rotation matrix according to the parameters
T = makehgtform('translate', [x y z], 'xrotate', phi, 'yrotate', theta, 'zrotate', psi, 'translate', -[x y z]);
% translation matrices for each of the cylinders, to put them in their
% respective positions
T1 = makehgtform('translate', [1 1 0]);
T2 = makehgtform('translate', [1 -1 0]);
T3 = makehgtform('translate', [-1 1 0]);
T4 = makehgtform('translate', [-1 -1 0]);

% applying the transformations and rotations
set(t1, 'Matrix', T*T1);
set(t2, 'Matrix', T*T2);
set(t3, 'Matrix', T*T3);
set(t4, 'Matrix', T*T4);

% does not work for some reason
% cube_plot([x y z], [phi theta psi], 0.8, 1, 0.8, 'red'); % [x-0.4 y-1.5 z-0.4]
end