
% error_x_plot = 1: 1 :30 ;
% plt_x = [error_x_plot error_x_plot(end:-1:1)];
% error_x_mean = [0.797, 0.33 , 0.173, 0.151, 0.114, 0.068, 0.086, 0.136, 0.163, 0.171, 0.166, 0.154, 0.14 , 0.13 , 0.124, 0.119, 0.123, 0.132,0.144, 0.157, 0.158, 0.145, 0.13 , 0.128, 0.15 , 0.216, 0.253,0.261, 0.406, 0.759];
% std = [0.125, 0.056, 0.013, 0.005, 0.003, 0.001, 0.003, 0.005, 0.008,0.011, 0.013, 0.014, 0.014, 0.012, 0.008, 0.007, 0.008, 0.008,0.01 , 0.012, 0.014, 0.015, 0.012, 0.007, 0.012, 0.013, 0.016,0.029, 0.045, 0.156];
% plt_y = [error_x_mean + std  error_x_mean - std];
% 
% 
% gp = fill(plt_x,plt_y,[26/255 105/255 174/255]);%定义填充区间
% gp.FaceAlpha = (0.2);%定义区间的填充颜色      
% gp.EdgeColor = 'none';%定义区间边界的填充颜色，此处不设置
% hold on
% dqn = plot(error_x_plot, error_x_mean, 'color', [0/255 128/255 255/255], 'linewidth',1);
% hold on

close all
% figure(1)
% plot(record_velocity(1:150,1))
% hold on
% plot(record_velocity(1:150,2))
% hold on
% plot(record_velocity(1:150,3))
% hold on
% plot(record_velocity(1:150,4))
% hold on
figure(2)
l2= 30
l3= 300
plot(record_velocity(l2:l3,1),'--','linewidth',2)
hold on
plot(record_velocity(l2:l3,2),'linewidth',2)
hold on
plot(record_velocity(l2:l3,3),'linewidth',2)
hold on
plot(record_velocity(l2:l3,4),'linewidth',2)
hold on
% plot(record_time(30:260,1))
figure(3)
l1 = 300
hold on
plot(abs(record_time(30:l1,1)-record_time(30:l1,2)),'linewidth',1.5)
hold on
plot(abs(record_time(30:l1,1)-record_time(30:l1,3)),'linewidth',1.5)
hold on
plot(abs(record_time(30:l1,1)-record_time(30:l1,4)),'linewidth',1.5)
hold on
figure(4)
l1 = 300
plot(abs(record_time(30:l1,1)),'linewidth',2)
hold on
plot(abs(record_time(30:l1,2)),'linewidth',2)
hold on
plot(abs(record_time(30:l1,3)),'linewidth',2)
hold on
plot(abs(record_time(30:l1,4)),'linewidth',2)
hold on
 
% 
% 
% for i = 1:cvi_change
%     h = figure(i);
%     dqn_y = tx(1, :);
%     dqn_std = std(dqn_y);
%     x = 1:1:data_num;
%     dqn_yconf = [dqn_y + dqn_std, dqn_y(end:-1:1) - dqn_std];
%     xconf = [x x(end:-1:1)] ;%构造正反向的x值，作为置信区间的横坐标值
% 
%     gp = fill(xconf,dqn_yconf,[0/255 128/255 255/255]);%定义填充区间
%     gp.FaceAlpha = (0.2);%定义区间的填充颜色      
%     gp.EdgeColor = 'none';%定义区间边界的填充颜色，此处不设置
%     hold on
%     dqn = plot(x, dqn_y, 'color', [0/255 128/255 255/255], 'linewidth',1);
%     hold on
% 
%     cvi_y = tx(3,:);
%     cvi_std = std(cvi_y);
%     cvi_yconf = [cvi_y + cvi_std, cvi_y(end:-1:1) - cvi_std];
%     cvi_p = fill(xconf,cvi_yconf,'red');%定义填充区间
%     cvi_p.FaceAlpha = (0.2);%定义区间的填充颜色      
%     cvi_p.EdgeColor = 'none';%定义区间边界的填充颜色，此处不设置
%     cvi = plot(x, cvi_y, 'r', 'linewidth',1);
%     hold on;
%     
%     m = 2 * i + 3;
%     cvi_c_y = tx(m,:);
%     c_std = std(cvi_c_y);
%     cvi_c_yconf = [cvi_c_y + c_std, cvi_c_y(end:-1:1) - c_std];
%     cvi_c_p = fill(xconf,cvi_c_yconf,[128/255 0/255 255/255]);%定义填充区间
%     cvi_c_p.FaceAlpha = (0.2);%定义区间的填充颜色      
%     cvi_c_p.EdgeColor = 'none';%定义区间边界的填充颜色，此处不设置
%     cvi_c = plot(x, cvi_c_y,'color',[128/255 0/255 255/255],'linewidth',1);
%     hold off;
%     legend([dqn,cvi,cvi_c],'DQN', 'CVI', 'CVI变体','Location','southeast');
%     set(h,'visible','off');
%     p_str = ['D:\Warehouse\Experiment_Results\moon_reward_plot\', 'cvi', '_', num2str(i), '.tif'];
%     print(h, '-dtiff', p_str)
%     
% end
% 
% for i = 1:cvi_change
%     h = figure(i+cvi_change);
%     dqn_y = tx(2, :);
%     dqn_std = std(dqn_y);
%     x = 1:1:data_num;
%     dqn_yconf = [dqn_y + dqn_std, dqn_y(end:-1:1) - dqn_std];
%     xconf = [x x(end:-1:1)] ;%构造正反向的x值，作为置信区间的横坐标值
% 
%     gp = fill(xconf,dqn_yconf,[0/255 128/255 255/255]);%定义填充区间
%     gp.FaceAlpha = (0.2);%定义区间的填充颜色      
%     gp.EdgeColor = 'none';%定义区间边界的填充颜色，此处不设置
%     hold on
%     dqn = plot(x, dqn_y, 'color', [0/255 128/255 255/255]);
%     hold on
% 
%     cvi_y = tx(4,:);
%     cvi_std = std(cvi_y);
%     cvi_yconf = [cvi_y + cvi_std, cvi_y(end:-1:1) - cvi_std];
%     cvi_p = fill(xconf,cvi_yconf,'red');%定义填充区间
%     cvi_p.FaceAlpha = (0.2);%定义区间的填充颜色      
%     cvi_p.EdgeColor = 'none';%定义区间边界的填充颜色，此处不设置
%     cvi = plot(x, cvi_y, 'r');
%     hold on;
%     
%     m = 2 * i + 4;
%     cvi_c_y = tx(m,:);
%     c_std = std(cvi_c_y);
%     cvi_c_yconf = [cvi_c_y + c_std, cvi_c_y(end:-1:1) - c_std];
%     cvi_c_p = fill(xconf,cvi_c_yconf,[128/255 0/255 255/255]);%定义填充区间
%     cvi_c_p.FaceAlpha = (0.2);%定义区间的填充颜色      
%     cvi_c_p.EdgeColor = 'none';%定义区间边界的填充颜色，此处不设置
%     cvi_c = plot(x, cvi_c_y,'color',[128/255 0/255 255/255]);
%     hold off;
%     ylim([-50 200])
%     legend([dqn,cvi,cvi_c],'DQN', 'CVI', 'CVI变体')
%     set(h,'visible','off');
%     % set(gca,'Yscale','log')
%     p_str = ['D:\Warehouse\Experiment_Results\moon_loss_plot\', 'cvi', '_', num2str(i), '.tif'];
%     print(h, '-dtiff', p_str)
%     
% end