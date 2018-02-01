% Shanmei Liu 
% April 5, 2016

global gbarsyn gtbar Vh;

% Initial conditions adapted from the HCO paper for possilbe future testing
ICS(1,1:8) = [-23.1 -54.1 0.00104 0      0.0855 0.111  0.107 0 ];
ICS(2,1:8) = [-38.7 -56.9 0.00848 0      0.122  0.0774 0.303 0 ];
ICS(3,1:14) = [-58.3 -34.1 0       0.425  0.0951 0.126  0     0.647, 20 0 0 0.015 0 0.54 ]; 
ICS(4,1:8) = [-56    5.9  0       0.58   0.161  0.0958 0     0.916 ]; 
ICS(5,1:8) = [-58.1 -18.6 0       0.591  0.137  0.121  0     0.78 ]; 
T=1500;
IC = ICS(3,:);

% 2 delays, set them same here, according to the symmetry in the neural network 
delay=[75,150];
sol = dde23(@burstDE,delay,IC,[0, T]);

%plot(sol.x,sol.y);
figure(1)
plot(sol.x,sol.y(9,:),'g', sol.x,sol.y(1,:),'r',sol.x,sol.y(2,:),'b');
legend('v0','v1','v2');

figure(2)
subplot(3,1,1)
plot(sol.x, sol.y(9,:))
xlabel('t')
ylabel('v0')

subplot(3,1,2)
plot(sol.x, sol.y(1,:))
xlabel('t')
ylabel('v1')

subplot(3,1,3)
plot(sol.x, sol.y(2,:))
xlabel('t')
ylabel('v2')



figure(3)
subplot(3,1,1)
plot(sol.x,sol.y(3,:))
xlabel('t')
ylabel('w1')

subplot(3,1,2)
plot(sol.x,sol.y(4,:))
xlabel('t')
ylabel('w2')

subplot(3,1,3)
plot(sol.x,sol.y(10,:))
xlabel('t')
ylabel('w0')

figure(4)
subplot(2,1,1)
plot(sol.x,sol.y(5,:))
xlabel('t')
ylabel('h1')

subplot(2,1,2)
plot(sol.x,sol.y(6,:))
xlabel('t')
ylabel('h2')

figure(5)
subplot(2,1,1)
plot(sol.x,sol.y(7,:))
xlabel('t')
ylabel('s12')

subplot(2,1,2)
plot(sol.x,sol.y(8,:))
xlabel('t')
ylabel('s21')

figure(6)
subplot(2,1,1)
plot(sol.x,sol.y(11,:))
xlabel('t')
ylabel('s01')

subplot(2,1,2)
plot(sol.x,sol.y(12,:))
xlabel('t')
ylabel('s10')

figure(7)
subplot(2,1,1)
plot(sol.x,sol.y(13,:))
xlabel('t')
ylabel('s02')

subplot(2,1,2)
plot(sol.x,sol.y(14,:))
xlabel('t')
ylabel('s20')
