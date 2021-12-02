%% æ‡¿Îª≠Õº
close all;
figure(1);
for j =1:11
    plot(rec_dist(:,j), 'linewidth',2);
    hold on;
end
grid on;
title('Distance between agent and target','fontsize',15);

xlabel('Iterations','fontsize', 15);
ylabel('ditance to goal point [m]','fontsize',15);
% xlim([0 27]);
legend({'leader','agent1','agent2','agent3','agent4','agent5','agent6','agent7','agent8','agent9','agent10'},'fontsize',10      );
%% ÀŸ∂»ª≠Õº
% figure(2);
% for i = 1:11
%     plot(rec_speed(:,i), 'linewidth',2);
%     hold on;
% end
% grid on;
% title('velocity of each agents');
% 
% xlabel('Iterations','fontsize',15);
% ylabel('velocity','fontsize',15);
% % % xlim([0 27]);
% legend({'leader','agent1','agent2','agent3','agent4','agent5','agent6','agent7','agent8','agent9','agent10'},'fontsize',15);
%% ŒÛ≤Óæ‡¿Îª≠Õº
% figure(3);
% for i =2:11
%     plot(rec_dist(:,i)-rec_dist(:,1), 'linewidth',2);
%     hold on;
% end
% grid on;
% title('error of distance');
% xlabel('Iterations','fontsize',15);
% ylabel('error of distance','fontsize',15);
% % ylim([-3 3]);
% legend({'agent1','agent2','agent3','agent4','agent5','agent6','agent7','agent8','agent9','agent10'},'fontsize',15);
%% ÀŸ∂»ŒÛ≤Ó
% figure(4);
% for i =2:11
%     plot(rec_speed(:,i)-rec_speed(:,1), 'linewidth',2);
%     hold on;
% end
% % plot(rec_speed(:,3)-rec_speed(:,1), 'linewidth',2);
% % hold on;
% % plot(rec_speed(:,4)-rec_speed(:,1), 'linewidth',2);
% % hold on;
% % plot(rec_speed(:,5)-rec_speed(:,1), 'linewidth',2);
% grid on;
% 
% title('error of velocity');
% xlabel('Iterations','fontsize',15);
% ylabel('error of velocity','fontsize',15);
% % % ylim([-3 3]);
% legend({'agent1','agent2','agent3','agent4','agent5','agent6','agent7','agent8','agent9','agent10'},'fontsize',15);
% figure(5);
% title('error of each graph');
% plot(allcostValue, 'linewidth',2);
% hold on;
% plot(finecostValue, 'linewidth',2);
% hold on;
% plot(mincostValue, 'linewidth',2);
% hold on;
% xlabel('Iterations','fontsize',15);
% ylabel('Cost value','fontsize',15);
% legend({'Strongly Connected Graph','Connected subgraph','Minimal connected graph'},'fontsize',15);