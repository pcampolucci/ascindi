%% Script for 8 shaped trajectory generation

t = [0:0.005:1];
f = 1;
scale = 2;
x = scale*sin(2*pi*t*f);
y = scale*sin(2*pi*t*2*f);

dx = diff(x);
dy = diff(y);

heading = atan2(dy,dx);

% crop x and y
len_new = length(x) - 1;
x = x(1,1:len_new);
y = y(1,1:len_new);
t = t(1,1:len_new);

% build heading vectors
h_line = 0.2;
u = zeros(1,len_new);
v = zeros(1,len_new);
for i = 1:len_new
    u(i) = h_line * cos(heading(i));
    v(i) = h_line * sin(heading(i));
end

figure();
subplot(3,1,1);
scatter(x,y,'magenta'); hold on;
quiver(x,y,u,v,0,'Color','blue');
subplot(3,1,2);
plot(t,rad2deg(-heading));
subplot(3,1,3);
plot(t,x); hold on;
plot(t,y);