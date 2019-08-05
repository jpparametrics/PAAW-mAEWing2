%% Uncsontrained, 2-DV, Quadratic Objective - Haftka Example 4.2.1
% Haftka, R. T. and Z. Gurdal (1992), Elements of Structural Optimization, 
% Kluwer Academic Publishers

%% Initialize starting point and options
clear; 
x0=[-1; -2] %#ok<*NOPTS>
options=optimset('HessUpdate','steepdesc','Display','iter',...
                 'TolFun',1e-4,'TolX',1e-4,...
                 'MaxIter',100,'MaxFunEvals',500,'LargeScale','off');

%% Steepest Descent (slow) with Finite Difference
[x_SD,~,~,outSD]=fminunc(@fHaftka4p2p1,x0,options)

%% SLP with Trust Region Strategy (not quite as slow)
%options.TrustRegion='TRAM';
options.TolOpt = 1e-2;
[x_SLP,~,~,out]=slp_trust(@fHaftka4p2p1,x0,options,[],[],@gHaftka4p2p1)
regression_check( x_SLP, [-0.33333333333; -0.5], 1e-3 );

%% BFGS Quasi-Newton (theoretically converges in 3 iterations) Finite Diff.
options=optimset(options,'HessUpdate','BFGS');
x_BFGS=fminunc(@fHaftka4p2p1,x0,options)

%% SQP (handles unconstrained by adding dummy constraint) Analytic Gradient
x_SQP=sqp(@fHaftka4p2p1,[-1; -2],options,[],[],@gHaftka4p2p1)
regression_check( x_SQP, [  -0.33333333333; -0.5] );

%% Source code

% Function evaluation 
% (N.B., MATLAB optimization toolbox 2nd output is gradient,
% instead of 2nd output being a dummy constraint vector like this one.)
type fHaftka4p2p1

% Gradient evaluation
% (N.B., MATLAB optimization toolbox has separate function 
% for nonlinear constraints and their gradients instead of
% a second function for gradients of objective and constraints
% like this one, which has a dummy constraint for use with SQP.)
type gHaftka4p2p1
