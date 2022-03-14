clc, clear, close all;

S = 3;
lambda =0.1:0.1:2;
Nth = zeros(1,length(lambda));
Dth = zeros(1,length(lambda));
L_out = zeros(1,length(lambda));

for l = 1:length(lambda)
    
    p = zeros(S+1);
    for i = 1:S
        p (1,i) = (lambda(l)^(i-1)*exp(-lambda(l)))/factorial(i-1);
    %     disp(sum(p1(i,:)));
    end
    p(1,S+1) = 1-sum(p(1,:));
    
    for i = 2:S
        ind = 1;
        for j = i-1:S-1
            p(i,j) =(lambda(l)^(ind-1)*exp(-lambda(l)))/factorial(ind-1);
            ind = ind + 1;
        end
        p(i,j+1) =1-sum(p(i,:));
    end
    p(S+1,S) = 1;
     disp(p);
    
    A = p'-eye(S+1);
    A(S+1,:) = ones(1,S+1);
    A = inv(A);
    B = zeros(S+1,1);
    B(S+1) = 1;
    pi = A*B;
    
    L_out(l) = 1 - pi(1);
    
    Nth(l) = 0;
    for i = 1:S+1
        Nth(l) = Nth(l) + (i*pi(i));
    end
    Dth(l) = Nth(l)/L_out(l);
end

% disp ("Nth: " + Nth);
% disp ("Dth: " + Dth);
% disp ("L_out th: " + L_out);



Nex = zeros(1,length(lambda));
Dex = zeros(1,length(lambda));
ex = zeros(1,length(lambda));
N = 10^6;
T = 10^4;

for i = 1:length(lambda)
    
    Ni = 0; 
    ii = 0;
    Ncount = 0;
    Di = 0; 
    t = 0; 
    
    Tn = zeros(1,N);
    for j = 2:N
        Tn(j) = -log(rand())/lambda(i)+Tn(j-1);
    end
    
    while t<T
        while Tn(Ni+1) == 0
            Ni = Ni+1;
        end
        if t <= Tn(Ni+1) 
            t = Tn(Ni+1)+1;
            Ni = Ni+1;
            ii=ii+1;
            Di = Di+1;
            Ncount = Ncount+1;
        else
           Nj = Ni+1;
           n = 0;
           while Tn(Nj) < t 
               if n < S+1
                   n = n+1;
                   Ncount = Ncount+1;
               else
                   Tn(Nj) = 0;
               end
               Nj =Nj+1;
           end
           Di = Di+t-Tn(Ni+1)+1;
           Ni = Ni+1;
            ii = ii+1;
           t = t+1;   
        end    
    end
    Nex(i) = Ncount/t;
    Dex(i) = Di/ii;
    ex(i) = ii/t;
end

figure(1)
plot(lambda, Nth,'b-o',lambda, Nex,'r-*');
grid on;
xlabel('lambda');
ylabel('N(lambda)');
legend('теор.','эксперем.');
title("Среднее число абонентов в системе");

figure(2)
plot(lambda, Dth,'b-o',lambda, Dex,'r-*');
grid on;
xlabel('lambda');
ylabel('d(lambda)');
legend('теор.','эксперем.');
title("Средняя задержка");

figure(3)
plot(lambda, ex,'b-o',lambda,L_out,'r-*');
grid on;
xlabel('lambda in');
ylabel('lambda out');
legend('теор.','эксперем.');



% function [X,diap] = randomSum(num, summ)  
%     X=rand(1,num);
%     SX=summ/sum(X);
%     X = SX*X; 
%     diap = X;
%     for i=2:num
%         diap(i) =diap(i)+diap(i-1);
%     end
% end