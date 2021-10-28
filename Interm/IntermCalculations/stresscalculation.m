%constants;
%Motor Speed
MV = 9428;
%Transverse Diametral Pitch
Pd = 16;
%Normal Pressure Angel in radian (14.5 degrees)
NormalPressureAngle = 0.2530727415;
%Helix Angel in radian (45 degrees)
HelixAngel = 0.7852981634;
%Newton to Pound Force Conversion Rate
LBC = 0.224809;
%Minutes of opertion
T = 120000;


%Tangential Transmitted Load (enter lbf)
Wt = 1483.5 * LBC;

%Face Width
F = 0.5;

%Lewis Factor from textbook table
%12 teeth
Y1 = 0.21;
%48teeth
Y2 = 0.35;

%Elastic Coefficient
Cp = 2300;

%Surface Condition Factor
Cf = 1;

%Overload Factor
Ko = 1;

%Quality number
Qv = 8;

%Addendum
a1 = 1/Pd;
a = a1;

%Speed Ratio
MG = 3;


%Transverse Pressure Angel
TransversePressureAngle = atan(tan(NormalPressureAngle)/cos(HelixAngel));

%Input Gear 1 Constants

%Number of teeth
Np1 = 12;

%Pitch diameter
dp1 = 1;

%Angular Speed 
Omega1 = MV;

%Other Gear 1 constants
%Circumference
Circumference1 = 2*pi*dp1;

%Linear Velocity
V1 = pi*dp1*Omega1/12;

%Pitch Radius
Rp1 = dp1/2;

%Base Circle Radius
rb1 = Rp1*cos(TransversePressureAngel);





%Input Gear 2 Constants

%Number of teeth
Np2 = 48;

%Pitch diameter
dp2 = 3;

%Angular Speed
Omega2 = MV/4;

%Circumference
Circumference2 = 2*pi*dp2;

%Linear Velocity
V2 = pi*dp2*Omega2/12;

%Pitch Radius
Rp2 = dp2/2;

%Base Circle Radius
rb2 = Rp2*cos(TransversePressureAngle);



%Gear 1 Calculation

%Dynamic Factor Calculation
%Qv = 8
%B
B = 0.25*((12 - Qv)^(2/3));
%A
A = 50 + 56*(1-B1);
%Dynamic factor
Kv1 = ((A + V1^(1/2))/A)^B;

%Size Factor
Ks1 = 1.192*(F*Y1^(1/2)/Pd)^0.0535;

%Load distribution factor
Cmc = 1;
Cpm = 1;
Ce = 0.8;
Cpf1 = F/(10*dp1)-0.025;
Cma1 = 0.0675 + (0.0128*F)-(0.926*(10^-4)*F^2);
%load distribution factor
Km1 = 1 + Cmc*((Cpf1*Cpm)+(Cma1*Ce));


%Rim Thickness Factor
Kb = 1;

%Bending Strength Geometry Factor J
J = 0.364;

%Surface Geometry Factor I
%Surface Strength Geometry Factor Z;
Z = (((Rp1+a)^2-rb1^2)^(1/2))+(((Rp2+a)^2)-rb2^2)^(1/2)-(Rp1+Rp2)*sin(TransversePressureAngle);
%Normal Circular Pitch
PN = pi/Pd*cos(NormalPressureAngle);
%Load Sharing Ratio MN;
MN = PN/(0.95*Z);
%Surface Geometry Factor I
I = sin(TransversePressureAngle)*cos(TransversePressureAngle)/(2*MN)*(MG/(MG+1));





%Gear 2 Calculation

%Overload factor is the same as in 1

%Dynamic Factor
%Qv = 8
%Dynamic factor
Kv2 = ((A + V2^(1/2))/A)^B;

%Size Factor
Ks2 = 1.192*(F*Y2^(1/2)/Pd)^0.0535;

%Load distribution factor
Cpf2 = F/(10*dp2)-0.025;
Cma = Cma1;
%load distribution factor
Km2 = 1 + Cmc*((Cpf2*Cpm)+(Cma*Ce));

%Rim Thickness Factor is the same as in 1

%Surface Geometry Factor is the same as in 1



%Contact Stress
%Gear 1
ContactStress1 = Cp*(((Wt*Ko*Kv1*Ks1*Km1/(dp1*F)*Cf/I)^(1/2)));
%Gear 2
ContactStress2 = Cp*((Wt*Ko*Kv2*Ks2*Km2/(dp2*F)*Cf/I)^(1/2));

%Calculation for Factor of Safety

%Brinell Hardness
HB = 321;
St = 16400 + 102 * HB;
Sc = 34300 + 349 * HB;


%Stress Cycle Factors from graph
YN1 = 0.86;
YN2 = 0.9;
ZN1 = 0.86;
ZN2 = 0.89;

%Reliability Factor (assuming r = 99%)
KR = 1;

%Temperature Factor
KT = 1;

%Hardness-Ratio Factor
CH = 1;

%Bending Factor of Safety
%Gear 1
SF1 = St*YN1/(KR*KT)/BendingStress1;
%Gear 2
SF2 = St*YN2/(KR*KT)/BendingStress2;


%Bending Stress
%Gear 1
BendingStress1 = Wt*Ko*Kv1*Ks1*Pd/F*(Km1*Kb/J);
%Gear 2
BendingStress2 = Wt*Ko*Kv2*Ks2*Pd/F*(Km2*Kb/J);

%Contact Factor of Safety
%Gear 1
SH1 = Sc*ZN1*CH/(KR*KT)/ContactStress1;
%Gear 2
SH2 = Sc*ZN2*CH/(KR*KT)/ContactStress2;








