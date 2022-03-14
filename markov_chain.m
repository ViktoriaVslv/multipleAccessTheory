clc, clear, close all;

T = 10;
S = 2; %кол-во состояний
N = 10^4; % кол-во эксперементов
p = zeros(S);
p1 = zeros(S);
for i = 1:S
    [p1(i,:),p(i,:)] = randomSum(S, 1);
%     disp(sum(p1(i,:)));
end
disp(p1)


P = zeros(1,T);
P(1)=N;
for i = 1:N
    s = 0; 
    for t = 2:T
        x = rand();
        ind = 1;
        while x > p(s+1,ind)
            ind = ind + 1;
        end
        s = ind-1;

        if s == 0
            P(t)=P(t)+1;
        end
        if P(t)>N
            f=0;
        end
    end
end
a =P;


P = zeros(1,T);
P(1)=N;
for t = 2:T
    s = 0; 
    for i = 1:N
        x = rand();
        if x > p1(s+1,s+1)
            s = mod(s+1,S);
        end
        if s == 0
            P(t)=P(t)+1;
        end
    end
end
P = P/N;

temp = zeros (1,S);
temp(1)=1;
pth = zeros(T,S);
for i =2:T
    pth(i,:) = temp*p1^i;
%     pth(i)=a(1);
end
pth(1,1)=1;
% disp("P0 th t=10");
% disp(Pth(1));

disp("P0 ex t=10");
disp(P(T));

figure()
hold on;
grid on;
% plot(1:T,a/N);
plot(1:T,P);
plot(1:T,pth(:,1));

legend('практич', 'теория');

% 
% function X = randomSum(num, summ)  
%     X=rand(1,num);
%     SX=summ/sum(X);
%     X = SX*X;   
% end
function [X,diap] = randomSum(num, summ)  
    X=rand(1,num);
    SX=summ/sum(X);
    X = SX*X; 
    diap = X;
    for i=2:num
        diap(i) =diap(i)+diap(i-1);
    end
end