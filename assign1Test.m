% --1
mc=MarkovChain([0.75;0.25], [0.99 0.01;0.03 0.97]);
b1=GaussD('Mean',0,'StDev',1);
b2=GaussD('Mean',3,'StDev',2);
h=HMM(mc, [b1; b2]);


% -- 2
Nmc = 10000; %Should be 10000
s = rand(mc,Nmc);
Ps1 = sum(s == 1)/Nmc;
Ps2 = 1 - Ps1;

% -- 3
Nh = 100000;
[x,s] = rand(h,Nh);
m = mean(x);
sigma = var(x);

% -- 4
Nplot = 500;
[x,s] = rand(h,Nplot);
figure;
plot(x);
xlabel('t');
ylabel('Observations');
title('500 continous observations from a HMM');

% -- 5
g1=GaussD('Mean',0,'StDev',1);
g2=GaussD('Mean',0,'StDev',2);
h0=HMM(mc, [g1; g2]);

Nplot0 = 500;
[x,s] = rand(h0,Nplot0);
figure;
plot(x);
xlabel('t');
ylabel('Observations');
title('500 continous observations from a HMM');

% -- 6
mcFiniteDuration = MarkovChain([0.75;0.25], [0.99 0.01 0;0.03 0.92 0.05]);
hFiniteDuration = HMM(mcFiniteDuration, [b1; b2]);
NFD = 500; 
[x,s] = rand(hFiniteDuration,NFD);
figure;
plot(s);
xlabel('t');
ylabel('Observations');
title('500 continous observations from a HMM-FiniteDuration');

% --7
mc=MarkovChain([0.75;0.25], [0.99 0.01;0.03 0.97]);
b1=GaussD('Mean',[15 15],'Covariance',[2 1; 1 4]);
b2=GaussD('Mean',[0 0],'Covariance',[1 0; 0 1]);
h=HMM(mc, [b1; b2]);
[x,s] = rand(h,300);
plot(x(1,:), x(2,:),'pb');

