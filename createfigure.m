function createfigure(ymatrix1, XMatrix1, DMatrix1)
%CREATEFIGURE(ymatrix1, XMatrix1, DMatrix1)
%  YMATRIX1:  bar 矩阵数据
%  XMATRIX1:  errorbar x 矩阵数据
%  DMATRIX1:  errorbar delta 矩阵数据

%  由 MATLAB 于 08-Jun-2021 16:23:32 自动生成

% 创建 figure
figure1 = figure;
colormap(jet);

% 创建 axes
axes1 = axes('Parent',figure1,...
    'Position',[0.13 0.11 0.444822842851188 0.579858490566038]);
hold(axes1,'on');

% 使用 bar 的矩阵输入创建多行
bar1 = bar(ymatrix1,'LineWidth',2,'BarWidth',1);
set(bar1(2),'DisplayName','uncertainty',...
    'FaceColor',[0.603921568627451 0.768627450980392 0.470588235294118]);
set(bar1(1),'DisplayName','no-uncertainty','FaceAlpha',0.5,...
    'FaceColor',[0.941176470588235 0.647058823529412 0.490196078431373],...
    'EdgeColor',[0.149019607843137 0.149019607843137 0.149019607843137]);

% 使用 errorbar 的矩阵输入创建多个误差条
errorbar(XMatrix1,ymatrix1,DMatrix1,'LineStyle','none','LineWidth',2,...
    'Color',[0 0 0]);

% 创建 ylabel
ylabel('纵坐标');

% 创建 xlabel
xlabel('横坐标');

% 创建 title
title('标题');

% 取消以下行的注释以保留坐标区的 X 范围
% xlim(axes1,[0.5 3.5]);
% 取消以下行的注释以保留坐标区的 Y 范围
% ylim(axes1,[0 0.3270451261]);
% 设置其余坐标区属性
set(axes1,'FontSize',12,'LineWidth',2,'TickLength',[0 0],'XTick',[1 2 3],...
    'XTickLabel',{'10','15','20'});
% 创建 legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.370344677193805 0.636819969221196 0.198832842361038 0.0495283005513109],...
    'Orientation','horizontal',...
    'FontSize',25,...
    'FontName','Arial');

% 创建 textbox
annotation(figure1,'textbox',...
    [0.163818257607337 0.463622642106884 0.0508545227177984 0.0351981126100961],...
    'String',{'0.165±0.028'},...
    'LineStyle','--',...
    'FontSize',16,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

