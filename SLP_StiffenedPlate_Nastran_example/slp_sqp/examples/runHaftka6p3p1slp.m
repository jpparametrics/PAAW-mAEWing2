%% Script to solve Haftka Exercise 6.3.1 using SLP
% Haftka, R. T. and Z. Gurdal (1992), Elements of Structural Optimization, 
% Kluwer Academic Publishers

%% Initialize guess for design variables and move limit bounds
clear; 
x0  = [ 1; 1];
xlb = [ 0; 0];
xub = [10; 10];

%% Initialize termination criteria tolerances
options=optimset('TolX',0.01,'TolCon',1e-3,'Display','iter');
options.MoveLimit=0.5;

%% Sequential Linear Programming with Trust Region Strategy
options.TrustRegion='merit';
[xopt,fval] = slp_trust(@fHaftka6p3p1,x0,options,xlb,xub,@gHaftka6p3p1)
regression_check( xopt, [4; 3] );

%% SLP Trust Region with Adaptive Move Limits
if exist('../private/trust_adapt','file')
   options.TrustRegion='TRAM';
   [xopt2,fval2] = slp_trust(@fHaftka6p3p1,x0,options,xlb,xub,@gHaftka6p3p1)
   regression_check( xopt2, [4; 3] );
end

%% Linear Objective function, Quadratic Constraints, 2-DV
type fHaftka6p3p1
type gHaftka6p3p1