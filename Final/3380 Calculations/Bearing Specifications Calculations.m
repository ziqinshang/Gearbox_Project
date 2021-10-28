%Bearing Specification Calculations for shaft 2 

%Point C
%input parameters
%motor speed: 9426rpm
v = 9426;
%Radial load: 781.65N for point C, change for 754.68 for point D
VFr = 781.65;
%Axial load: 19N
Fa = 19;
%input X2 and Y2
X2 = 1;
Y2 = 0;
%Reliability
Rd = 0.9;

%Estimated life
LD = v * 30000 * 60;%30kh, 60min/hour
%Fe
Fe = X2 * VFr + Y2 * Fa;
%Results using equation 11-10 in Shigley
af = 1.2;
Lr = 10^6;%For our shaft Lr = 10 * 6
C10 = af * Fe * (LD / 10 ^ 6) ^ (1 / 3);
%Results using % 11-2
%From the different inputs, it is solved that for:
%Point C: Fe = 781.65N, C10 = 24.10 kN
%Point D; Fe = 23.27kN, C10 = 23.27 kN



%Bearing Life Calculaions
%for our bearing, 60LRnR = 10 ^ 6, nD = 2356.5, C10 = 26600
sixtyLRnR = 10 ^ 6;
nD = 2356.5;
Cten = 26600;
a = 3;
L10 = sixtyLRnR / (60 * nD) * (Cten / Fe) ^ 3;
%Bearing life at point C is 278733.5
%Bearing life at point D is solved as 309697.5 by changing to appropriate
%parameters

%Using similar methods, the calculations of shaft 3 is performed as well