data = state.Data;
dataSize = size(data);
% in case the drone is getting out of the visible axis frame,
% increse/decrease the maximum/minimum values for the respective axis
ax = axes('XLim',[-7 7],'YLim',[-7 7],'ZLim',[-7 7]);
view(3);
grid on;

for i=1:dataSize(1)
    draw(data(i,1), data(i,2), data(i,3), data(i,4), data(i,5), data(i,6), ax);
    pause(0.25);
end