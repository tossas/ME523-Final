function duStarStar = eq14(H_0, H_1, u1, d1, d2, dt, Re, Vel)
% This function calculates delta u star star using eqn 14. 
   
% Determine Number of unknowns
args = length(u1(1,:))*length(u1(:,1));

% Set up the right-hand side. Again; ignore the boundaries
rhs = zeros(args,1);
if strcmp(Vel,'U')
    for j = 2:length(u1(1,:))-1 % Iterate over y
        for i = 2:length(u1(:,1))-1 %Iterate over x
            rhs(i+(j-1)*length(u1(:,1))) = dt/2*(3*H_1(i,j) - H_0(i,j))...  %slightly confused about why do we multiply times the length of u1 in the index of RHS
                +dt/(2*Re)*(1/d1^2*(u1(i+1,j)-2*u1(i,j) + u1(i-1,j))...
                +1/d2^2*(u1(i,j+1)-2*u1(i,j)+u1(i,j-1)));
        end
    end
elseif strcmp(Vel,'V')
    for j = 2:length(u1(1,:))-1
        for i = 2:length(u1(:,1))-1
            rhs(i+(j-1)*length(u1(:,1))) = dt/2*(3*H_1(i,j) - H_0(i,j))...
                +dt/(2*Re)*(1/d1^2*(u1(i,j+1)-2*u1(i,j) + u1(i,j-1))...
                +1/d2^2*(u1(i+1,j)-2*u1(i,j)+u1(i-1,j)));
        end
    end
end


% Set up the operator on the left-hand-side
aw = -dt/(2*d1^2*Re)*ones(args,1);
ap = (1+dt/(d1^2*Re))*ones(args,1);
ae = -dt/(2*d1^2*Re)*ones(args,1);

% Solve using Thomas-Algorithm
duStarStar_vec = thomas(aw,ap,ae,rhs,args);

% Put back into matrix form
duStarStar = reshape(duStarStar_vec,[length(u1(:,1)),length(u1(1,:))]);
end