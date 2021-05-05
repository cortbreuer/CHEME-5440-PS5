% CHEME 5440
% PS05
% Problem 3c

%% This simulates the two state methylation model
%  

clear all;
close all;

%Species
% x(1) = E0
% x(2) = E1
% x(3) = E1*
% x(4) = B
% x(5) = Bp
% x(6) = {E1*B}
% x(7) = {E1*Bp}

%Initial Conditions
x0 = [10;
    0;
    0;
    2;
    0;
    0;
    0];

%at steady state
l = 0;

%Kinetic parameters
Vr = 0.2 * 0.1; %s^-1 uM
a1f = l/(1+l);
a1r = 1/(1+l);
abp = 0.1/1000; %s^-1*uM^-1
dbp = 0.01; %s^1
kbp = 1; %s^-1
ab = 1/1000;  %s^-1 uM^-1
db = 1;  %s^-1
kb = 0;
B1 = 2.5 .* l ./ (1 +l);
k1f = 1; %s^-1 uM^-1
k1r = 1; %s^-1


%Time-span
tspan = [0 20*60] ; % time-span in sec

%ODE solver
[t_out,x_out] = ode23t(@(t,x) myODE3(t,x,Vr,a1f,a1r,abp,dbp,kbp,ab,db,kb,B1,k1f,k1r),tspan,x0);

%Reconrd E1* at SS
E1st = max(x_out(:,2));
Ast = max(x_out(:,3));
Bst = max(x_out(:,4));
Bpst = max(x_out(:,5));
Bcst = max(x_out(:,6));
Bpcst = max(x_out(:,7));

%Graphing
figure(1);
hold on;
plot(t_out./60,x_out(:,1),'-co'); % plot time in minutes
plot(t_out./60,x_out(:,2),'-ro'); % plot time in minutes
plot(t_out./60,x_out(:,3),'-ko'); % plot time in minutes
plot(t_out./60,x_out(:,4),'-mo'); % plot time in minutes
plot(t_out./60,x_out(:,5),'-go'); % plot time in minutes
plot(t_out./60,x_out(:,6),'-yo'); % plot time in minutes
plot(t_out./60,x_out(:,7),'-bo'); % plot time in minutes


legend('Eo','E1','E1*','B','Bp','{E1*B}','{E1*Bp}','Location','Best');
set(gcf,'Position', [548 171 423 334]);
set(gcf,'Color', [1 1 1]);
set(gca,'FontName','Arial');
set(gca,'FontSize',14);
set(gca,'XGrid','off');
set(gca,'YGrid','off');
xlabel('Time (min)','FontName','Arial','FontSize',14);
ylabel('Concentration (uM)','FontName','Arial','FontSize',14);
set(gca,'GridLineStyle','--');
set(gca,'TickDir','out');
box on;
grid on;
hold off;

A_store = {};

%This loop will vary the ligand concentration as specified in the paper and
%solves the differential equations. The resultant E1* values are plotted in
%their own subplot routines normalized by the steady state value obtained
%earlier

figure(2)
for j = 1:4
    %Initial Conditions
    x0 = [0;
        E1st;
        Ast;
        Bst;
        Bpst;
        Bcst;
        Bpcst];

    %At steady state
    l_store = [0.01 0.1 1 10];
    l = l_store(j);

    %Kinetic parameters
    Vr = 0.2 * 0.1; %s^-1 uM
    a1f = l/(1+l);
    a1r = 1/(1+l);
    abp = 0.1/1000; %s^-1*uM^-1
    dbp = 0.01; %s^1
    kbp = 1; %s^-1
    ab = 1/1000;  %s^-1 uM^-1
    db = 1;  %s^-1
    kb = 0;
    B1 = 2.5 .* l ./ (1 +l);
    k1f = 1; %s^-1 uM^-1
    k1r = 1; %s^-1


    %Time-span
    time_vecs = {[0 5/6*60],[0 2*60],[0 8*60],[0 18*60]};
    tspan = time_vecs{j} ; % time-span in sec

    %ODE solver
    [t_out,x_out] = ode23t(@(t,x) myODE3(t,x,Vr,a1f,a1r,abp,dbp,kbp,ab,db,kb,B1,k1f,k1r),tspan,x0);
    
    %Store A values
    A_store{j} = x_out(:,3);
    
    hold on
    subplot(4,1,j)
    plot(t_out./60,x_out(:,3)./Ast,'-ro'); % plot time in minutes

    legend('E1*','Location','Best');
    str = sprintf('Ligand Concentration: %1.2f',l);
    title(str)
    set(gcf,'Position', [548 171 423 334]);
    set(gcf,'Color', [1 1 1]);
    set(gca,'FontName','Arial');
    set(gca,'FontSize',14);
    set(gca,'XGrid','off');
    set(gca,'YGrid','off');
    xlabel('Time (min)','FontName','Arial','FontSize',14);
    ylabel('A/A^st','FontName','Arial','FontSize',14);
    set(gca,'GridLineStyle','--');
    set(gca,'TickDir','out');
    box on;
    grid on;
    hold off;
end