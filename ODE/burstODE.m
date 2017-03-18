% An artificial CPG modeled as a set of ODEs
% 3 neuron neurual network: HCO + ML
% A half-center oscillator and a pacemaker( based on Morris Lecar model)


% Parameters of HCO adapted from the paper below
% "Capturing the bursting dynamics of a two-cell inhibitory network using a one-dimensional map"

% July 23, 2016
% Shanmei Liu


function dydt = burstODE(t, Y, Params)
global Vh gbarsyn gtbar;

% See Eqs. 2-6 and Appendix A1 of oringinal paper for parameter list
% Params = [1.1 1.38 -52 1 0.2 100 20 -3];

gbarsyn = Params(1); 
%gbarsyn=2.0;
gtbar = Params(2); Vh = Params(3);
tauSyn = Params(4); tgamma = Params(5);
tlo = Params(6); thi = Params(7);
vthresh = Params(8);

VK=-84;     VL=-60;     VCa=120;    VNa=180;
C=2;        phi=0.6667; V1=-12;
V2=18;      V3=-8;      V4=6.0;
gCa=4.0;    gK=8.0;     %gL=2.0;
gL=3;
Cinv=1.0/C; einh=-80;
vax=Vh;     vix=Vh;   
slope=4;    %zap=14;
zap=14;

% Additional params of Neuron0
%gL0=gL;
gL0=2.3;
zap0=20;% injected current in Neuron0
einh_ex=-20;
eexc=-20;
slope0=slope;
%vthresh0=20;
vthresh0=15;
tgamma0=tgamma;
%tauSyn0=tauSyn;
tauSyn0=5;
%gbarsyn0=gbarsyn;
gbarsyn0=1;

%Neuron1
minf=0.5*(1+tanh((Y(1)-V1)/V2));
winf=0.5*(1+tanh((Y(1)-V3)/V4));
kW=cosh((Y(1)-V3)/(2*V4));
%Neuron2
minf1=0.5*(1+tanh((Y(2)-V1)/V2));
winf1=0.5*(1+tanh((Y(2)-V3)/V4));
kW1=cosh( (Y(2) - V3) / (2 * V4) );

ax=0.5*(1+tanh(slope*(Y(1)-vax)));% For IT of N1

ax1=0.5*(1+tanh(slope*(Y(2)-vax)));% for IT of N2

%Neuron0
minf0=0.5*(1+tanh((Y(9)-V1)/V2));
winf0=0.5*(1+tanh((Y(9)-V3)/V4));
kW0=cosh((Y(9)-V3)/(2*V4));

dydt=[Cinv*(-gCa*minf*(Y(1)-VCa) - gK*Y(3)*(Y(1)-VK) - gL*(Y(1)-VL) - gtbar*ax*Y(5)*(Y(1)-VCa) - gbarsyn*Y(8)*(Y(1)-einh) - gbarsyn*Y(11)*(Y(1)-einh_ex) + zap);
Cinv * (-gCa*minf1*(Y(2)-VCa) - gK*Y(4)*(Y(2)-VK) - gL*(Y(2)-VL) - gtbar*ax1*Y(6)*(Y(2)-VCa) - gbarsyn*Y(7)*(Y(2)-einh) - gbarsyn*Y(13)*(Y(2)-einh)+ zap);
phi * (winf - Y(3)) * kW; 
phi * (winf1 - Y(4)) * kW1;
(1-Y(5))*0.5*(1 + tanh(slope*(vix-Y(1))))/tlo - Y(5)*0.5*(1 + tanh(slope*(Y(1)-vix)))/thi;
(1-Y(6))*0.5*(1 + tanh(slope*(vix-Y(2))))/tlo - Y(6)*0.5*(1 + tanh(slope*(Y(2)-vix)))/thi;
(1-Y(7))*0.5*(1 + tanh(slope*(Y(1)-vthresh)))/tgamma - Y(7)*0.5*(1 + tanh(slope*(vthresh-Y(1))))/tauSyn;
(1-Y(8))*0.5*(1 + tanh(slope*(Y(2)-vthresh)))/tgamma - Y(8)*0.5*(1 + tanh(slope*(vthresh-Y(2))))/tauSyn;
Cinv*(-gCa*minf0*(Y(9)-VCa) - gK*Y(10)*(Y(9)-VK) - gL0*(Y(9)-VL)  - gbarsyn0*Y(12)*(Y(9)-eexc) - gbarsyn0*Y(14)*(Y(9)-einh) + zap0);
phi * (winf0 - Y(10)) * kW0;
(1-Y(11))*0.5*(1 + tanh(slope0*(Y(9)-vthresh0)))/tgamma0 - Y(11)*0.5*(1 + tanh(slope0*(vthresh0-Y(9))))/tauSyn0;
(1-Y(12))*0.5*(1 + tanh(slope*(Y(1)-vthresh)))/tgamma - Y(12)*0.5*(1 + tanh(slope*(vthresh-Y(1))))/tauSyn;
(1-Y(13))*0.5*(1 + tanh(slope0*(Y(9)-vthresh0)))/tgamma0 - Y(13)*0.5*(1 + tanh(slope0*(vthresh0-Y(9))))/tauSyn0
(1-Y(14))*0.5*(1 + tanh(slope*(Y(2)-vthresh)))/tgamma - Y(14)*0.5*(1 + tanh(slope*(vthresh-Y(2))))/tauSyn];
