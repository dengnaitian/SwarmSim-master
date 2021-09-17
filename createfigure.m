function createfigure(ymatrix1, XMatrix1, DMatrix1)
%CREATEFIGURE(ymatrix1, XMatrix1, DMatrix1)
%  YMATRIX1:  bar ��������
%  XMATRIX1:  errorbar x ��������
%  DMATRIX1:  errorbar delta ��������

%  �� MATLAB �� 08-Jun-2021 16:23:32 �Զ�����

% ���� figure
figure1 = figure;
colormap(jet);

% ���� axes
axes1 = axes('Parent',figure1,...
    'Position',[0.13 0.11 0.444822842851188 0.579858490566038]);
hold(axes1,'on');

% ʹ�� bar �ľ������봴������
bar1 = bar(ymatrix1,'LineWidth',2,'BarWidth',1);
set(bar1(2),'DisplayName','uncertainty',...
    'FaceColor',[0.603921568627451 0.768627450980392 0.470588235294118]);
set(bar1(1),'DisplayName','no-uncertainty','FaceAlpha',0.5,...
    'FaceColor',[0.941176470588235 0.647058823529412 0.490196078431373],...
    'EdgeColor',[0.149019607843137 0.149019607843137 0.149019607843137]);

% ʹ�� errorbar �ľ������봴����������
errorbar(XMatrix1,ymatrix1,DMatrix1,'LineStyle','none','LineWidth',2,...
    'Color',[0 0 0]);

% ���� ylabel
ylabel('������');

% ���� xlabel
xlabel('������');

% ���� title
title('����');

% ȡ�������е�ע���Ա����������� X ��Χ
% xlim(axes1,[0.5 3.5]);
% ȡ�������е�ע���Ա����������� Y ��Χ
% ylim(axes1,[0 0.3270451261]);
% ������������������
set(axes1,'FontSize',12,'LineWidth',2,'TickLength',[0 0],'XTick',[1 2 3],...
    'XTickLabel',{'10','15','20'});
% ���� legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.370344677193805 0.636819969221196 0.198832842361038 0.0495283005513109],...
    'Orientation','horizontal',...
    'FontSize',25,...
    'FontName','Arial');

% ���� textbox
annotation(figure1,'textbox',...
    [0.163818257607337 0.463622642106884 0.0508545227177984 0.0351981126100961],...
    'String',{'0.165��0.028'},...
    'LineStyle','--',...
    'FontSize',16,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);

