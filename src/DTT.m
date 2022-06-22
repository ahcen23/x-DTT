function [ TT,T,Q,Original] =DTT(N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DTT Discrete Tchebichev transform matrix and Integer Discrete Tchebichv transform Matrices .
%   Example
%   -------
%       A = im2double(imread('rice.png'));
%       D = DTT(size(A,1));
%       dtt = D*A*D';
%       figure, imshow(dtt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Check input 
validateattributes(N,{'double'},{'integer' 'scalar'},mfilename,'N',1);

if (nargin == 0) || isempty(N) 
    error('Insufficient input');
end
if (nargin == 0) || isinteger(N) 
    error('Input must be Integer');
end
if (nargin == 0) || rem(N,2)~=0 
    error('Input must be multiple of 2');
end
%format long
%% Calculations Goes Here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TT=zeros(N,N);  % reservation of memory reduces the time of calculation.
q=zeros(1,N);   % elements fo diagonal of Q matrix.
d=zeros(1,N);   % Denominator of the formula of factorization and decomposition
p=zeros(1,N);   % Numerator of the formula of factorization and decomposition
Q=zeros(N);    %the diagonal Matrix , DTT=Q*TT;
a1=zeros(1,N);
a2=zeros(1,N);
a3=zeros(1,N);
%Tii=zeros(1,N);
% a1 a2 and a3 factors 
        for K=1:N  
                a1(K)=(2/K)*(sqrt((4*(K^2) -1)./(N^2-K^2))); %calculate the a1 factor
                a2(K)=((1-N)./K)*sqrt(((4*K^2)-1)./(N^2-K^2)); % calculate the a2 factor
                a3(K)=((1-K)./K)*sqrt((2*K+1)./((2*K)-3)).*sqrt((N^2-(K-1)^2)./(N^2-(K)^2)); %calculate the a3 factor 
        end
% Define the first two Chebyshev polynomials
    T0 = @(x) (1/sqrt(N)) +0*x;  % definition the T0
    T1 = @(x) (1+2*x-N).*sqrt(3/(N*((N^2)-1)));  % definition of T1
   T00=[];%zeros(1,N);
   T11=[];%zeros(1,N);
    for x = 0:N-1
    T00=[T00 T0(x)];
    T11=[T11 T1(x)];
    end
    TT=[T00; T11];
% Amount of polynomials
if N>2   %% To ensure the 2x2 case
x = 0:N-1;
% xresu{1}=T00;
% xresu{2}=T11;
 i=2;
               Ti=(a1(i).*x+a2(i)).*T11(:,:)+ a3(i).*T00(:,:);
                TT=[TT ; Ti]  ;
 
       for i = 3:N-1
               % Apply recursive definition of Chebyshev polynomials
              Tii(1,x+1)=((a1(i).*x)+a2(i)).*TT(i,x+1)+ (a3(i).*TT(i-1,x+1));            
              TT=[TT ; Tii];
       end
end
%calculate the real diagonal matrice Q 
%calculate p(k)
                for i=0:N-1

                    if i==1
                            p(i+1)=factorial(i)*(i);
                    elseif mod(i,2)==1
                            p(i+1)=factorial(i)*(N-i);
                    elseif  mod(i,2)==0
                            p(i+1)=factorial(i)*(i+1);
                    end     
                end
%calculate d(k)                
                for k=0:N-1
                            d(k+1)=factorial(k+N)./((2*k+1)*factorial(N-k-1));
                end
d=sqrt(d);
%calculate q(k)
                for k=1:N         
                            q(k)=p(k)./d(k);
                end
%fill in the Q matrix                
                for i=1:N
                            Q(i,i)=q(i);    
                end 
 Q=inv(Q);               
%end calculation

T=Q*TT;
T=round(T);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% calculate the inverse
Original=(Q^-1)*T;

end
