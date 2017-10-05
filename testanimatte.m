X = [0:0.1:1];
Y = [0:0.1:1];
Z = [0:0.1:1];
phi = [0:2*pi/length(X):2*pi];
theta = [0:2*pi/length(X):2*pi];
psi = [0:2*pi/length(X):2*pi];

% in case the drone is getting out of the visible axis frame,
% increse/decrease the maximum/minimum values for the respective axis
ax = axes('XLim',[-7 7],'YLim',[-7 7],'ZLim',[-7 7]);
view(3);
grid on;

for i=1:length(X)
    draw(X(i),Y(i),Z(i),phi(i),theta(i),psi(i), ax);
    pause(0.25);
end