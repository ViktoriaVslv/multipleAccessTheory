clc, clear, close all;
%допуск три: последняя строчка в матрице 001 определить tср досижения
%данного состояния
T = 10^6;
S = 3; %кол-во состояний

p = zeros(S);
p1 = zeros(S);
for i = 1:S
    [p1(i,:),p(i,:)] = randomSum(S, 1);
%     disp(sum(p1(i,:)));
end
disp(p1)

s = 0; 
P = zeros(1,S);
P(1)=1;

for t = 2:T
    x = rand();
    ind = 1;
    while x > p(s+1,ind)
        ind = ind + 1;
    end
    s = ind-1;
    
    P(s+1) = P(s+1)+1;
end

P = P/T;

disp("Pex:");
disp(P);

A = p1'-eye(S);
A(S,:) = ones(1,S);
A = inv(A);
B = zeros(S,1);
B(S) = 1;
x = A*B;
disp("Pth:");
disp(x');


function [X,diap] = randomSum(num, summ)  
    X=rand(1,num);
    SX=summ/sum(X);
    X = SX*X; 
    diap = X;
    for i=2:num
        diap(i) =diap(i)+diap(i-1);
    end
end