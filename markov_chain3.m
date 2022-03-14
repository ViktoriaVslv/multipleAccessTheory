clc, clear, close all;

N = 10^4;
S = 3; %кол-во состояний

p = zeros(S);
p1 = zeros(S);
for i = 1:S-1
    [p1(i,:),p(i,:)] = randomSum(S, 1);
end
p(S,S) = 1;
p1(S,S) = 1;
disp(p1)



T = 0;
T1 = 0;

for i = 1:N
    s = 0;
    while s~=2
        x = rand();
        ind = 1;
        while x > p(s+1,ind)
            ind = ind + 1;
        end
        s = ind-1;
        T = T+1;
    end
    s1 = 1;
    while s1~=2
        x = rand();
        ind = 1;
        while x > p(s1+1,ind)
            ind = ind + 1;
        end
        s1 = ind-1;
        T1 = T1+1;
    end
end

T = T/N;
T1 = T1/N;

disp("Tex:");
disp(T);
disp(T1);

P = p1(1:S-1,1:S-1);
A = eye(S-1)-P;
Y = ones(S-1,1);
A = inv(A);
X = A*Y;
disp("Tth:");
disp(X);

function [X,diap] = randomSum(num, summ)  
    X=rand(1,num);
    SX=summ/sum(X);
    X = SX*X; 
    diap = X;
    for i=2:num
        diap(i) =diap(i)+diap(i-1);
    end
end