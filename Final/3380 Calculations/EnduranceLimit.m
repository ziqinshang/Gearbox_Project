%Endurance Limit Calculations for section 5 and 6 in the report

%Parameters Input, only change values in this section
%Enter Tensile Strength in MPa
Sut = 680;
%Choose the appropriate surface finish, 1 for ground, 2 for machine or
%cold-drawn, 3 for hot-rolled. 4 for as-forged
SurfaceFinishChoice = 2;
%Enter the diameter of the shaft in mm, for our design!!! first shaft has d =
%19.05; second shaft has d = 19.05; Third Shaft has d = 25.4
d = 19.05;
%Choose Reliability: 1 for 50%, 2 for 90%, 3 for 95%, 4 for 99%, 5 for
%99.9%, 6 for 99.99%, 7 for 99.999%, 8 for 99.9999%
ReliabilityChoice = 4;
%Enter Miscellaneous-Effects Factor
kf = 1;


%Calculations
%Rotary-beam test specimen endurance limit S'e
if Sut <= 1400
    SapostropheE = 0.5 * Sut;
else
    SapostropheE = 700;
end
%Surface Factor, ka
if SurfaceFinishChoice == 1
    a = 1.58;
    b = -0.085;
elseif SurfaceFinishChoice == 2
    a = 4.51;
    b = -0.265;
elseif SurfaceFinishChoice == 3
    a = 57.7;
    b = -0.718;
elseif SurfaceFinishChoice == 4
    a = 272;
    b = -0.995;
end
ka = a*Sut^b;
%Size Factor, kb
if d <= 51 && d >= 2.79
    kb = 1.24 * (d ^ -0.107);
elseif d<= 254 && d > 51
    kb = 1.51 * (d ^ -0.157);
end
%Loading Factor, kc
% the load should be bending, so kc = 0.59
kc = 1;
%Temperature Factor, kd
%The temperature is estimated to be room temperature at 20 degrees celsius,
%so kd = 1
kd = 1;
%Reliability Factor, ke
if ReliabilityChoice == 1
    ke = 1;
elseif ReliabilityChoice == 2
    ke = 0.897;
elseif ReliabilityChoice == 3
    ke = 0.868;
elseif ReliabilityChoice == 4
    ke = 0.814;
elseif ReliabilityChoice == 5
    ke = 0.753;
elseif ReliabilityChoice == 6
    ke = 0.702;
elseif ReliabilityChoice == 7
    ke = 0.659;
elseif ReliabilityChoice == 8
    ke = 0.620;
end

%Solving for the endurance limit at the critical location of a machine part
%in the geometry and condition of use, Se
Se = ka * kb * kc * kd * ke * kf * SapostropheE * 1000000;
%Endurance limit of shaft 1 is 118.30 MPa; Endurance limit of shaft 2 is
%also 118.30MPa; Endurance limit of shaft 3 is 114.91 MPa




%Find the stress at the stress concentration
%Find Kt using table A15
%All shaft has a fillet of 3 mm
r = 3;
%Shaft 1: D/d = 40/19.05 = 2.10, r/d = 3/19.05 = 0.1575, thus Kt = 1.57
%Shaft 2: D/d = 40/19.05 = 2.10, r/d = 3/19.05 = 0.1575, thus Kt = 1.57
%Shaft 3: D/d = 40/25.40 = 1.57, r/d = 3/25.40 = 0.1181, thus Kt = 1.72
%Change the value of q and Kt according to the different shaft
%NeuberConstant
%Needs Sut in kpsi, 1 MPa = 0.145 ksi
Sutkpsi = Sut * 0.145;
Roota = 0.246 - 3.08 * 10 ^ -3 * Sutkpsi + 1.51 * 10 ^ -5 * Sutkpsi ^ 2 - 2.67 * 10 ^ -8 * Sutkpsi ^ 3;
%Change Kt the next line according to the parameters of different shaft!!!
Kt = 1.72;
Kf = 1 + (Kt - 1)/(1 + Roota / (r * 0.0393701) ^ (1 / 2)); %1mm = 0.0393701 inch


%Solving the Reversal Stress
%For shaft one, the reversal stress is calculated at the location where 40
%mm become 19.05 mm (or at 44.425 mm in the diagram). At this location, the moment is extrapolated from the
%moment diagram as 17.67 Nm. The radius of shaft at this location is 9.525
%mm and diameter is 19.05
%For shaft two, the reversal stress is calculated at the location where 40
%mm become 19.05 mm (or at 246.625 mm in the diagram). At this location, the moment is extrapolated from the
%moment diagram as 39.482 Nm. The radius of shaft at this location is 9.525
%mm and diameter is 19.05
%For shaft three, the reversal stress is calculated at the location where 40
%mm become 25.4 mm (or at 44.425 mm in the diagram). At this location, the moment is extrapolated from the
%moment diagram as 16.61 Nm. The radius of shaft at this location is 12.7
%mm and diameter is 25.4
%Enter Moment
M = 39.482;
%Radius of shaft in m
c = d / (2 * 1000);
%Moment of Inertia in m^4
I = pi() / 64 * (d / 1000) ^ 4;
%Reversal stress in Pa
sigma = M * c / I;

%Factor of Safety
nf = Se / (sigma * Kf);

%Results:
%After inputing different parameters, the following results are obtained:

%Shaft 1:
%Se = 2.0051e+08
%Reverse Stress sigmarev = 2.6035e+07
%Kf = 1.4811
%Factor of Safety nf = 5.2

%Shaft 2:
%Se = 2.0051e+08
%Reverse Stress sigmarev = 5.8172e+07
%Kf = 1.4811
%Factor of Safety nf = 2.3273

%Shaft 3:
%Se = 1.9443e+08
%Reverse Stress sigmarev = 2.4542e+07
%Kf = 1.6077
%Factor of safety nf = 4.9280