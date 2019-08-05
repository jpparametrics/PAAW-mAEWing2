function [gradf,gradg] = gbeamGV( x )%gbeamGV Gradients for Gary Vanderplaats cantilever beam with N segments%        from Vanderplaats (1984) Example 5-1, pp. 147-150.x=x(:);ndv  = length(x);nelm = ndv/2;bi=1:nelm;hi=nelm+1:ndv;b = x(bi); % base width of each element in meters from cmh = x(hi); % height of each element in meters from cmP=50e3;    % NewtonsE=200e5;   % Newtons / cm^2 (Pascal x10^-4)L=500;     % Length in centimetersSigma_max = 14e3; % N/cm^2tip_max   = 2.5;  %0.03457; % centimetersInertia = b.*h.^3/12;ll = (L/nelm)*ones(nelm,1);% Objective (volume) gradientgradf = zeros(ndv,1);gradf(bi) = h.*ll;gradf(hi) = b.*ll;% Calculate gradients of lateral slopes, deflections and stressesgradg = zeros(ndv,ndv+1);suml = (1:nelm)'*L/nelm;% Stress constraint gradientsM = P * (L - suml + ll);gradg(bi,1:nelm) = diag(  -6*M./(b.^2.*h.^2) / Sigma_max );gradg(hi,1:nelm) = diag( -12*M./(b   .*h.^3) / Sigma_max );% Tip displacement constraintdyp = ( L - suml +     ll/2 ) .* (nelm-1:-1:0)';% for i = 2:nelm-1% 	 dyp(i) = dyp1(i) + dyp(i-1);% end%dyp =                       (L - suml +   ll/2);    dyp(end)=0;%dyN = -P/E*ll.^2./Inertia.*((L - suml + 2*ll/3)/2 + dyp);dyN = -P/E*ll.^2./Inertia.*((L - suml + 2*ll/3)/2 + dyp);gradg(bi,nelm+1) = dyN./b   / tip_max;gradg(hi,nelm+1) = dyN./h*3 / tip_max;% Aspect ratio constraint gradientsgradg(bi,nelm+2:end) = ( -20 )*eye(nelm);gradg(hi,nelm+2:end) =         eye(nelm);gradg = sparse( gradg );% % matfile = ['Comparison\mca_comp_' num2str(length(x)) '.mat'];%     Store=load(matfile);%     if size(Store.X,2)>1        %         Store.gradf = [Store.gradf gradf];%         Store.gradg = [Store.gradg gradg];%         save(matfile,'-struct','Store','-append')%     else%         Store.gradf = gradf;%         Store.gradg = gradg;%         save(matfile,'-struct','Store')%     endend