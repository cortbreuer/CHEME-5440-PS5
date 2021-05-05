% CHEME 5440
% PS05
% Problem 1

%% 
%  

clear all;
close all;


%Calculate phase vectors
size_test = 40;
D1_test = linspace(0,1,size_test);
D2_test = linspace(0,1,size_test);

for i = 1:size_test
    for j = 1:size_test
        dD1(j,i) = 1/(1+10*(D2_test(j)^2/(0.1+D2_test(j)^2)).^2)-D1_test(i);
        dD2(j,i) = 1/(1+10*(D1_test(i)^2/(0.1+D1_test(i)^2)).^2)-D2_test(j);
    end
end

%Calculate nullclines
D1_null = zeros(size_test,1);
D2_null = zeros(size_test,1);

for i = 1:size_test
    D1_null(i) = 1/(1+10*(D2_test(i)^2/(0.1+D2_test(i)^2)).^2);
    D2_null(i) = 1/(1+10*(D1_test(i)^2/(0.1+D1_test(i)^2)).^2);
end

% Plot results in nM values
figure(1);
quiver(D1_test,D2_test,dD1,dD2,1.5,'k')
hold on;
plot(D1_test,D2_null,'-m'); % plot time in minutes
plot(D1_null,D2_test,'-b'); % plot time in minutes
legend('Phase Vectors','D2 nullcline','D1 nullcline','Location','Best');


set(gcf,'Color', [1 1 1]);
set(gca,'FontName','Arial');
set(gca,'FontSize',14);
set(gca,'XGrid','off');
set(gca,'YGrid','off');

xlabel('D1 Concentration','FontName','Arial','FontSize',14);
ylabel('D2 Concentration','FontName','Arial','FontSize',14);
xlim([0 1])
ylim([0 1])
set(gca,'GridLineStyle','--');
set(gca,'TickDir','out');
box on;
grid on;
hold off;